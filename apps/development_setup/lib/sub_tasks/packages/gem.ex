defmodule DevelopmentSetup.Packages.Gem do

  @gems ~w(
    bundler
    rubocop
    scss_lint
  )

  def install(_force) do
    IO.puts IO.ANSI.yellow<>"Installing Gems"
    @gems
    |> Enum.map(&install_gem(&1))
    IO.puts IO.ANSI.green<>"Done."
  end

  defp install_gem(gem) do
    IO.puts IO.ANSI.white<>IO.ANSI.faint<>"\tGem - Installing #{gem}"<>IO.ANSI.normal
    System.cmd(gem_path(), ["install", gem])
  end

  defp gem_path do
    Path.join([System.user_home, ".rubies/ruby-#{DevelopmentSetup.Other.Ruby.ruby_version()}/bin/gem"])
  end
end
