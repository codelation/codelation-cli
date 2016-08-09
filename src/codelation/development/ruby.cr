require "../utils/*"

# Functions for installing Ruby and Ruby gems
class Codelation::Development::Ruby
  include Codelation::Utils

  GEMS = %w(bundler rubocop scss_lint)

  RUBY_VERSION = "2.3.1"

  def self.install_gems
    GEMS.each do |gem|
      Run.run_command("#{gem_path} install #{gem}")
    end
  end

  def self.install_ruby
    return if `ruby -v`.includes?(RUBY_VERSION)
    Run.run_command("ruby-install ruby #{RUBY_VERSION}")
  end

  def self.gem_path
    File.expand_path("~/.rubies/ruby-#{RUBY_VERSION}/bin/gem")
  end
end
