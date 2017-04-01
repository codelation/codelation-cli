defmodule CommandTools.Zip do
  def unzip(filename) do
    filename
    |> String.to_char_list
    |> :zip.unzip
  end

  def unzip(filename, to) do
    filename
    |> String.to_char_list
    |> :zip.unzip([:memory])
    |> (fn({:ok, data}) -> data end).()
    |> Enum.map(fn({filename, filedata}) -> CommandTools.FileP.write!(Path.join(to, filename), filedata) end)
  end
end
