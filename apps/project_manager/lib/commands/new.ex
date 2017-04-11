defmodule ProjectManager.Commands.NewCommand do
  @doc """
  If no name is specified for the app
  """
  def new(["rails"], force) do
    {:ok, _repo, folder, name, raw_name} = ProjectManager.Projects.Rails.new_project(force)

    if File.exists?(folder) do
      File.cd(folder)
      ProjectManager.Commands.Track.track
      File.cd("..")
    end
  end

  @doc """
  If name is specified, skip prompt
  """
  def new(["rails"|app_name], force) do
    {:ok, _repo, folder, name, raw_name} = ProjectManager.Projects.Rails.new_project(Enum.join(app_name, " "), force)

    if File.exists?(folder) do
      File.cd(folder)
      ProjectManager.Commands.Track.track
      File.cd("..")
    end
  end
end
