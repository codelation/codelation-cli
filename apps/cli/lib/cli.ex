defmodule CLI do
  @cli_version "2.0.0"

  def main(args) do
    {ops, _text, _inval} = OptionParser.parse args, switches: [install: :string, force: :boolean, help: :boolean, version: :boolean], aliases: [i: :install, f: :force, h: :help, v: :version]

    help_switch = ops[:help] || false
    version_switch = ops[:version] || false
    force = ops[:force] || false
    install = ops[:install] || false

    terminate = false
    if !terminate && help_switch do
      help()
      terminate = true
    end

    if !terminate && version_switch do
      IO.puts "Codelation CLI V#{@cli_version}"
      terminate = true
    end

    if !terminate && install do
      case DevelopmentSetup.run(install, force) do
        :ok -> :ok
        :not_found -> help("'#{install}' is not a valid option to the --install command.")
      end
      terminate = true
    end

    if !terminate do
      help()
    end
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
