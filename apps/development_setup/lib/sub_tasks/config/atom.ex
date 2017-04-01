defmodule DevelopmentSetup.Config.Atom do
  @atom_file Path.join([System.user_home, ".atom", "init.coffee"])

  def install(_force) do

    atom_contents = if File.exists?(@atom_file) do
      {:ok, data} = File.read(@atom_file)
      data
    else
      ""
    end

    atom_contents = String.replace(atom_contents, "\n# Add Ruby executables to Atom's PATH", "")
    |> String.replace(~r/\nprocess\.env\.PATH.*\n/, "")

    atom_contents = atom_contents <> "\n# Add Ruby executables to Atom's PATH\nprocess.env.PATH += \":#{DevelopmentSetup.Other.Ruby.ruby_bin_path()}\"\n"
    CommandTools.write_file!(@atom_file, atom_contents)
  end
end
