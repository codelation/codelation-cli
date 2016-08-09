require "../utils/*"
require "inflector"
require "readline"
require "secure_random"

# Functions for creating a new Rails project from Codelation's project template.
class Codelation::Rails::App
  include Codelation::Utils

  TEMPLATE_FILES = [
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

  # Generate secret tokens for development and test environments
  def self.generate_secret_tokens(app_name : String)
    secrets_path = "./#{app_name}/config/secrets.yml"
    original_text = File.read(secrets_path)
    File.open(secrets_path, "w") do |file|
      file.puts original_text
        .gsub("development_secret_key_base", SecureRandom.hex(64))
        .gsub("test_secret_key_base", SecureRandom.hex(64))
    end
  end

  # Initialize the git repository
  def self.initialize_git_repo(app_name : String, github_url : String)
    Dir.cd(app_name) do
      Print.print_command("Initializing git repository")
      Run.run_command("git init")
      Run.run_command("git remote add origin #{github_url}.git")
      Run.run_command("git add .")
      Run.run_command("git commit -m 'Initial commit'")
    end
  end

  # Install Ruby, Node, and Bower dependencies
  def self.install_dependencies(app_name : String)
    Dir.cd(app_name) do
      Print.print_command("Installing dependencies")
      Run.run_command("bundle install")
      Run.run_command("npm install")
      Run.run_command("node_modules/.bin/bower install")
    end
  end

  # Replaces all versions of "Rails Project Template" with the app name equivalent.
  def self.replace_name(app_name : String)
    app_title = Inflector.titleize(app_name)
    app_underscored_name = Inflector.underscore(app_name)
    app_class_name = Inflector.camelize(app_underscored_name)

    TEMPLATE_FILES.each do |file_path|
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

  # Create and seed the new app's database
  def self.set_up_database(app_name : String)
    answer = Readline.readline("-----> Set up database? [y/N] ").to_s.downcase
    return unless answer == "y" || answer == "yes"

    Dir.cd(app_name) do
      Run.run_command("rake db:setup")
    end
  end
end
