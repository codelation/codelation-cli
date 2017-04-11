defmodule ProjectManager.Commands.Open do
  def open_alias(name, open_atom \\ false) do
    aux_open_alias(ProjectManager.Manager.IO.read_aliases[name], name, open_atom)
  end

  #Uses Apple script to open a new tab and run a command
  defp aux_open_alias(%{"directory" => folder}, _name, true) do
    System.cmd("osascript", ["-e", "tell application \"Terminal\" to activate", "-e", "tell application \"System Events\" to tell process \"Terminal\" to keystroke \"t\" using command down", "-e", "tell application \"Terminal\" to do script \"pushd #{folder} && atom .\" in selected tab of the front window"])
  end

  defp aux_open_alias(%{"directory" => folder}, _name, false) do
    System.cmd("osascript", ["-e", "tell application \"Terminal\" to activate", "-e", "tell application \"System Events\" to tell process \"Terminal\" to keystroke \"t\" using command down", "-e", "tell application \"Terminal\" to do script \"pushd #{folder}\" in selected tab of the front window"])
  end

  defp aux_open_alias(_nil, name, _) do
    IO.puts IO.ANSI.red<>"Couldn't find project: #{name}"
    IO.puts IO.ANSI.cyan<>"Navigate to it's directory and track it with 'codelation -t'"
  end
end
