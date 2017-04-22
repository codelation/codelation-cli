defmodule ProjectManager.Commands.Track do
  def track do
    IO.puts ""
    IO.puts IO.ANSI.cyan<>"Project Manager"
    ProjectManager.Manager.TrackAlias.track()
  end
  def track(name) do
    IO.puts ""
    IO.puts IO.ANSI.cyan<>"Project Manager"
    ProjectManager.Manager.TrackAlias.track(name)
  end
  def untrack do
    ProjectManager.Manager.UntrackAlias.untrack()
  end
  def untrack(name) do
    ProjectManager.Manager.UntrackAlias.untrack(name)
  end
  def list do
    ProjectManager.Manager.List.list()
  end
end
