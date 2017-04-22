defmodule DevelopmentSetup.Packages.Brew do
  @formulas ~w(
    bash
    chruby
    diff-so-fancy
    elixir
    heroku
    git
    imagemagick
    node
    openssl
    redis
    ruby-install
    shellcheck
    terminal-notifier
    v8
    watchman
    wget
  )

  def install(force) do
    IO.puts IO.ANSI.yellow<>"Installing Brew packages"
    aipt = Task.async(fn -> all_installed_packages() end)
    aobpt = Task.async(fn -> all_outdated_brew_packages() end)
    all = Task.await(aipt, 100000)
    outdated = Task.await(aobpt, 100000)

    @formulas
    |> Enum.map(&install_package(&1, all, outdated, force))

    IO.puts IO.ANSI.green<>"Done."
  end

  defp install_package(pack, all, outdated, force) do
    if MapSet.member?(all, pack) do # Already installed
      if MapSet.member?(outdated, pack) do # Outdated
        if CommandTools.prompt?("#{pack} is already installed but outdated. would you like to update it?", force) do
          IO.puts IO.ANSI.white<>IO.ANSI.faint<>"\tUpdating #{pack}..."<>IO.ANSI.normal
          System.cmd("brew", ["upgrade", pack])
        end
      else
        if CommandTools.prompt?("#{pack} is already installed. Would you like reinstall it?", force) do
          IO.puts IO.ANSI.white<>IO.ANSI.faint<>"\tUnlinking #{pack}..."<>IO.ANSI.normal
          System.cmd("brew", ["unlink", pack])
          IO.puts IO.ANSI.white<>IO.ANSI.faint<>"\tInstalling #{pack}..."<>IO.ANSI.normal
          System.cmd("brew", ["install", pack])
          IO.puts IO.ANSI.white<>IO.ANSI.faint<>"\tLinking #{pack}..."<>IO.ANSI.normal
          System.cmd("brew", ["link", pack])
        end
      end
    else
      IO.puts IO.ANSI.white<>IO.ANSI.faint<>"\tInstalling #{pack}..."<>IO.ANSI.normal
      System.cmd("brew", ["install", pack])
    end
  end

  defp all_outdated_brew_packages do
    {packages, 0} = System.cmd("brew", ["outdated"])
    MapSet.new(String.split(packages, "\n"))
  end

  defp all_installed_packages do
    {packages, 0} = System.cmd("brew", ["list"])
    MapSet.new(String.split(packages, "\n"))
  end
end
