setopt autocd autopushd
setopt NO_VERBOSE
# Starship
export STARSHIP_CONFIG="${HOME}/.config/starship/starship.toml"
export STARSHIP_LOG=error
# TealDeer (TLDR)
export TEALDEER_CONFIG_DIR="$HOME/.config/tealdeer"

export EDITOR=micro
export VISUAL=micro
export MICRO_TRUECOLOR=1


#######
## Load Basic Configuration
##
## Basic configuration that should always work.
## This are only loaded if the file exists.
#######

[[ -f $ZDOTDIR/aliases.zsh ]] && source $ZDOTDIR/aliases.zsh
[[ -f $ZDOTDIR/functions.zsh ]] && source $ZDOTDIR/functions.zsh
[[ -f $ZDOTDIR/completions.zsh ]] && source $ZDOTDIR/completions.zsh

#######
## Load Plugins
## 
## Third-Party Plugins are used to add functionality to the shell.
##
## 1. Clones and stores new Plugins from their repository. 
## 2. Loads the plugin after cloning.
## 
## Deleting a plugin directory means it will be updated
## on next zsh load.
##
## List plugins with the command `plugins`
## 
## Add new plugins to the array in plugins.zsh
#######

[[ -f $ZDOTDIR/plugins/plugins.zsh ]] && source $ZDOTDIR/plugins/plugins.zsh

#######
## Load Modules
##
## Modules are my own personal mini-plugins for ZSH.
## These can contain completions, aliases, and functions
## that are useful.
## Any file with a zsh extension will be loaded.
#######

for file in $ZDOTDIR/modules/*.zsh; do
  [ -f "$file" ] && source "$file"
done

# Configure the $PATH
prepend_to_path $HOME/.local/bin $HOME/.composer/vendor/bin
# Move Homebrew Paths to the beginning of the path array.
start_of_path /opt/homebrew/sbin
start_of_path /opt/homebrew/bin

# The completion system activation
autoload -Uz compinit
compinit

quip
eval "$(fzf --zsh)"
eval "$(thefuck --alias fuck)"
eval "$(thefuck --alias wtf)"
eval "$(zoxide init zsh)"
eval "$(starship init zsh)"
