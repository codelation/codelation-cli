defmodule ProjectManager.Manager.TrackAtom do
  def track(name, dir) do
    atoms = ProjectManager.Manager.IO.read_atom()
    track(name, dir, atoms)
  end

  def track(name, dir, atoms) do
    if ProjectManager.Manager.Checker.atoms_exists?(atoms, name) do
      a_name = ProjectManager.Manager.Ask.ask_for_name("Atom project \"#{name}\" already exists. Choose a different Atom project name")
      if a_name != false do
        track(a_name, dir, atoms)
      end
    else
      write_atom(name, dir, atoms)
    end
  end

  defp write_atom(name, dir, atoms) do
    a = %{
      "title" => name,
      "paths" => [dir],
      "icon" => ""
    }
    ProjectManager.Manager.IO.write_atom(atoms ++ [a])
  end
end
