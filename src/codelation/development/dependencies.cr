require "../utils/*"

# Functions for installing development dependencies.
class Codelation::Development::Dependencies
  include Codelation::Utils

  @@outdated_formulas = ""

  FORMULAS = %w(
    bash
    chruby
    crystal-lang
    diff-so-fancy
    elixir
    git
    imagemagick
    node
    openssl
    redis
    ruby-install
    shellcheck
    terminal-notifier
    v8
    watchman
    wget
  )

  def self.brew_install(formula)
    Run.run_command("brew unlink #{formula}") if @@outdated_formulas.includes?("#{formula}\n")
    Run.run_command("brew install #{formula}")
  end

  def self.install_dependencies
    Run.run_command("brew update")
    @@outdated_formulas = `brew outdated`
    FORMULAS.each do |formula|
      brew_install(formula)
    end
  end
end
