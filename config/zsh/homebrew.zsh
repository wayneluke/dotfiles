# Homebrew

export HOMEBREW_NO_ANALYTICS=1
export HOMEBREW_NO_INSECURE_REDIRECT=1
export HOMEBREW_AUTO_UPDATE_SEX=900
export HOMEBREW_NO_ENV_HINTS=True
export HOMEBREW_NO_CLEANUP_FORMULAE=php@8.2

# Aliases 

alias bchildren=" brew deps --tree --installed"
alias bfile='brew bundle --describe -f dump'
alias binfo='brew info'
alias brews='brew list'
alias services='brew services'
alias bsearch='brew search'
alias rebrew="brew upgrade && brew cleanup"
alias stalebrew='brew outdated'
alias pour='brew install'
alias drain='brew uninstall'

if type brew &>/dev/null
then
  FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
fi