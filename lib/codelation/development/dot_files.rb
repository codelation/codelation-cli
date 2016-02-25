require "fileutils"
require "thor"

module Codelation
  class Cli < Thor
  private

    # Install dot files and load them into ~/.bash_profile
    def install_dot_files
      # Create the directory ~/.codelation/bash if it doesn't exist
      bash_directory = File.expand_path("~/.codelation/bash")
      FileUtils.rm_rf(bash_directory) if Dir.exist?(bash_directory)
      FileUtils.mkdir_p(bash_directory)

      # Copy dot files to ~/.codelation
      copy_file "dot_files/.codelation.bash",     "~/.codelation/bash/.codelation.bash"
      copy_file "dot_files/.git-completion.bash", "~/.codelation/bash/.git-completion.bash"
      copy_file "dot_files/.git-prompt.sh",       "~/.codelation/bash/.git-prompt.sh"
      copy_file "dot_files/.jshintrc",            "~/.jshintrc"
      copy_file "dot_files/.rubocop.yml",         "~/.rubocop.yml"
      copy_file "dot_files/.scss-lint.yml",       "~/.scss-lint.yml"

      # Add `source ~/.codelation.bash` to ~/.bash_profile if it doesn't exist
      FileUtils.touch(File.expand_path("~/.bash_profile"))
      append_to_file "~/.bash_profile", "source ~/.codelation/bash/.codelation.bash"
    end
  end
end
