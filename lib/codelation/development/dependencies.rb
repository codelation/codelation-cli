require "thor"

module Codelation
  class Cli < Thor
  private

    # Install dependencies for building and installing everything else.
    def install_dependencies
      unless `which brew`.length > 1
        print_command("Installing Homebrew from http://brew.sh")
        print_command("Re-run `codelation developer:install after Homebrew has been installed`")
        sleep 3
        exec('ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"')
      end
      run_command("brew update")
      formulas = %w(bash chruby diff-so-fancy git heroku-toolbelt imagemagick node openssl ruby-install shellcheck v8 wget)
      formulas.each do |formula|
        brew_install(formula)
      end
    end

    def brew_install(formula)
      run_command("brew unlink #{formula}") if outdated_formulas.include?("#{formula}\n")
      run_command("brew install #{formula}")
    end

    def outdated_formulas
      @outdated_formulas ||= `brew outdated`
    end
  end
end
