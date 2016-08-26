require "./atom"
require "./dependencies"
require "./dot_files"
require "../utils/*"

# Adds `development:install` command to the Codelation CLI.
class Codelation::Development::Install
  include Codelation::Utils

  def self.add(cli)
    cli.commands.add do |cmd|
      cmd.use = "development:install"
      cmd.short = "Install the development tools used by Codelation"
      cmd.long = <<-LONG
        Installs the following development tools:
            - Atom.app (https://atom.io) and required packages
            - Crystal (https://crystal-lang.org)
            - Elixir (http://elixir-lang.org)
            - Node (https://nodejs.org/en/)
            - NPM (https://www.npmjs.com)
            - Postgres.app (http://postgresapp.com)
            - PSequel.app (http://www.psequel.com)
            - Ruby (https://www.ruby-lang.org) and required gems
            - Sequel Pro.app (http://www.sequelpro.com)
        LONG
      cmd.run { run }
    end
  end

  def self.run
    Print.print_heading("Installing Dependencies")
    Dependencies.install_dependencies

    Print.print_heading("Installing Atom.app")
    Atom.install_atom

    Print.print_heading("Installing Atom Packages")
    Atom.install_packages

    Print.print_heading("Installing Dot Files")
    DotFiles.install_dot_files

    Print.print_heading("Installing Postgres.app")
    Postgres.install_postgres_app

    Print.print_heading("Installing PSequel.app")
    Postgres.install_psequel_app

    Print.print_heading("Installing Ruby")
    Ruby.install_ruby

    Print.print_heading("Installing Ruby Gems")
    Ruby.install_gems

    Print.print_heading("Add Ruby Bin Path to Atom Init Script")
    Ruby.add_path_to_atom

    Print.print_heading("Installing Sequel Pro.app")
    SequelPro.install_sequel_pro
  end
end
