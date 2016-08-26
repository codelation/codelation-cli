require "readline"
require "./utils/*"

# Adds `setup` command to the Codelation CLI.
class Codelation::Setup
  include Codelation::Utils

  def self.add(cli)
    cli.commands.add do |cmd|
      cmd.use = "setup"
      cmd.short = "Perform the setup tasks on any newly cloned Codelation project"
      cmd.long = <<-LONG
        Installs dependencies and optionally sets up the database for any Codelation project.
                  Project types include: Crystal, Electron, iOS, Phoenix, Rails, Vue
        LONG
      cmd.run { run }
    end
  end

  # Installs bower components. Also installs bower globally if not installed
  def self.bower_install
    return unless File.exists?("bower.json")
    bower = `which bower`
    `npm install bower -g` if bower == ""
    Run.run_command("bower install")
  end

  # Installs crystal dependencies
  def self.crystal_install
    return unless File.exists?("shard.yml")
    Run.run_command("crystal deps")
  end

  # Installs iOS dependencies. Also installs cocoapods gem if not installed
  def self.ios_install
    return unless File.exists?("Podfile")
    pod = `which pod`
    `gem install cocoapods` if pod == ""
    Run.run_command("pod install")
  end

  # Installs npm packages
  def self.npm_install
    return unless File.exists?("package.json")
    Run.run_command("npm install")
  end

  # Installs hex packages and creates the database if confirmed
  def self.phoenix_install
    return unless File.exists?("mix.exs")
    Run.run_command("mix deps.get")

    answer = Readline.readline("-----> Set up database? [y/N] ").to_s.downcase
    return unless answer == "y" || answer == "yes"
    Run.run_command("mix ecto.create")
    Run.run_command("mix ecto.migrate")
  end

  # Installs Ruby gems and creates the database if confirmed
  def self.rails_install
    return unless File.exists?("Gemfile")
    Run.run_command("bundle install")

    answer = Readline.readline("-----> Set up database? [y/N] ").to_s.downcase
    return unless answer == "y" || answer == "yes"
    Run.run_command("rake db:setup")
  end

  def self.run
    Print.print_heading("Installing project dependences")
    bower_install
    crystal_install
    ios_install
    npm_install
    phoenix_install
    rails_install
  end
end
