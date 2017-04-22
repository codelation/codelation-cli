defmodule CommandTools.Installer.DMG do
  @download_dir "/tmp"
  @application_dir "/Applications"

  def prepare(package_name, url, force) do
    dmg_image_name = Path.basename(url)
    dmg_image = Path.join(@download_dir, dmg_image_name)
    IO.puts IO.ANSI.white<>IO.ANSI.faint<>"Downloading #{package_name}..."<>IO.ANSI.normal
    dmg_image = Path.join(@download_dir, dmg_image_name)
    CommandTools.download!(url, dmg_image, force)
  end

  def install(package_name, url, force) do
    dmg_image_name = Path.basename(url)
    dmg_image = Path.join(@download_dir, dmg_image_name)

    install? = if File.exists?(Path.join(@application_dir, "#{package_name}.app")) do
      CommandTools.prompt?("#{package_name} is already installed.  Do you want to reinstall it?", force)
    else
      true
    end
    if install? do
      prepare(package_name, url, force)
      {_, stat} = System.cmd("hdiutil",["attach", dmg_image])
      IO.puts ""
      if stat == 0 do
        IO.puts IO.ANSI.white<>IO.ANSI.faint<>"Installer mounted."<>IO.ANSI.normal
        IO.puts IO.ANSI.magenta<>"Please install #{package_name} via the installer."
        IO.puts IO.ANSI.green<>"Done."
      else
        IO.puts IO.ANSI.red<>"There was an issue mounting the installer.  Make sure it is not already mounted."
      end
    end
  end
end
