defmodule DevelopmentSetup.Packages.Atom do
  @packages ~w(
    atom-beautify
    atom-elixir
    autocomplete-elixir
    file-icons
    file-types
    git-plus
    merge-conflicts
    minimap
    html-entities
    language-elixir
    language-vue
    linter
    linter-csslint
    linter-elixir-credo
    linter-erb
    linter-jshint
    linter-php
    linter-rubocop
    linter-ruby
    linter-scss-lint
    linter-shellcheck
    merge-conflicts
    phoenix-snippets
    pretty-json
    project-manager
    svg-preview
    todo
    rails-snippets
    remote-atom
    title-case
    xml-formatter
    atom-material-ui
    atom-material-syntax
    atom-material-syntax-dark
    atom-material-syntax-light
  )

  def install(_force) do
    if File.exists?("/Applications/Atom.app/Contents/Resources/app/apm/bin/apm") do
      IO.puts "Installing Atom packages..."

      @packages
      |> Enum.map(&install_package(&1))

      IO.puts "Done."
    else
      IO.puts "Couldn't find the Atom package manager"
    end
  end

  defp install_package(package) do
    if !File.exists?(Path.join(System.user_home, ".atom/packages/#{package}")) do
      IO.puts "    Atom - Installing #{package}"
      System.cmd("/Applications/Atom.app/Contents/Resources/app/apm/bin/apm", [package])
    end
  end
end
