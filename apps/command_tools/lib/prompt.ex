defmodule CommandTools.Prompt do
  def prompt?(_ask, true), do: true
  def prompt?(ask, false) do
    [answer|_] = String.to_charlist(IO.gets("#{ask} [y/n]: "))
    if <<answer>> == "y" || <<answer>> == "Y" do
      true
    else
      false
    end
  end
end
