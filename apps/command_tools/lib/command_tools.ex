defmodule CommandTools do
  def prompt?(ask, force), do: CommandTools.Prompt.prompt?(ask, force)
  def unzip(filename), do: CommandTools.Zip.unzip(filename)
  def unzip(filename, to), do: CommandTools.Zip.unzip(filename, to)
  def write_file!(filename, data), do: CommandTools.FileP.write!(filename, data)
  def download!(url, force), do: CommandTools.Download.download(url, force)
  def download!(url, to, force), do: CommandTools.Download.download(url, to, force)
end
