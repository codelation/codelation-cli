defmodule CommandTools.FileP do
  def write!(filename, data) do
    if !File.exists?(Path.dirname(filename)) do
      File.mkdir_p!(Path.dirname(filename))
    end
    File.write!(filename, data)
  end
end
