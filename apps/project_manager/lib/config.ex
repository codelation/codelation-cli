defmodule ProjectManager.Config do
  @filename ".codelation/projects.json"
  @atom_projects ".atom/projects.cson"

  def list do
    output_project(Map.to_list(read()), 0)
  end

  defp output_project([], count), do: IO.puts "#{count} tracked projects"
  defp output_project([{repo, [%{"alias" => name, "folder" => folder, "github" => _}|_]}|rest], count) do
    heading = "#{repo}(#{name})"
    pad = 50
    IO.puts "#{String.pad_trailing(heading, pad)}#{folder}"
    output_project(rest, count + 1)
  end

  def untrack_project(repo, force) do
    projects = read()
    updated_project = case Map.fetch(read(), repo) do
      {:ok, project} -> remove_project(repo, project, force)
      :error ->
        IO.puts "Project '#{repo}' does not exist"
        %{}
    end

    write(Map.delete(projects, repo), updated_project)
  end

  defp remove_project(_repo, [], _force), do: %{}
  defp remove_project(repo, project, force) do
    if Enum.count(project) > 1 && !force do
      IO.puts "There are several tracked projects under the name '#{repo}'."
      print_project_list(project, 1)
      {ans, _} = Integer.parse(IO.gets "Which do you want to untrack: ")
      if ans == Enum.count(project) + 1 do
        %{}
      else
        %{repo => List.delete_at(project, ans - 1)}
      end
    else
      %{}
    end
  end

  defp print_project_list([], count) do
    IO.puts "#{count}. Delete all"
  end
  defp print_project_list([%{"folder" => folder, "alias" => name}|rest], count) do
    heading = "#{count}. #{name}"
    IO.puts "#{String.pad_trailing(heading, 50)}#{folder}"
    print_project_list(rest, count+1)
  end

  def track_project(repo, folder, name, force) do
    projects = read()
    updated_project = case Map.fetch(projects, repo) do
      {:ok, project} -> %{repo => add_existing(project, repo, folder, name, force)}
      :error -> add_new(repo, folder, name)
    end

    write(projects, updated_project)
  end

  defp add_existing([], repo, folder, name, _force) do
    github = if ProjectManager.Github.has_repo?(repo, false) do
      ProjectManager.Github.url_for_name(repo)
    else
      nil
    end
    [%{
      "github" => github,
      "alias" => name,
      "folder" => folder
    }]
  end
  defp add_existing([%{"folder" => curr_folder}| _rest] = project, repo, folder, name, force) do

    case folder_exists?(project, folder, 0) do
      {:ok, existing_project, idx} ->
        if CommandTools.prompt?("Project already exists for this directory, set as default?", force) do
          [existing_project] ++ List.delete_at(project, idx)
        else
          project
        end
      :error ->
        github_url = if ProjectManager.Github.is_a_repo? do
          ProjectManager.Github.find_remote
        else
          nil
        end

        if CommandTools.prompt?("Currently tracking #{curr_folder}, set this as default project?", force) do
          [%{
            "github" => github_url,
            "alias" => name,
            "folder" => folder
          }] ++ project
        else
          project ++ [%{
            "github" => github_url,
            "alias" => name,
            "folder" => folder
          }]
        end
    end
  end

  defp folder_exists?([], _search_folder, _idx), do: :error
  defp folder_exists?([%{"folder" => folder} = project|rest], search_folder, idx) do
    if folder == search_folder do
      {:ok, project, idx}
    else
      folder_exists?(rest, search_folder, idx + 1)
    end
  end

  defp add_new(repo, folder, name) do
    github_url = if ProjectManager.Github.is_a_repo?() do
      IO.puts "URL: #{inspect ProjectManager.Github.find_remote()}"
      ProjectManager.Github.find_remote()
    else
      nil
    end

    %{repo => [%{
      "github" => github_url,
      "alias" => name,
      "folder" => folder
      }]}
  end

  def read do
    if (File.exists?(config_file_name())) do
      {:ok, contents} = File.read(config_file_name())
      Poison.decode!(contents)
    else
      %{}
    end
  end

  def get_first(name) do
    projects = read()
    case Map.fetch(projects, name) do
      {:ok, [first|_rest]} -> first
      :error -> nil
    end
  end


  def write(config, project) when is_map(project) do
    full_project_list = Map.merge(config, project)
    contents = Poison.encode!(full_project_list)
    CommandTools.write_file!(config_file_name(), contents)

    # Writes the project contents for atom's project manager
    atom_projects = write_atom_config(Map.to_list(full_project_list))
    atom_contents = Poison.encode!(atom_projects)
    CommandTools.write_file!(atom_config_file_name(), atom_contents)
  end

  def write(config, _), do: write(config, %{})

  defp write_atom_config([]), do: []
  defp write_atom_config([{repo_name, [%{"folder" => folder}|_]}|rest]) do
    [
      %{
        "title" => Stringify.titleize(repo_name),
        "paths" => [folder],
        "icon" => ""
      }
    ] ++ write_atom_config(rest)
  end
  defp write_atom_config([_|rest]), do: write_atom_config(rest)

  defp config_file_name do
    Path.join(System.user_home, @filename)
  end

  defp atom_config_file_name do
    Path.join(System.user_home, @atom_projects)
  end
end
