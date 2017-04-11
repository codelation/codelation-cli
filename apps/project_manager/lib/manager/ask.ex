defmodule ProjectManager.Manager.Ask do
  def ask_for_name(text) do
    ask_for_name(text, "")
  end
  def ask_for_name(text, default) do
    text_add = if empty?(default) do
      " ('false' to skip): "
    else
      " [#{default}] ('false' to skip): "
    end
    name = IO.gets IO.ANSI.yellow<>text <> text_add
    if String.trim(name) == "false" || String.trim(name) == "f" do
      false
    else
      if empty?(name) && empty?(default) do
        IO.puts IO.ANSI.red<>"Invalid response"
        ask_for_name(text, default)
      else
        if empty?(name) do
          String.trim default
        else
          String.trim name
        end
      end
    end
  end

  defp empty?(string) do
    (String.trim(string) |> String.length) < 1
  end
end
