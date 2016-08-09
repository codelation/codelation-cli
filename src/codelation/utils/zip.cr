require "../utils/*"

# Functions for processing zip files
class Codelation::Utils::Zip
  # Unzips the given file to the given destination
  def self.unzip(file_path : String, destination : String)
    Print.print_command("Extracting `#{file_path}` to `#{destination}`")
    `unzip #{file_path} -d #{destination}`
  end
end
