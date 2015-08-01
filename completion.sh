if type complete &>/dev/null; then
  _cli.coffee_completion () {
    COMPREPLY=()

    # all available commands, long opts, and short opts for the current cli
    # NOTE: this file is generated by the commander-completion module
    commandfile="$PWD/node_modules/commander-completion/bash/commands.sh"
    # check if the commands file exists
    if [ -f "$commandfile" ]
    then
      # if it does, lets load the options for the current cli
      source "$commandfile"
    else
      # otherwise, mimic the default bash completion and return early
      COMPREPLY=($(compgen -f  -- "${COMP_WORDS[${COMP_CWORD}]}" ))
      return
    fi

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
