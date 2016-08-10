require "../utils/*"

# Functions for installing Ruby and Ruby gems
class Codelation::Development::Ruby
  include Codelation::Utils

  GEMS = %w(bundler rubocop scss_lint)

  RUBY_VERSION = "2.3.1"

  def self.add_path_to_atom
    `touch ~/.atom/init.coffee`
    init_script_path = File.expand_path("~/.atom/init.coffee")
    init_script_content = File.read(init_script_path)
                            .gsub("\n# Add Ruby executables to Atom's PATH", "")
                            .gsub(/\nprocess\.env\.PATH.*\n/, "")
                            .gsub(/\nprocess\.env\.PATH.*/, "")
                            .gsub(/process\.env\.PATH.*/, "")

    init_script_content += "\n# Add Ruby executables to Atom's PATH\nprocess.env.PATH += \":#{ruby_bin_path}\"\n"
    File.write(init_script_path, init_script_content)
  end

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

  def self.ruby_bin_path
    File.expand_path("~/.rubies/ruby-#{RUBY_VERSION}/bin")
  end
end
