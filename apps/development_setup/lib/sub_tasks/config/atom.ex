defmodule DevelopmentSetup.Config.Atom do
  @atom_file Path.join([System.user_home, ".atom", "init.coffee"])

  def install(_force) do

    if !File.exists?(@atom_file) do
      File.write!(@atom_file, "") 
    end

    {:ok, atom_contents} = File.read(@atom_file)

    atom_contents = String.replace(atom_contents, "\n# Add Ruby executables to Atom's PATH", "")
    |> String.replace(~r/\nprocess\.env\.PATH.*\n/, "")

    atom_contents = atom_contents <> "\n# Add Ruby executables to Atom's PATH\nprocess.env.PATH += \":#{DevelopmentSetup.Other.Ruby.ruby_bin_path()}\"\n"
    File.write!(@atom_file, atom_contents)
  end
end
