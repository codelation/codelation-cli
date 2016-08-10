require "file_utils"
require "readline"
require "./app"
require "../utils/*"

# Adds `vue:new` command to the codelation CLI.
class Codelation::Vue::New
  include Codelation::Utils

  def self.add(cli)
    cli.commands.add do |cmd|
      cmd.use = "vue:new"
      cmd.short = "Generate a new app using Codelation's Vue project template"
      cmd.long = <<-LONG
        Generates a new app using Codelation's Vue project template:
            - https://github.com/codelation/vue-project-template.git
        LONG
      cmd.run { run }
    end
  end

  def self.run
    github_url = Readline.readline("Enter the project's GitHub URL (or enter an app name): ").to_s
    return if StringUtils.blank?(github_url)

    Print.print_heading("Generating New Vue Application")
    app_name = github_url.split("/").last.gsub(".git", "")

    Print.print_command("Cloning the Vue project template")
    Run.run_command("git clone https://github.com/codelation/vue-project-template.git #{app_name}")

    Print.print_command("Deleting the template's git history")
    FileUtils.rm_r("./#{app_name}/.git")

    Print.print_command("Configuring your application")
    App.replace_name(app_name)
    App.initialize_git_repo(app_name, github_url)
    App.install_dependencies(app_name)
  end
end
