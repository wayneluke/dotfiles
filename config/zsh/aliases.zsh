# general aliases
alias edit="codium"
alias code="codium"
alias cat="bat"
alias new="touch"
alias grep="grep --color"
alias guid='uuidgen | tr "[A-Z]" "[a-z]"'
alias newtab="open -a iterm ."
alias preview="open -a preview"
alias reload="source ~/.zshrc"
alias sysinfo='system_profiler SPSoftwareDataType'
alias tree='tree -a -I .git'
alias mkcd='(){mkdir -p "$1"; cd "$1"}'
alias -g -- -h='-h 2>&1 | bat --language=help --style=plain'
alias -g -- --help='--help 2>&1 | bat --language=help --style=plain'

# SHORTCUTS
alias c='clear'
alias cls='clear && ll'
alias h='history -10'
alias r='source ~/.zshrc'
alias x="exit"
alias d="rm"
alias u="cd .."

# Directory Listings
alias ls='eza --git --icons --group-directories-first'                     # ls
# alias l='eza -lbF --git --icons --group-directories-first --no-user'       # list, size, type, git
alias ll='eza -lbhGF --git --icons --group-directories-first'               # long list
alias la='eza -lbhaGF --icons --git  --group-directories-first'             # all list

# NPM aliases
alias nr="npm run"
alias ni="npm install"
alias ns="npm start"
alias nu="npm uninstall"

#yarn aliases
alias yr="yarn run"
alias yi="yarn add"
alias ys="yarn start"
alias yu="yarn remove"

# Edit files
alias -s {js,json,env,md,html,css,php,toml,xml}=code

# For Fun.
alias quip="fortune | lolcat"

# determine versions of PHP installed with HomeBrew
installedPhpVersions=($(brew ls --versions | ggrep -E 'php(@.*)?\s' | ggrep -oP '(?<=\s)\d\.\d' | uniq | sort))

# create alias for every version of PHP installed with HomeBrew
for phpVersion in ${installedPhpVersions[*]}; do
    value="{"

    for otherPhpVersion in ${installedPhpVersions[*]}; do
        if [ "${otherPhpVersion}" = "${phpVersion}" ]; then
            continue
        fi

        # unlink other PHP version
        value="${value} brew unlink php@${otherPhpVersion};"
    done

    # link desired PHP version
    value="${value} brew link php@${phpVersion} --force --overwrite; } &> /dev/null && php -v"

    alias "${phpVersion}"="${value}"
done
