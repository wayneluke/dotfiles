# general aliases
alias edit='zed'
alias code='zed'
alias cat='bat'
alias grep='grep --color'
alias guid='uuidgen | tr "[A-Z]" "[a-z]"'
alias img='imgcat'
alias mkcd='(){mkdir -p "$1"; cd "$1"}'
alias new='touch'
alias newtab='open -a iterm .'
alias preview='open -a preview'
alias sysinfo='system_profiler SPSoftwareDataType'

# SHORTCUTS
alias c='cp -i'
alias cls='clear && ll'
alias h='history -10'
alias r='source ~/.config/zsh/.zshrc'
alias x="exit"
alias d="rm"

# Edit files
alias -s {js,json,env,md,html,css,php,toml,xml}=code

# For Fun.
alias quip="fortune | lolcat"
