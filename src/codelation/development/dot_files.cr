require "file_utils"
require "./dot_files/*"
require "../utils/*"

# Functions for installing dot files for bash
class Codelation::Development::DotFiles
  include Codelation::Utils

  def self.install_dot_files
    home_directory = File.expand_path("~/")
    bash_directory = File.join(home_directory, ".codelation", "bash")
    FileUtils.rm_r(bash_directory) if Dir.exists?(bash_directory)
    `mkdir -p #{bash_directory}`

    File.write(File.join(bash_directory, "codelation.bash"), CODELATION)
    File.write(File.join(home_directory, ".jshintrc"), JSHINTRC)
    File.write(File.join(home_directory, ".rubocop.yml"), RUBOCOP)
    File.write(File.join(home_directory, ".scss-lint.yml"), SCSS_LINT)

    # Add `source ~/codelation.bash` to ~/.bash_profile if it doesn't exist
    `touch ~/.bash_profile`
    bash_profile_path = File.expand_path("~/.bash_profile")
    bash_profile_content = File.read(bash_profile_path)
                             .gsub("\nsource ~/.codelation/bash/.codelation.bash", "")
                             .gsub("source ~/.codelation/bash/.codelation.bash", "")
                             .gsub("\nsource ~/.codelation/bash/codelation.bash", "")
                             .gsub("source ~/.codelation/bash/codelation.bash", "")

    bash_profile_content += "\nsource ~/.codelation/bash/codelation.bash"
    File.write(bash_profile_path, bash_profile_content)
  end
end
