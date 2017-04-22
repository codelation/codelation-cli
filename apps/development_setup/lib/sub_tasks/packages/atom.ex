defmodule DevelopmentSetup.Packages.Atom do
  @packages ~w(
    atom-beautify
    file-icons
    file-types
    git-plus
    merge-conflicts
    minimap
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
    IO.puts IO.ANSI.yellow<>"Installing Atom packages"
    if File.exists?("/Applications/Atom.app/Contents/Resources/app/apm/bin/apm") do
      @packages
      |> Enum.map(&install_package(&1))

      IO.puts IO.ANSI.green<>"Done."
    else
      IO.puts IO.ANSI.red<>"Couldn't find the Atom package manager"
    end
  end

  defp install_package(package) do
    if !File.exists?(Path.join(System.user_home, ".atom/packages/#{package}")) do
      IO.puts IO.ANSI.white<>IO.ANSI.faint<>"\tAtom - Installing #{package}"<>IO.ANSI.normal
      System.cmd("/Applications/Atom.app/Contents/Resources/app/apm/bin/apm", ["i", package])
    end
  end
end
