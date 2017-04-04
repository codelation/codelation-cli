defmodule Stringify do
  def titleize(string) do
    String.replace(string, "_", " ")
    |> String.replace("-", " ")
    |> String.split(" ")
    |> Enum.map(&String.capitalize(&1))
    |> Enum.join(" ")
  end

  def underscore(string) do
    String.downcase(string)
    |> String.replace(" ", "_")
  end

  def parameterize(string) do
    String.downcase(string)
    |> String.replace(" ", "-")
    |> String.replace("_", "-")
  end

  def camelcase(string) do
    titleize(string)
    |> String.replace(" ", "")
  end
end
