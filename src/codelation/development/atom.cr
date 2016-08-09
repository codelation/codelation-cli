require "../utils/*"

# Functions for installing Atom.app and Atom packages
class Codelation::Development::Atom
  include Codelation::Utils

  DOWNLOAD_URL = "https://atom.io/download/mac"

  PACKAGES = %w(
    atom-beautify
    atom-elixir
    crystal
    file-icons
    file-types
    git-time-machine
    html-entities
    language-crystal-actual
    language-docker
    language-elixir
    language-swift
    language-vue
    linter
    linter-csslint
    linter-elixir-credo
    linter-erb
    linter-jshint
    linter-php
    linter-rubocop
    linter-ruby
    linter-scss-lint
    linter-shellcheck
    merge-conflicts
    phoenix-snippets
    pretty-json
    rails-snippets
    remote-atom
    title-case
    xml-formatter
  )

  def self.install_atom
    if Dir.exists?("/Applications/Atom.app")
      Print.print_command("Already installed")
      return
    end

    Print.print_command("Downloading from #{DOWNLOAD_URL}")
    file_path = Download.download_file(DOWNLOAD_URL, "atom.zip")
    Zip.unzip(file_path, "/Applications")
    File.delete(file_path)
  end

  def self.install_packages
    PACKAGES.each do |package|
      install_package(package)
    end
  end

  def self.install_package(package : String)
    Print.print_command("Installing #{package}")

    if Dir.exists?(File.expand_path("~/.atom/packages/#{package}"))
      Print.print_command("Already installed")
      return
    end

    `/Applications/Atom.app/Contents/Resources/app/apm/bin/apm install #{package}`
  end
end
