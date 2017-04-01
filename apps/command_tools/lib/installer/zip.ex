defmodule CommandTools.Installer.ZIP do
  @download_dir "/tmp"
  @application_dir "/Applications"

  def prepare(package_name, url, force) do
    IO.puts "Downloading #{package_name}..."
    zip_file = Path.join(@download_dir, "#{package_name}.zip")
    CommandTools.download!(url, zip_file, force)
  end

  def install(package_name, url, force) do
    zip_file = Path.join(@download_dir, "#{package_name}.zip")

    install? = if File.exists?(Path.join(@application_dir, "#{package_name}.app")) do
      CommandTools.prompt?("#{package_name} is already installed.  Do you want to reinstall it?", force)
    else
      true
    end

    if install? do
      prepare(package_name, url, force)
      IO.puts "Installing #{package_name}..."
      uninstall(Path.join(@application_dir, "#{package_name}.app"))
      CommandTools.unzip(zip_file, @application_dir)
      File.chmod!(Path.join([@application_dir, "#{package_name}.app", "Contents", "MacOS", package_name]), 755)
      IO.puts "Done."
    end
  end

  defp uninstall(app_name) do
    File.rm_rf app_name
  end
end
