defmodule CommandTools.Zip do
  def unzip(filename) do
    System.cmd("unzip", ["-o", filename])
  end

  def unzip(filename, to) do
    System.cmd("unzip", ["-o", filename, "-d", to])
  end
end
