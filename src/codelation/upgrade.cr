require "./utils/*"

# Adds `upgrade` command to the Codelation CLI.
class Codelation::Upgrade
  include Codelation::Utils

  def self.add(cli)
    cli.commands.add do |cmd|
      cmd.use = "upgrade"
      cmd.short = "Upgrades codelation-cli to the latest version"
      cmd.long = <<-LONG
        Runs `brew untap codelation/tools && brew tap codelation/tools && brew upgrade codelation-cli`
        LONG
      cmd.run { run }
    end
  end

  def self.run
    Print.print_heading("Upgrading codelation-cli")
    Run.run_command("brew untap codelation/tools")
    Run.run_command("brew tap codelation/tools")
    Run.run_command("brew upgrade codelation-cli")
  end
end
