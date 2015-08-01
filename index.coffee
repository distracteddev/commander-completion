#!/usr/bin/env coffee
path = require 'path'
fs = require 'fs'
exec = require('child_process').exec

FILE_NAME = process.argv.slice(2)[0] || path.resolve(process.cwd(), 'cli.coffee')
COMMANDER_PATH = path.resolve process.cwd(), FILE_NAME
COMMANDS_PATH = path.join __dirname, 'bash/commands.sh'
COMMAND_BLACKLIST = ['*']
removeBlackListedCommands = (cmd) ->
  return true unless cmd in COMMAND_BLACKLIST

program = require FILE_NAME

commands = (command._name for command in program.commands when command._name)
commands = commands.filter removeBlackListedCommands
commands = commands.join ' '
shortOpts = (option.short for option in program.options when option.short).join ' '
longOpts = (option.long for option in program.options when option.long).join ' '

commandsString = """
export COMMANDS="#{commands}"
export SHORT_OPTS="#{shortOpts}"
export LONG_OPTS="#{longOpts}"
"""

fs.writeFileSync COMMANDS_PATH, commandsString
