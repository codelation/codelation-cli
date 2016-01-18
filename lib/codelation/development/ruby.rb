require "fileutils"
require "thor"

module Codelation
  class Cli < Thor
    RUBY_INSTALL_VERSION = "0.6.0".freeze
    RUBY_INSTALL_URL = "https://github.com/postmodern/ruby-install/archive/v#{RUBY_INSTALL_VERSION}.tar.gz".freeze
    RUBY_VERSION = "2.3.0".freeze

  private

    # Install Ruby binary and add it to PATH.
    def install_ruby
      return if `ruby -v`.include?(RUBY_VERSION)

      # Make sure chruby is loaded
      `source ~/.bash_profile`

      # Remove existing Ruby install from older version
      ruby_directory = File.expand_path("~/.codelation/ruby")
      FileUtils.rm_rf(ruby_directory) if Dir.exist?(ruby_directory)

      print_command("Installing Ruby #{RUBY_VERSION}")
      `ruby-install ruby #{RUBY_VERSION}`

      print_heading("Installing Ruby Gems")
      install_gems
    end

    # Install the Ruby gems needed for development.
    def install_gems
      %w(bundler codelation-cli dogids-cli rubocop scss_lint).each do |gem|
        print_command("gem install #{gem}")
        `gem install #{gem}`
      end
    end
  end
end
