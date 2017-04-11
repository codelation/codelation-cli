defmodule DevelopmentSetup do
  @all_install [
    DevelopmentSetup.Packages.Brew,
    DevelopmentSetup.Other.Ruby,
    DevelopmentSetup.Applications.Postgres,
    DevelopmentSetup.Applications.Atom,
    DevelopmentSetup.Packages.Atom,
    DevelopmentSetup.Packages.Gem,
    DevelopmentSetup.Config.Atom,
    DevelopmentSetup.Config.DotFiles
  ]

  def run(["atom"], force) do
    DevelopmentSetup.Applications.Atom.install(force)
    if CommandTools.prompt?("Install Atom Packages?", force) do
      DevelopmentSetup.Packages.Atom.install(force)
    end

    if CommandTools.prompt?("Install Atom Config?", force) do
      DevelopmentSetup.Config.Atom.install(force)
    end
    :ok
  end

  def run(["atom-packages"], force) do
    DevelopmentSetup.Packages.Atom.install(force)
    :ok
  end

  def run(["atom-config"], force) do
    DevelopmentSetup.Config.Atom.install(force)
    :ok
  end

  def run(["postgres"], force) do
    DevelopmentSetup.Applications.Postgres.install(force)
    :ok
  end

  def run(["brew"], force) do
    DevelopmentSetup.Packages.Brew.install(force)
    :ok
  end

  def run(["ruby"], force) do
    DevelopmentSetup.Other.Ruby.install(force)
    :ok
  end

  def run(["gems"], force) do
    DevelopmentSetup.Packages.Gem.install(force)
    :ok
  end

  def run(["config"], force) do
    DevelopmentSetup.Config.DotFiles.install(force)
    :ok
  end

  def run(["all"], force) do
    @all_install
    |> Enum.map(&install_item(&1, force))
    :ok
  end

  def run([], force) do
    @all_install
    |> Enum.map(&install_item(&1, force))
    :ok
  end

  def run(_else, _force) do
    :not_found
  end

  defp install_item(mods, force) when is_list(mods) do
    mods
    |> Enum.map(&Task.async(fn ->
         &1.prepare(force)
       end))
    |> Enum.map(&Task.await(&1))

    mods
    |> Enum.map(fn (m) -> m.install(force) end)
  end

  defp install_item(mod, force) do
    mod.install(force)
  end
end
