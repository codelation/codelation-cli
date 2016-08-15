require "../utils/*"
require "inflector"

# Functions for creating a new iOS project from Codelation's project template.
class Codelation::Ios::App
  include Codelation::Utils

  RENAME_DIRECTORIES = [
    "ios-project-template",
    "ios-project-template.xcodeproj",
    "ios-project-template.xcworkspace"
  ]

  TEMPLATE_FILES = [
    "config/webpack/production.js",
    "ios-project-template/AppDelegate.swift",
    "ios-project-template/IpcNavigation.swift",
    "ios-project-template/TabBarController.swift",
    "ios-project-template/VueViewController.swift",
    "ios-project-template/VueWebView.swift",
    "ios-project-template.xcodeproj/project.pbxproj",
    "ios-project-template.xcodeproj/project.xcworkspace/contents.xcworkspacedata",
    "ios-project-template.xcworkspace/contents.xcworkspacedata",
    "vue-app/index.html",
    ".gitignore",
    "bower.json",
    "package.json",
    "Podfile",
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

  # Install Node and Bower dependencies
  def self.install_dependencies(app_name : String)
    Dir.cd(app_name) do
      Print.print_command("Installing dependencies")
      Run.run_command("pod install")
      Run.run_command("npm install")
      Run.run_command("node_modules/.bin/bower install")
    end
  end

  # Renames all "ios-project-template" directories with the app name equivalent.
  def self.rename_directories(app_name : String)
    RENAME_DIRECTORIES.each do |directory|
      original_path = File.join("./#{app_name}", directory)
      new_path = File.join("./#{app_name}", directory.gsub("ios-project-template", app_name))
      Run.run_command("mv #{original_path} #{new_path}")
    end
  end

  # Replaces all versions of "iOS Project Template" with the app name equivalent.
  def self.replace_name(app_name : String)
    app_title = Inflector.titleize(app_name)
    app_underscored_name = Inflector.underscore(app_name)

    TEMPLATE_FILES.each do |file_path|
      relative_path = File.join("./#{app_name}", file_path)
      original_text = File.read(relative_path)
      File.open(relative_path, "w") do |file|
        file.puts original_text
          .gsub("iOS Project Template", app_title)
          .gsub("ios-project-template", app_name)
          .gsub("ios_project_template", app_underscored_name)
      end
    end
  end
end
