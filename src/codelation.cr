require "commander"
require "./codelation/*"
require "./codelation/development/*"
require "./codelation/ios/*"
require "./codelation/rails/*"
require "./codelation/vue/*"

cli = Commander::Command.new do |cmd|
  cmd.use = "codelation"
  cmd.long = "The Command Line Interface for Codelation's Development Tasks"

  cmd.flags.add do |flag|
    flag.name = "version"
    flag.short = "-v"
    flag.long = "--version"
    flag.default = false
    flag.description = "Print the version."
  end

  cmd.run do |options, arguments|
    if options.bool["version"]
      puts Codelation::VERSION
    else
      puts cmd.help
    end
  end
end

Codelation::Development::Install.add(cli)
Codelation::Ios::New.add(cli)
Codelation::Rails::New.add(cli)
Codelation::Setup.add(cli)
Codelation::Upgrade.add(cli)
Codelation::Vue::New.add(cli)

Commander.run(cli, ARGV)
