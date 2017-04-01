defmodule DevelopmentSetup.Config.Atom do

  def install(_force) do
    atom_file = Path.join([System.user_home, ".atom", "init.coffee"])
    atom_contents = if File.exists?(atom_file) do
      {:ok, data} = File.read(atom_file)
      data
    else
      ""
    end

    atom_contents = String.replace(atom_contents, "\n# Add Ruby executables to Atom's PATH", "")
    |> String.replace(~r/\nprocess\.env\.PATH.*\n/, "")

    atom_contents = atom_contents <> "\n# Add Ruby executables to Atom's PATH\nprocess.env.PATH += \":#{DevelopmentSetup.Other.Ruby.ruby_bin_path()}\"\n"
    CommandTools.write_file!(atom_file, atom_contents)

    key_map_file_path = Path.join([System.user_home, ".atom", "keymap.cson"])

    if File.exists?(key_map_file_path) do
      if CommandTools.prompt?("Atom Key map file already exists. Overwrite it?", force) do
        CommandTools.write_file!(key_map_file_path, keymap_file())
      end
    else
      CommandTools.write_file!(key_map_file_path, keymap_file())
    end
  end

  defp keymap_file do
    "

'.platform-darwin':
  'cmd-t': 'fuzzy-finder:toggle-buffer-finder'
  'shift-cmd-t': 'fuzzy-finder:toggle-file-finder'
  'cmd-m':'project-manager:list-projects'
  'cmd-g':'git-plus:menu'

'atom-workspace atom-text-editor:not([mini])':
  'cmd-j':'pretty-json:prettify'

'.platform-darwin atom-workspace':
  'cmd-shift-j':'pretty-json:minify'

    "
  end
end
