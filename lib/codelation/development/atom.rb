require "thor"

module Codelation
  class Cli < Thor
    ATOM_APP_DOWNLOAD_URL = "https://atom.io/download/mac".freeze

  private

    # Add the path to the Atom Init Script
    def add_atom_init_script
      init_path = File.expand_path("~/.atom/init.coffee")
      return if File.read(init_path).include?("process.env.PATH")
      path = `echo $PATH`.strip
      append_to_file "~/.atom/init.coffee", "process.env.PATH = \"#{path}\""
    end

    # Install Atom.app
    def install_atom
      zip_file_path = download_file(ATOM_APP_DOWNLOAD_URL)
      extract_app_from_zip("Atom.app", zip_file_path)
    end
  end
end
