#CLI

```
Codelation CLI V1.0.0

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
