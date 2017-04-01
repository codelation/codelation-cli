# Codelation CLI

### Usage
```
Codelation CLI V2.0.0

	Examples:
		codelation --install all          Installs all packages
		codelation --install all -f       Installs all packages without prompting
		codelation --install atom         Installs atom

	Commands:
		--help/-h                         Shows this message
		--version/-v                      Shows the version of this tool
		--install/-i cmd                  Used to install assets. 'cmd' can be any one of the following

		        all           - Everything is installed
		        atom          - Atom is installed with prompts for packages and config
		        atom-packages - Atom packages are installed
		        atom-config   - Atom config is installed
		        postgres      - Postgres is installed
		        brew          - Brew packages are installed
		        gems          - Gems are installed
		        ruby          - Ruby is installed
		        config        - The config dot files are installed

		--force/-f                        Does not prompt the user (for silent installs)
```

### In this project
This has 3 main projects in it.  `cli` is the project that the command line options are parsed.  It also is the where the executable is built.  `command_tools` provides simple APIs for doing things like unzipping a file and downloading a file.  `development_setup` is the project where all the development installation tasks exist.  

### To Build
Everything below is run from the `apps/cli` directory

**1. Install Dependencies**

`mix escript.build`

**2. Rename the Executable**

`mv cli codelation`

**3. Create the Tar file**

`tar -czf codelation-1.0.0.tar.gz codelation`

**4. Create the release on GitHub and attach the tar file**

https://github.com/codelation/codelation-cli/releases

**5. Generate the SHA-256**

`shasum -a 256 codelation-1.0.0.tar.gz`

**6. Update the Formula with the new SHA, URL, and version**

`https://github.com/codelation/homebrew-tools/blob/master/codelation-cli.rb`
