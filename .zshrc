# ZSH Options
export HISTSIZE=1000000000
export SAVEHIST=1000000000

setopt EXTENDED_HISTORY

export EDITOR=nano

# The completion system activation
autoload -Uz compinit
compinit

export STARSHIP_LOG=error

## Load Configuration
[[ -f ~/.config/zsh/aliases.zsh ]] && source ~/.config/zsh/aliases.zsh
[[ -f ~/.config/zsh/homebrew.zsh ]] && source ~/.config/zsh/homebrew.zsh
[[ -f ~/.config/zsh/git.zsh ]] && source ~/.config/zsh/git.zsh
[[ -f ~/.config/zsh/completions.zsh ]] && source ~/.config/zsh/completions.zsh
[[ -f ~/.config/zsh/functions.zsh ]] && source ~/.config/zsh/functions.zsh

# plugins
[[ -f ~/.config/zsh/plugins/plugins.zsh ]] && source ~/.config/zsh/plugins/plugins.zsh
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

setopt autocd autopushd
setopt NO_VERBOSE

export PATH="~/.local/bin:/opt/local/bin:/opt/homebrew/opt/binutils/bin:$PATH"
export PATH="/opt/homebrew/opt/python@3.11/libexec/bin:$PATH"
export PATH="$HOME/.composer/vendor/bin:$PATH"
#export PATH="/opt/homebrew/opt/mysql@8.4/bin:$PATH"

# macchina
quip
eval "$(fzf --zsh)"
eval "$(thefuck --alias fuck)"
eval "$(thefuck --alias wtf)"
eval "$(zoxide init zsh)"
eval "$(starship init zsh)"
