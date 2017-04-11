defmodule ProjectManager.Commands.Clone do
  def clone(repo) do
    name = if String.contains?(repo, "/") do
      System.cmd("git", ["clone", repo])
      Path.basename(repo)
    else
      System.cmd("git", ["clone", ProjectManager.Github.url_for_name(repo)])
      repo
    end
    if File.exists?(name) do
      File.cd(name)
      ProjectManager.Commands.Track.track
      File.cd("..")
    end
  end

  def clone(repo, out) do
    if String.contains?(repo, "/") do
      System.cmd("git", ["clone", repo, out])
      Path.basename(repo)
    else
      System.cmd("git", ["clone", ProjectManager.Github.url_for_name(repo), out])
    end
    if File.exists?(out) do
      File.cd(out)
      ProjectManager.Commands.Track.track
      File.cd("..")
    end
  end
end
