defmodule ProjectManager.Manager.TrackProject do
  def find_or_create_project(a) do
    {github, create_at, a} = if ProjectManager.Github.is_a_repo? do
      remote = ProjectManager.Github.find_remote
      n = ProjectManager.Github.name_from_remote(remote)
      {remote, System.system_time, n}
    else
      {"", System.system_time, a}
    end
    p_name = ProjectManager.Manager.Ask.ask_for_name("Project name", a)
    if p_name != false do
      track(p_name, github, create_at)
    end
  end
  def track(name, github, create_at) do
    projects = ProjectManager.Manager.IO.read_projects
    track(name, github, create_at, projects)
  end

  def track(name, github, create_at, projects) do
    if !ProjectManager.Manager.Checker.project_exists?(projects, name) do
      write_project(name, github, create_at, projects)
    else
      name
    end
  end

  defp write_project(name, github, create_at, projects) do
    p = %{
      "github" => github,
      "created_at" => create_at
    }

    ProjectManager.Manager.IO.write_projects(Map.put(projects, name, p))
    name
  end
end
