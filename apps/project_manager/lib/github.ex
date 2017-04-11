defmodule ProjectManager.Github do
  @github_org_url "https://github.com/codelation"

  def has_repo?(url, true) do
    case System.cmd("git", ["ls-remote", url], [stderr_to_stdout: true]) do
      {_, 0} -> true
      _else -> false
    end
  end

  def has_repo?(name, false) do
    case System.cmd("git", ["ls-remote", Path.join(@github_org_url, name)], [stderr_to_stdout: true]) do
      {_, 0} -> true
      _else -> false
    end
  end

  def is_a_repo? do
    case System.cmd("git", ["remote"]) do
      {_, 0} -> true
      {_, _} -> false
    end
  end

  def find_remote(remote \\ "origin") do
    {remotes, 0} = System.cmd("git", ["remote", "-v"], [stderr_to_stdout: true])
    case Regex.named_captures(Regex.compile!("#{remote}\\W*(?<remote>(.*))\\W+\\(fetch\\)"), remotes) do
      %{"remote" => remote} -> remote
      _ -> nil
    end
  end

  def name_from_remote(nil), do: ""
  def name_from_remote(""), do: ""
  def name_from_remote(remote) do
    remote
    |> String.replace(~r/\.git$/, "") # Remove ".git"
    |> String.replace(" ", "-") # Remove spaces
    |> String.split("/") # Divide path
    |> Enum.reverse # Reverse and
    |> hd # Get the first item (the name)
  end

  def url_for_name(name) do
    Path.join(@github_org_url, name)
  end

  def sftp_for_name(name) do
    Path.join(@github_org_url, name) <> ".git"
  end

  def clone(name) do
    IO.puts IO.ANSI.faint
    System.cmd("git", ["clone", url_for_name(name)])
    IO.puts IO.ANSI.faint
  end

  def clone(name, to) do
    IO.puts IO.ANSI.faint
    System.cmd("git", ["clone", url_for_name(name), to])
    IO.puts IO.ANSI.faint
  end

  def init do
    System.cmd("git", ["init"], [stderr_to_stdout: true])
  end

  def add_all do
    System.cmd("git", ["add", "."], [stderr_to_stdout: true])
  end

  def add_remote(url), do: add_remote("origin", url)
  def add_remote(remote_name, url) do
    System.cmd("git", ["remote", "add", remote_name, url], [stderr_to_stdout: true])
  end

  def commit(message \\ "CLI: Standard update") do
    System.cmd("git", ["commit", "-m", message], [stderr_to_stdout: true])
  end

  def push, do: push("origin", "master")
  def push(branch), do: push("origin", branch)
  def push(remote, branch) do
    System.cmd("git", ["push", remote, branch], [stderr_to_stdout: true])
  end
end
