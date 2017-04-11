defmodule ProjectManager.Manager.IO do
  @atom_file_name ".atom/projects.cson"
  @projects_file_name ".codelation/projects.json"
  @aliases_file_name ".codelation/aliases.json"

  def read_projects do
    if (File.exists?(projects_file_name())) do
      {:ok, contents} = File.read(projects_file_name())
      Poison.decode!(contents)
    else
      %{}
    end
  end

  def read_aliases do
    if (File.exists?(aliases_file_name())) do
      {:ok, contents} = File.read(aliases_file_name())
      Poison.decode!(contents)
    else
      %{}
    end
  end

  def read_atom do
    if (File.exists?(atom_file_name())) do
      {:ok, contents} = File.read(atom_file_name())
      Poison.decode!(contents)
    else
      []
    end
  end

  def write_projects(projects) do
    CommandTools.write_file!(projects_file_name(), Poison.encode!(projects, pretty: true))
  end

  def write_aliases(aliases) do
    CommandTools.write_file!(aliases_file_name(), Poison.encode!(aliases, pretty: true))
  end

  def write_atom(atoms) do
    CommandTools.write_file!(atom_file_name(), Poison.encode!(atoms, pretty: true))
  end

  defp atom_file_name do
    Path.join(System.user_home, @atom_file_name)
  end

  defp projects_file_name do
    Path.join(System.user_home, @projects_file_name)
  end

  defp aliases_file_name do
    Path.join(System.user_home, @aliases_file_name)
  end
end
