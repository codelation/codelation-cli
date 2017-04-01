defmodule DevelopmentSetup.Applications.Atom do
  @download_url "https://atom-installer.github.com/v1.15.0/atom-mac.zip"

  def prepare(force) do
    CommandTools.Installer.ZIP.prepare("Atom", @download_url, force)
  end

  def install(force) do
    CommandTools.Installer.ZIP.install("Atom", @download_url, force)
  end
end
