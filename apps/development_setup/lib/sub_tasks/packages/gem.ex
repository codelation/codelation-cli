defmodule DevelopmentSetup.Packages.Gem do

  @gems ~w(
    bundler
    rubocop
    scss_lint
  )

  def install(_force) do
    IO.puts "Installing Gems..."
    @gems
    |> Enum.map(&install_gem(&1))
    IO.puts "Done."
  end

  defp install_gem(gem) do
    IO.puts "    Gem - Installing #{gem}"
    System.cmd(gem_path(), ["install", gem])
  end

  defp gem_path do
    Path.join([System.user_home, ".rubies/ruby-#{DevelopmentSetup.Other.Ruby.ruby_version()}/bin/gem"])
  end
end
