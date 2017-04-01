defmodule DevelopmentSetup.Other.Ruby do

  @gems ~w(bundler cocoapods rubocop scss_lint)

  # Required by packages.gem, config_files.codelation.content
  def ruby_version do
    "2.3.1"
  end

  def install(_force) do
    {version, _} = System.cmd("ruby", ["-v"])
    if !String.contains?(version, ruby_version) do
      System.cmd("ruby-install", ["ruby", ruby_version])
    end
  end

  # Required by config.atom
  def ruby_bin_path do
    Path.join([System.user_home, ".rubies/ruby-#{ruby_version}/bin"])
  end
end
