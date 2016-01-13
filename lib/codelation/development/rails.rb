require "fileutils"
require "thor"

module Codelation
  class Cli < Thor
  private

    def generate_rails_template(app_name)
      if app_name.nil?
        app_name = ask("Enter a name for your app: ")
      end

      # Clones the template from GitHub
      puts "Creating new Rails app..."
      `git clone https://github.com/codelation/rails-project-template.git #{app_name}`

      # moves the repo off the template repo
      FileUtils.rm_rf("./#{app_name}/.git")

      # Adds a remote if wanted
      confirm = ask("Link to GitHub Repo? [y/N] ") {|yn| yn.limit = 1, yn.validate = /[yn]/i }
      if confirm.downcase == "y"
        repo_url = ask("Enter Repo URL: ")
        Dir.chdir(app_name) do
          puts "Initalizing Repository..."
          `git init`
          puts "Adding Remote..."
          `git remote add origin #{repo_url}`
          puts "Make sure to pull any changes!"
        end
      end
    end
  end
end
