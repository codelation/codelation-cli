defmodule DevelopmentSetup.Config.DotFiles do
  def install(force) do
    home_directory = System.user_home
    bash_directory = Path.join([home_directory, ".codelation", "bash"])

    write_file(Path.join(bash_directory, "codelation.bash"), DevelopmentSetup.Config.ConfigFiles.Codelation.content, force)
    write_file(Path.join(bash_directory, ".jshintrc"), DevelopmentSetup.Config.ConfigFiles.Jshintrc.content, force)
    write_file(Path.join(bash_directory, ".rubocop.yml"), DevelopmentSetup.Config.ConfigFiles.Rubocop.content, force)
    write_file(Path.join(bash_directory, ".scss-lint.yml"), DevelopmentSetup.Config.ConfigFiles.ScssLint.content, force)


    {:ok, bash_rc} = File.read(Path.join(home_directory, ".bash_profile"))

    if !String.contains?(bash_rc, "source ~/.codelation/bash/codelation.bash") do
      bash_rc = bash_rc <> "\nsource ~/.codelation/bash/codelation.bash"
      File.write!(Path.join(home_directory, ".bash_profile"), bash_rc)
    end
  end

  def write_file(file, content, force) do
    if File.exists?(file) do
      if CommandTools.prompt?("#{file} already exists. Overwrite it?", force) do
        CommandTools.write_file!(file, content)
      end
    else
      CommandTools.write_file!(file, content)
    end
  end
end
