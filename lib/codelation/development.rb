require "thor"

module Codelation
  class Cli < Thor
    desc "development:install", "Install the development tools used by Codelation"
    long_desc <<-LONGDESC
      Installs the following development tools:\r\n
      - Atom.app (https://atom.io)\n
      - Atom Packages: erb-snippets, linter, linter-csslint, linter-erb, linter-jshint,
          linter-php, linter-rubocop, linter-ruby, linter-scss-lint, remote-atom\n
      - Postgres.app (http://postgresapp.com)\n
      - Ruby (https://www.ruby-lang.org)\n
      - Ruby Gems: bundler, rubocop, scss-lint\n
      - Sequel Pro.app (http://www.sequelpro.com)
    LONGDESC
    def development_install
      print_heading("Installing Dependencies")
      install_dependencies

      unless Dir.exist?("/Applications/Atom.app")
        print_heading("Installing Atom.app")
        install_atom

        print_heading("Installing Atom Packages")
        install_atom_packages
      end

      print_heading("Installing Dot Files")
      install_dot_files

      unless Dir.exist?("/Applications/Postgres.app")
        print_heading("Installing Postgres.app")
        install_postgres
      end

      print_heading("Installing Ruby")
      install_ruby

      unless Dir.exist?("/Applications/Sequel Pro.app")
        print_heading("Installing Sequel Pro.app")
        install_sequel_pro
      end

      `source ~/.bash_profile`
    end
  end
end
