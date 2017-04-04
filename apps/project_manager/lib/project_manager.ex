defmodule ProjectManager do

  @doc """
  Opens a project via apple script
  """
  def open(name, open_atom) do
    open_project(ProjectManager.Config.get_first(name), name, open_atom)
  end

  def list do
    ProjectManager.Config.list
  end

  @doc """
  Untracks the current directory project
  """
  def untrack(force) do
    untrack(Path.basename(System.cwd), force)
  end
  def untrack(name, force) do
    ProjectManager.Config.untrack_project(name, force)
  end

  @doc """
  Tracks the current directory as a project
  """
  def track(force) do
    track(Path.basename(System.cwd), force)
  end
  def track(name, force) do
    ProjectManager.Config.track_project(name, System.cwd, name, force)
  end

  def new(cmd, force), do: new(cmd, force, true)

  @doc """
  If no name is specified for the app
  """
  def new(["rails"], force, track) do
    {:ok, repo, folder, name} = ProjectManager.Projects.Rails.new_project(force)

    if track do
      ProjectManager.Config.track_project(repo, folder, name, force)
    end
  end

  @doc """
  If name is specified, skip prompt
  """
  def new(["rails"|app_name], force, track) do
    {:ok, repo, folder, name} = ProjectManager.Projects.Rails.new_project(Enum.join(app_name, " "), force)

    if track do
      ProjectManager.Config.track_project(repo, folder, name, force)
    end
  end



  #Uses Apple script to open a new tab and run a command
  defp open_project(%{"folder" => folder}, _name, true) do
    System.cmd("osascript", ["-e", "tell application \"Terminal\" to activate", "-e", "tell application \"System Events\" to tell process \"Terminal\" to keystroke \"t\" using command down", "-e", "tell application \"Terminal\" to do script \"pushd #{folder} && atom .\" in selected tab of the front window"])
  end

  defp open_project(%{"folder" => folder}, _name, false) do
    System.cmd("osascript", ["-e", "tell application \"Terminal\" to activate", "-e", "tell application \"System Events\" to tell process \"Terminal\" to keystroke \"t\" using command down", "-e", "tell application \"Terminal\" to do script \"pushd #{folder}\" in selected tab of the front window"])
  end

  defp open_project(_nil, name, _) do
    IO.puts "Couldn't find project: #{name}"
    IO.puts "Navigate to it's directory and track it with 'codelation -t'"
  end
end
