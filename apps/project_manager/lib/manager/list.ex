defmodule ProjectManager.Manager.List do
  def list do
    aliases = ProjectManager.Manager.IO.read_aliases
    IO.puts IO.ANSI.yellow<>"Tracked Projects"
    IO.puts ""
    IO.puts IO.ANSI.yellow<>String.pad_trailing("Alias", 25)<>IO.ANSI.blue<>"   Location"
    IO.puts IO.ANSI.white<>IO.ANSI.faint<>"=========================   ===================================================="<>IO.ANSI.normal
    print_aliases(Map.to_list(aliases))
  end

  defp print_aliases([]), do: :ok
  defp print_aliases([{name, %{"directory" => dir}}|rest]) do
    IO.puts IO.ANSI.yellow<>String.pad_trailing(name, 25)<>IO.ANSI.blue<>"   #{dir}"
    print_aliases(rest)
  end
end
