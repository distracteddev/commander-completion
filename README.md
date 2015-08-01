# Commander-Completion

This module can be used to generate bash/zsh completion functions for a node-commander cli.

# Requirements

- your cli is built with node-commander
- coffeescript is installed on your system
- your cli can be called with `./cli.coffee example-command`

# Installation

Installation is 3 step process

1. npm install commander-completion
2  copy/source the `completion.sh` file into your `~/.bashrc` or `~/.zshrc`
3. add the following 'completion' script to your package.json

  ```javascript
  // Your scripts definition inside your package.json might look like this:
  "scripts": {
    "test": "echo \"Error: no test specified\" && exit 1",
    "completion": "coffee node_modules/commander-completion/index.coffee >/dev/null"
  },
  ```

4. run `npm run-script completion` to generate the completion options


# Updating your completion options

Calling `npm run-script completion` generates a commands.sh file which is used by the completion function to get the options for the current cli.coffee file.
(This allows the completion function (completion.sh) to work across several cli.coffee instances by storing the commands and options in a module-specific location)

This means that whenever you update your CLI with new commands or options, you should re-run `npm run-script completion`.

If you want this done automatically for you, you could add that script to npm lifecycle hooks, git-hooks, or even run the `coffee node_modules/commander-completion/index.coffee` directly from your `/.bashrc`/`/.zshrc`
