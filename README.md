# Codelation CLI

Command line tool for Codelation development tasks.

## Installation

Install via [Homebrew](http://brew.sh):

```
brew install codelation/tools/codelation-cli
```

## Usage

```
codelation --help
```

```
codelation - The Command Line Interface for Codelation's Development Tasks

Usage:
  codelation [command] [flags] [arguments]

Commands:
  development:install  # Install the development tools used by Codelation
  help [command]       # Help about any command.
  rails:new            # Generate a new app using Codelation's Rails project template

Flags:
  -h, --help     # Help for this command. default: 'false'.
  -v, --version  # Print the version. default: 'false'.
```

## Development

Install [Crystal](https://crystal-lang.org) via [Homebrew](http://brew.sh):

```
brew update
brew install crystal-lang
```

Install application dependencies:

```
cd cloned/project/path
crystal deps
```

Examples of how to run commands in development:

```
crystal run src/codelation.cr -- [command] [flags] [arguments]
crystal run src/codelation.cr -- help development:install
crystal run src/codelation.cr -- rails:new
```

## Contributing

1. Fork it ( https://github.com/[my-github-username]/codelation-cli/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
