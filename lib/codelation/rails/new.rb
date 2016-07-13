require "fileutils"
require "thor"
require "active_support"
require "active_support/core_ext"

module Codelation
  class Cli < Thor
    desc "rails:new", "Generate a new app using Codelation's Rails project template"
    long_desc <<-LONGDESC
      Generates a new app using Codelation's Rails project template
      - https://github.com/codelation/rails-project-template.git
    LONGDESC
    def rails_new
      github_url = ask("Enter the project's GitHub URL (or enter an app name):")
      return if github_url.blank?

      print_heading("Generating New Rails Application")
      app_name = github_url.split("/").last.gsub(".git", "")

      print_command("Cloning the Rails project template")
      run_command("git clone https://github.com/codelation/rails-project-template.git #{app_name}")

      print_command("Deleting the template's git history")
      FileUtils.rm_rf("./#{app_name}/.git")

      print_command("Configuring your application")
      replace_app_name(app_name)
      generate_secret_tokens(app_name)

      Dir.chdir(app_name) do
        print_command("Initializing git repository")
        run_command("git init")
        run_command("git remote add origin #{github_url}.git")
        run_command("git add .")
        run_command('git commit -m "Initial commit"')

        print_command("Installing dependencies")
        run_command("bundle install")
        run_command("npm install")
        run_command("node_modules/.bin/bower install")

        return if no?("-----> Setup database? [y/N]")
        run_command("rake db:setup")
      end
    end

  private

    # Generate secret tokens for development and test environments
    def generate_secret_tokens(app_name)
      secrets_path = "./#{app_name}/config/secrets.yml"
      original_text = File.read(secrets_path)
      File.open(secrets_path, "w") do |file|
        file.puts original_text
          .gsub("development_secret_key_base", SecureRandom.hex(64))
          .gsub("test_secret_key_base", SecureRandom.hex(64))
      end
    end

    # The files that contain any version of "Rails Project Template" that need
    # to be replaced with the new app's name.
    # @return [Array]
    def rails_project_template_files
      [
        "config/initializers/active_admin.rb",
        "config/initializers/session_store.rb",
        "config/locales/en.yml",
        "config/application.rb",
        "config/database.yml",
        "config/routes.rb",
        "bower.json",
        "package.json",
        "README.md"
      ]
    end

    # Replaces all versions of "Rails Project Template" with the app name equivalent.
    # @param app_name [String]
    def replace_app_name(app_name)
      app_title = app_name.titleize
      app_class_name = app_name.underscore.camelize
      app_underscored_name = app_name.underscore

      rails_project_template_files.each do |file_path|
        relative_path = File.join("./#{app_name}", file_path)
        original_text = File.read(relative_path)
        File.open(relative_path, "w") do |file|
          file.puts original_text
            .gsub("Rails Project Template", app_title)
            .gsub("RailsProjectTemplate", app_class_name)
            .gsub("rails_project_template", app_underscored_name)
            .gsub("rails-project-template", app_name)
        end
      end
    end
  end
end
