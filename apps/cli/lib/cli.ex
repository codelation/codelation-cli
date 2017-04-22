defmodule CLI do
  @cli_version "2.1.6"

  @switches [
    force: :boolean,
    help: :boolean,
    version: :boolean
  ]

  @aliases [
    f: :force,
    h: :help,
    v: :version
  ]

  def main(args) do
    {ops, text, _inval} = OptionParser.parse args, switches: @switches, aliases: @aliases

    force = ops[:force] || false

    IO.puts ""
    exec(ops, text, force)
    IO.puts IO.ANSI.normal<>""
  end

  # Aliases
  defp exec(args, ["h"|cmd], force), do: exec(args, ["help"|cmd], force)
  defp exec(args, ["v"|cmd], force), do: exec(args, ["version"|cmd], force)
  defp exec(args, ["i"|cmd], force), do: exec(args, ["install"|cmd], force)
  defp exec(args, ["n"|cmd], force), do: exec(args, ["new"|cmd], force)
  defp exec(args, ["t"|cmd], force), do: exec(args, ["track"|cmd], force)
  defp exec(args, ["l"|cmd], force), do: exec(args, ["list"|cmd], force)
  defp exec(args, ["u"|cmd], force), do: exec(args, ["untrack"|cmd], force)
  defp exec(args, ["o"|cmd], force), do: exec(args, ["open"|cmd], force)
  defp exec(args, ["oa"|cmd], force), do: exec(args, ["open", "with", "atom"|cmd], force)


  # Commands
  defp exec(_, ["version"|_], _force), do: exec([version: true], nil, nil)
  defp exec([version: true], _text, _force) do
    IO.puts IO.ANSI.cyan<>"Codelation CLI #{IO.ANSI.yellow}V#{@cli_version}"
  end

  defp exec(_, ["help"|_], _force), do: exec([help: true], nil, nil)
  defp exec([help: true], _text, _force) do
    help()
  end

  defp exec(_, ["install"|cmd], force) do
    case DevelopmentSetup.run(cmd, force) do
      :ok -> :ok
      :not_found -> help("'#{cmd}' is not a valid option to the 'install' command.")
    end
  end

  defp exec(_, ["new"|cmd], force) do
    ProjectManager.Commands.NewCommand.new(cmd, force)
  end

  defp exec(_, ["track"], _force) do
    ProjectManager.Commands.Track.track()
  end
  defp exec(_, ["track"|cmd], _force) do
    ProjectManager.Commands.Track.track(Enum.join(cmd, " "))
  end

  defp exec(_, ["list"], _force) do
    ProjectManager.Commands.Track.list()
  end

  defp exec(_, ["untrack"], _force) do
    ProjectManager.Commands.Track.untrack()
  end
  defp exec(_, ["untrack"|cmd], _force) do
    ProjectManager.Commands.Track.untrack(Enum.join(cmd, " "))
  end

  defp exec(_, ["open", "with", "atom"|cmd], _force) do
    ProjectManager.Commands.Open.open_alias(Enum.join(cmd, " "), true)
  end

  defp exec(_, ["open"|cmd], _force) do
    ProjectManager.Commands.Open.open_alias(Enum.join(cmd, " "), false)
  end

  defp exec(_, ["clone"], _force), do: help("clone command requires repo name or url")
  defp exec(_, ["clone", repo], _force) do
    ProjectManager.Commands.Clone.clone(repo)
  end
  defp exec(_, ["clone", repo, out], _force) do
    ProjectManager.Commands.Clone.clone(repo, out)
  end

  defp exec(_, [], _force) do
    help()
  end

  defp exec(_, text, _force) do
    help("#{Enum.join(text)} is not a valid command")
  end

  defp help(banner \\ false) do
    IO.puts IO.ANSI.cyan<>"Codelation CLI #{IO.ANSI.yellow}V#{@cli_version}"
    if banner do
      IO.puts ""
      IO.puts IO.ANSI.red<>"\t#{banner}"
      IO.puts ""
    end
    IO.puts ""
    IO.puts IO.ANSI.blue<>"\tExamples:"
    IO.puts IO.ANSI.cyan<>"\t\tcodelation install all          #{IO.ANSI.white}Installs all packages"
    IO.puts IO.ANSI.cyan<>"\t\tcodelation install all -f       #{IO.ANSI.white}Installs all packages without prompting"
    IO.puts IO.ANSI.cyan<>"\t\tcodelation install atom         #{IO.ANSI.white}Installs atom"
    IO.puts ""
    IO.puts IO.ANSI.blue<>"\tCommands:"
    IO.puts IO.ANSI.cyan<>"\t\thelp/h                           #{IO.ANSI.white}Shows this message"
    IO.puts IO.ANSI.cyan<>"\t\tversion/-v                       #{IO.ANSI.white}Shows the version of this tool"
    IO.puts IO.ANSI.cyan<>"\t\tnew/n cmd                        #{IO.ANSI.white}Creates a new project.  cmd can be one of the folling"
    IO.puts ""
    IO.puts IO.ANSI.cyan<>"\t\t      rails [name]   #{IO.ANSI.white}- new rails project with the optional name"
    IO.puts ""
    IO.puts IO.ANSI.cyan<>"\t\ttrack/t [name]                   #{IO.ANSI.white}Tracks the current directory for Atom Project Manager and cmd line quick actions"
    IO.puts IO.ANSI.cyan<>"\t\tlist/l                           #{IO.ANSI.white}Lists all tracked projects"
    IO.puts IO.ANSI.cyan<>"\t\tuntrack/u [name]                 #{IO.ANSI.white}Untracks the current directory or the given name"
    IO.puts IO.ANSI.cyan<>"\t\topen/o name                      #{IO.ANSI.white}Opens a terminal to the project by tracked alias name"
    IO.puts IO.ANSI.cyan<>"\t\topen with atom/oa name           #{IO.ANSI.white}Opens a terminal and atom to the project by tracked alias name"
    IO.puts IO.ANSI.cyan<>"\t\tclone name                     #{IO.ANSI.white}Clones a project by name from Codelations Organization or by the url and tracks"
    IO.puts IO.ANSI.cyan<>"\t\tinstall/i cmd                    #{IO.ANSI.white}Used to install assets. 'cmd' can be any one of the following"
    IO.puts ""
    IO.puts IO.ANSI.cyan<>"\t\t      all            #{IO.ANSI.white}- Everything is installed/Same as empty"
    IO.puts IO.ANSI.cyan<>"\t\t      atom           #{IO.ANSI.white}- Atom is installed with prompts for packages and config"
    IO.puts IO.ANSI.cyan<>"\t\t      atom-packages  #{IO.ANSI.white}- Atom packages are installed"
    IO.puts IO.ANSI.cyan<>"\t\t      atom-config    #{IO.ANSI.white}- Atom config is installed"
    IO.puts IO.ANSI.cyan<>"\t\t      postgres       #{IO.ANSI.white}- Postgres is installed"
    IO.puts IO.ANSI.cyan<>"\t\t      brew           #{IO.ANSI.white}- Brew packages are installed"
    IO.puts IO.ANSI.cyan<>"\t\t      gems           #{IO.ANSI.white}- Gems are installed"
    IO.puts IO.ANSI.cyan<>"\t\t      ruby           #{IO.ANSI.white}- Ruby is installed"
    IO.puts IO.ANSI.cyan<>"\t\t      config         #{IO.ANSI.white}- The config dot files are installed"
    IO.puts ""
    IO.puts IO.ANSI.cyan<>"\t\t--force/-f                       #{IO.ANSI.white}Does not prompt the user (for silent installs)"
  end
end
