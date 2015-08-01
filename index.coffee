#!/usr/bin/env coffee
path = require 'path'
fs = require 'fs'

FILE_NAME = process.argv.slice(2)[0] || 'cli.coffee'
COMMANDER_PATH = path.resolve process.cwd(), FILE_NAME
COMPLETION_PATH = path.join __dirname, 'bash/completion.sh'

console.log 'building completion file', COMMANDER_PATH, COMPLETION_PATH

completionFnString = """
if type complete &>/dev/null; then
  _cli.coffee_completion () {
    COMPREPLY=()

    # all available commands
    COMMANDS="add-account-service-providers add-account-settings add-api-key-access add-application-archivedAt add-application-eeo add-default-email-settings add-default-template-groups add-instructions-to-templates add-is-archived-field add-system-templates-to-group add-user-secret"
    SHORT_OPTS="-E -S -A -J -s -P -M -q -G -C -U -T -K"
    LONG_OPTS="--account --file --user"

    # get the current argument on the command line
    CURRENT_ARG="${COMP_WORDS[COMP_CWORD]}"

    case "$CURRENT_ARG" in
    --*)
      COMPREPLY=($(compgen -W "${LONG_OPTS}" -- "${CURRENT_ARG}"))
      ;;
    -*)
      COMPREPLY=($(compgen -W "${SHORT_OPTS}" -- "${CURRENT_ARG}"))
      ;;
    *)
      COMPREPLY=($(compgen -W "${COMMANDS}" -- "${CURRENT_ARG}"))
      ;;
    esac

  }
  complete -F _cli.coffee_completion cli.coffee
fi
"""

fs.writeFileSync COMPLETION_PATH, completionFnString
