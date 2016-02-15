require "fileutils"
require "thor"
require "active_support"
require "active_support/core_ext"

module Codelation
  class Cli < Thor

  private

    def generate_rails_template(app_name)
      app_name = ask("Enter a name for your app: ") if app_name.nil?

      # Clones the template from GitHub
      puts "Creating new Rails app..."
      `git clone https://github.com/codelation/rails-project-template.git #{app_name}`

      # moves the repo off the template repo
      FileUtils.rm_rf("./#{app_name}/.git")

      # rewrites app name into project
      file_rewrites(app_name)
      rewrite(app_name, "config/secrets.yml", /(?<=development:\n(\s.)secret_key_base: ).*/, SecureRandom.hex(64))
      rewrite(app_name, "config/secrets.yml", /(?<=test:\n(\s.)secret_key_base: ).*/, SecureRandom.hex(64))

      # Adds a remote if wanted
      return if no?("Link to GitHub Repo? [y/N] ")
      repo_url = ""
      loop do
        repo_url = ask("Enter Repo URL: ")
        return if repo_url == "Q"
        break if repo_url =~ %r{((http([s]{0,1}):\/\/github.com\/)|(git@github\.com:))(.*)\/(.*)\.git}
        puts "Invalid Url or SSH path. Retry or Q to not link with a Git repository"
      end

      # Link heroku button to github path
      rewrite(app_name, "README.md", /(?<=template=).*(?=\))/, repo_url.chomp(".git"))

      Dir.chdir(app_name) do
        puts "Initalizing Repository..."
        `git init`
        puts "Adding Remote..."
        `git remote add origin #{repo_url}`
        puts "Installing Dependencies..."
        `bundle install`
        puts "Committing changes..."
        `git add .`
        `git commit -m "Initial commit"`

        return if no?("Setup database? [y/N] ")
        puts "Working..."
        `rake db:setup`
      end
    end

    def file_rewrites(app_name)
      app_project_name = app_name.titleize
      app_class_name = app_name.underscore.camelize
      app_underscored_name = app_name.underscore
      # Update README file with project name
      readme_file_name = "README.md"
      rewrite(app_name, readme_file_name, /Rails\sProject/, app_project_name)
      rewrite(app_name, readme_file_name, /rails-project-template/, app_project_name)

      # Update config/application with project name
      config_application_file_name = "config/application.rb"
      rewrite(app_name, config_application_file_name, /RailsProject/, app_class_name)

      # Update config/database.yml with project name
      config_database_file_name = "config/database.yml"
      rewrite(app_name, config_database_file_name, /rails_project/, app_underscored_name, true)

      # Update config/routes.rb with project name
      config_routes_file_name = "config/routes.rb"
      rewrite(app_name, config_routes_file_name, /RailsProject/, app_class_name)

      # Update config/locales/en.yml with project name
      config_locales_en_file_name = "config/locales/en.yml"
      rewrite(app_name, config_locales_en_file_name, /Rails\sProject/, app_project_name)

      # Update config/initializers/active_admin.rb with project name
      config_init_activeadmin_file_name = "config/initializers/active_admin.rb"
      rewrite(app_name, config_init_activeadmin_file_name, /Rails\sProject/, app_project_name)

      # session store fix
      config_init_sessionstore_file_name = "config/initializers/session_store.rb"
      rewrite(app_name, config_init_sessionstore_file_name, /rails_project/, app_underscored_name)
    end

    def rewrite(app_name, file_name, match, replace, global = false)
      original_text = File.read("./#{app_name}/#{file_name}")
      new_contents = global ? original_text.gsub(match, replace) : original_text.sub(match, replace)
      File.open("./#{app_name}/#{file_name}", "w") {|file| file.puts new_contents }
    end
  end
end
