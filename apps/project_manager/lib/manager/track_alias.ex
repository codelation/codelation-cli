defmodule ProjectManager.Manager.TrackAlias do
  def track do
    a_name = ProjectManager.Manager.Ask.ask_for_name("Alias name", Path.basename(System.cwd))
    if a_name != false do
      track(a_name)
    end
  end
  def track(name) do
    aliases = ProjectManager.Manager.IO.read_aliases
    track(name, aliases)
  end

  def track(name, aliases) do
    if ProjectManager.Manager.Checker.alias_exists?(aliases, name) do
      a_name = ProjectManager.Manager.Ask.ask_for_name("Alias \"#{name}\" already exists. Choose a different name")
      if a_name != false do
        track(a_name, aliases)
      end
    else
      write_alias(name, aliases)
    end
  end

  defp write_alias(name, aliases) do
    dir = System.cwd
    write_alias(name, aliases, dir, ProjectManager.Manager.TrackProject.find_or_create_project(name))
    ProjectManager.Manager.TrackAtom.track(name, dir)
  end

  defp write_alias(name, aliases, dir, project) do
    a = %{
      "directory" => dir,
      "project" => project
    }
    ProjectManager.Manager.IO.write_aliases(Map.put(aliases, name, a))
  end
end
