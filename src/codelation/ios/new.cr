require "file_utils"
require "readline"
require "./app"
require "../utils/*"

# Adds `ios:new` command to the Codelation CLI.
class Codelation::Ios::New
  include Codelation::Utils

  def self.add(cli)
    cli.commands.add do |cmd|
      cmd.use = "ios:new"
      cmd.short = "Generate a new app using Codelation's iOS project template"
      cmd.long = <<-LONG
        Generates a new app using Codelation's iOS project template:
            - https://github.com/codelation/ios-project-template
        LONG
      cmd.run { run }
    end
  end

  def self.run
    github_url = Readline.readline("Enter the project's GitHub URL (or enter an app name): ").to_s
    return if StringUtils.blank?(github_url)

    Print.print_heading("Generating New iOS Application")
    app_name = github_url.split("/").last.gsub(".git", "")

    Print.print_command("Cloning the iOS project template")
    Run.run_command("git clone https://github.com/codelation/ios-project-template.git #{app_name}")

    Print.print_command("Deleting the template's git history")
    FileUtils.rm_r("./#{app_name}/.git")

    Print.print_command("Configuring your application")
    App.replace_name(app_name)
    App.rename_directories(app_name)
    App.initialize_git_repo(app_name, github_url)
    App.install_dependencies(app_name)
  end
end
