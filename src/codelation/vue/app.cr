require "../utils/*"
require "inflector"

# Functions for creating a new Vue project from Codelation's project template.
class Codelation::Vue::App
  include Codelation::Utils

  TEMPLATE_FILES = [
    "vue-app/index.html",
    "bower.json",
    "package.json",
    "README.md"
  ]

  # Initialize the git repository
  def self.initialize_git_repo(app_name : String, github_url : String)
    Dir.cd(app_name) do
      Print.print_command("Initializing git repository")
      Run.run_command("git init")
      Run.run_command("git remote add origin #{github_url}.git") if github_url.includes?("://")
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
          .gsub("Vue Project Template", app_title)
          .gsub("vue-project-template", app_name)
      end
    end
  end
end
