require "./print"

# Provides a function for running a command after printing it to the terminal
class Codelation::Utils::Run
  # Run a command with Bash after first printing the command to the terminal.
  def self.run_command(command : String)
    Codelation::Utils::Print.print_command(command)
    `#{command}`
  end
end
