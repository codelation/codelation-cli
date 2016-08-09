class Codelation::Utils::DirUtils
  # Returns the path to the temp directory used by the Codelation CLI.
  # @return [String]
  def self.temp_directory
    path = File.expand_path("~/.codelation/temp")
    `mkdir -p #{path}`
    path
  end
end
