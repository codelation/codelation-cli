defmodule CLI do
  @cli_version "2.0.2"

  @switches [
    install: :string,
    track: :boolean,
    untrack: :boolean,
    list: :boolean,
    new: :boolean,
    open: :string,
    atom: :boolean,
    force: :boolean,
    help: :boolean,
    version: :boolean
  ]

  @aliases [
    i: :install,
    t: :track,
    n: :new,
    o: :open,
    l: :list,
    u: :untrack,
    a: :atom,
    f: :force,
    h: :help,
    v: :version
  ]

  def main(args) do
    {ops, text, inval} = OptionParser.parse args, switches: @switches, aliases: @aliases

    force = ops[:force] || false

    exec(ops, text, force)

    #
    #

    #
    # terminate = false
    # if !terminate && help_switch do
    #   help()
    #   terminate = true
    # end
    #
    # if !terminate && version_switch do
    #   IO.puts "Codelation CLI V#{@cli_version}"
    #   terminate = true
    # end
    #
    # if !terminate && install do
    #   case DevelopmentSetup.run(install, force) do
    #     :ok -> :ok
    #     :not_found -> help("'#{install}' is not a valid option to the --install command.")
    #   end
    #   terminate = true
    # end
    #
    # if !terminate do
    #   help()
    # end
  end

  defp exec([version: true], text, force) do
    IO.puts "Codelation CLI V#{@cli_version}"
  end

  defp exec([help: true], text, force) do
    help()
  end

  defp exec([new: true, untrack: true], text, force) do
    ProjectManager.new(text, force, false)
  end

  defp exec([new: true], text, force) do
    ProjectManager.new(text, force)
  end

  defp exec([list: true], _, _force) do
    ProjectManager.list
  end

  defp exec([untrack: true], [], force) do
    ProjectManager.untrack(force)
  end

  defp exec([untrack: true], text, force) do
    ProjectManager.untrack(Enum.join(text, " "), force)
  end

  defp exec([track: true], [], force) do
    ProjectManager.track(force)
  end

  defp exec([track: true], text, force) do
    ProjectManager.track(Enum.join(text, " "), force)
  end

  defp exec([open: project], _text, _force) do
    ProjectManager.open(project, false)
  end
  defp exec([open: project, atom: true], _text, _force) do
    ProjectManager.open(project, true)
  end

  defp exec([install: cmd], _text, force) do
    case DevelopmentSetup.run(cmd, force) do
      :ok -> :ok
      :not_found -> help("'#{cmd}' is not a valid option to the --install command.")
    end
  end

  defp exec(_, _text, _force) do
    help()
  end

  defp help(banner \\ false) do
    IO.puts "Codelation CLI V#{@cli_version}"
    if banner do
      IO.puts ""
      IO.puts "\t#{banner}"
      IO.puts ""
    end
    IO.puts ""
    IO.puts "\tExamples:"
    IO.puts "\t\tcodelation --install all          Installs all packages"
    IO.puts "\t\tcodelation --install all -f       Installs all packages without prompting"
    IO.puts "\t\tcodelation --install atom         Installs atom"
    IO.puts ""
    IO.puts "\tCommands:"
    IO.puts "\t\t--help/-h                         Shows this message"
    IO.puts "\t\t--version/-v                      Shows the version of this tool"
    IO.puts "\t\t--install/-i cmd                  Used to install assets. 'cmd' can be any one of the following"
    IO.puts ""
    IO.puts "\t\t        all           - Everything is installed"
    IO.puts "\t\t        atom          - Atom is installed with prompts for packages and config"
    IO.puts "\t\t        atom-packages - Atom packages are installed"
    IO.puts "\t\t        atom-config   - Atom config is installed"
    IO.puts "\t\t        postgres      - Postgres is installed"
    IO.puts "\t\t        brew          - Brew packages are installed"
    IO.puts "\t\t        gems          - Gems are installed"
    IO.puts "\t\t        ruby          - Ruby is installed"
    IO.puts "\t\t        config        - The config dot files are installed"
    IO.puts ""
    IO.puts "\t\t--force/-f                        Does not prompt the user (for silent installs)"
    IO.puts ""
  end
end
