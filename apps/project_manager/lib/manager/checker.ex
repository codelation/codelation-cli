defmodule ProjectManager.Manager.Checker do
  def project_exists?(projects, project) do
    Map.has_key?(projects, project)
  end

  def alias_exists?(aliases, name) do
    Map.has_key?(aliases, name)
  end

  def atoms_exists?([], _name), do: false
  def atoms_exists?([%{"title" => title}|rest], name) do
    if title == name do
      true
    else
      atoms_exists?(rest, name)
    end
  end
end
