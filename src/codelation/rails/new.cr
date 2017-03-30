require "file_utils"
require "readline"
require "./app"
require "../utils/*"

# Adds `rails:new` command to the Codelation CLI.
class Codelation::Rails::New
  include Codelation::Utils

  def self.add(cli)
    cli.commands.add do |cmd|
      cmd.use = "rails:new"
      cmd.short = "Generate a new app using Codelation's Rails project template"
      cmd.long = <<-LONG
        Generates a new app using Codelation's Rails project template:
            - https://github.com/codelation/rails-project-template.git
        LONG
      cmd.run { run }
    end
  end

  def self.run
    github_url = Readline.readline("Enter the project's GitHub URL (or enter an app name): ").to_s
    return if StringUtils.blank?(github_url)

    Print.print_heading("Generating New Rails Application")
    app_name = github_url.split("/").last.gsub(".git", "")

    Print.print_command("Cloning the Rails project template")
    Run.run_command("git clone https://github.com/codelation/rails-project-template.git #{app_name}")

    Print.print_command("Deleting the template's git history")
    FileUtils.rm_r("./#{app_name}/.git")

    Print.print_command("Configuring your application")
    App.replace_name(app_name)
    App.generate_secret_tokens(app_name)
    App.initialize_git_repo(app_name, github_url)
    App.install_dependencies(app_name)
    App.set_up_database(app_name)
  end
end
