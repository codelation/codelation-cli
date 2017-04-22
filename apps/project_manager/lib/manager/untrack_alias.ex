defmodule ProjectManager.Manager.UntrackAlias do
  def untrack do
    aliases = ProjectManager.Manager.IO.read_aliases()
    untrack(find_by_dir(aliases), aliases)
  end
  def untrack(name) do
    untrack(name, ProjectManager.Manager.IO.read_aliases())
  end
  def untrack(name, aliases) do
    ProjectManager.Manager.IO.write_aliases(Map.delete(aliases, name))
    atoms = ProjectManager.Manager.IO.read_atom
    if ProjectManager.Manager.Checker.atoms_exists?(atoms, name) && CommandTools.prompt?("Untrack in Atom Manager?", false) do
      atoms = case find_atom_by_title(atoms, name, 0) do
        {:ok, idx} -> List.delete_at(atoms, idx)
        _else -> atoms
      end

      ProjectManager.Manager.IO.write_atom(atoms)
    end
  end

  defp find_by_dir(aliases) do
    aux_find_by_dir(System.cwd, Map.to_list(aliases))
  end

  defp aux_find_by_dir(_dir, []), do: nil
  defp aux_find_by_dir(dir, [{name, %{"directory" => directory}} | aliases]) do
    if dir == directory do
      name
    else
      aux_find_by_dir(dir, aliases)
    end
  end

  def find_atom_by_title([], _name, _idx), do: :error
  def find_atom_by_title([%{"title" => title}|rest], name, idx) do
    if title == name do
      {:ok, idx}
    else
      find_atom_by_title(rest, name, idx + 1)
    end
  end
end
