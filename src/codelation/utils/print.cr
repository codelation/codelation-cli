# Provides convenience functions for formatting printed output.
class Codelation::Utils::Print
  # Print a heading to the terminal for commands that are going to be run.
  def self.print_heading(heading : String)
    puts "-----> #{heading}"
  end

  # Print a message to the terminal about a command that's going to run.
  def self.print_command(command : String)
    puts "       #{command}"
  end
end
