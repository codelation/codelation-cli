defmodule ProjectManager.Projects.Rails do
  @rails_template "rails-project-template"
  @project_file_indicator "Gemfile"
  @template_files [
    "config/initializers/active_admin.rb",
    "config/initializers/session_store.rb",
    "config/locales/en.yml",
    "config/application.rb",
    "config/database.yml",
    "config/routes.rb",
    "package.json",
    "README.md"
  ]

  alias ProjectManager.Github

  def new_project(force) do
    name = IO.gets "Enter a name for your project: "
    new_project(name, force)
  end

  def new_project(name, force) do
    IO.puts "Generating New Rails Application"
    raw_name = name
    name = String.replace(name, " ", "_") |> String.downcase
    repo = if Github.has_repo?(name, false) && CommandTools.prompt?("Found GitHub repo at #{Github.url_for_name(name)}.  Would you like to set this as your origin?", force) do
      name
    else
      if CommandTools.prompt?("Link project to a GitHub url?", force) do
        IO.gets IO.ANSI.yellow<>"Enter a name or url: "
        |> Github.name_from_remote
      end
    end
    IO.puts IO.ANSI.cyan<>"Cloning the Rails project template"
    Github.clone(@rails_template, name)
    IO.puts IO.ANSI.cyan<>"Deleting the template's git history"
    File.rm_rf!("./#{name}/.git")
    IO.puts IO.ANSI.cyan<>"Configuring your application"
    rename_app(name)
    regenerate_secret_tokens(name)
    initialize_git_repo(name, repo, force)
    set_up_database(name, force)
    IO.puts IO.ANSI.green<>"Done."
    {:ok, repo || name, Path.join(System.cwd, name), name, raw_name}
  end

  @doc """
  Initialize the git repository
  """
  def initialize_git_repo(app_name, remote_name, force) do
    changed = if !in_project_dir?() do
      File.cd app_name
      true
    else
      false
    end

    Github.init()
    if Github.is_a_repo?() do
      Github.add_all()
      Github.commit("Initial Commit")
      if remote_name do
        Github.add_remote(remote_name)
        if Github.has_repo?(remote_name, false) && CommandTools.prompt?("Would you like to push the project to Github?", force) do
          Github.push()
        end
      end
    else
      IO.puts IO.ANSI.red<>"Didn't find git repo"
    end
    if changed do
      File.cd ".."
    end
  end

  @doc """
  Create and seed the new app's database
  """
  def set_up_database(app_name, force) do
    if CommandTools.prompt?("Set up database?", force) do
      File.cd app_name
      System.cmd("rake", ["db:setup"])
      File.cd ".."
    end
  end

  @doc """
  Regenerates the Secret hashs in the secrets.yml file
  """
  def regenerate_secret_tokens(app_name) do
    changed = if !in_project_dir?() do
      File.cd app_name
      true
    else
      false
    end

    secrets_path = "./config/secrets.yml"
    original_text = File.read!(secrets_path)

    dev_r = ~r/(?:development:.*\n\W*secret_key_base:\W)([a-z0-9]*)/
    test_r = ~r/(?:test:.*\n\W*secret_key_base:\W)([a-z0-9]*)/

    new_text = String.replace(original_text, dev_r, "development:\n  secret_key_base: #{random_hash()}")
    |> String.replace(test_r, "test:\n  secret_key_base: #{random_hash()}")

    File.write!(secrets_path, new_text)

    if changed do
      File.cd ".."
    end
  end

  @doc """
  Renames all of the references to the old app name to the new app name
  """
  def rename_app(new_name, old_name \\ "Rails Project Template") do
    changed = if !in_project_dir?() do
      if File.exists?(old_name) do
        File.cd old_name
        true
      else
        if File.exists?(new_name) do
          File.cd new_name
          true
        else
          false
        end
      end
    else
      false
    end

    n_title = Stringify.titleize(new_name)
    o_title = Stringify.titleize(old_name)

    n_param = Stringify.parameterize(new_name)
    o_param = Stringify.parameterize(old_name)

    n_underscore = Stringify.underscore(new_name)
    o_underscore = Stringify.underscore(old_name)

    n_class_name= Stringify.camelcase(new_name)
    o_class_name = Stringify.camelcase(old_name)


    Enum.map(@template_files, fn (file) ->
      case File.read(file) do
        {:ok, contents} ->
            contents = contents
            |> String.replace(o_title, n_title)
            |> String.replace(o_underscore, n_underscore)
            |> String.replace(o_class_name, n_class_name)
            |> String.replace(o_param, n_param)
            File.write!(file, contents)
        _ -> :ok
      end
    end)

    if changed do
      File.cd ".."
    end
  end

  # Check if working directory is in project
  defp in_project_dir? do
    if File.exists?(@project_file_indicator) do
      true
    else
      false
    end
  end

  defp random_hash(length \\ 64) do
    :crypto.strong_rand_bytes(length) |> Base.encode16(case: :lower)
  end
end
