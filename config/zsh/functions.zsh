# Add custom function directory to fpath
fpath=(~/.config/zsh/functions $fpath)

# Autoload all function files in ~/.config/zsh/functions
for func_file in ~/.config/zsh/functions/*; do
  autoload -Uz $(basename "$func_file")
done

function showpath {
    echo $PATH | sed 's/\:/\n/g'
}


function aliases() {
  local alias_name
  for alias_name in ${(k)aliases}; do
    echo "$alias_name -> ${aliases[$alias_name]}"
  done | sort
}

function remove_dup_path {
  local path_array=( $(tr ':' '\n' <<< "$PATH") )
  local unique_path=( $(printf "%s\n" "${path_array[@]}" | sort -u) )
  export PATH=$(printf "%s:" "${unique_path[@]}" | sed 's/:$//')
}

# Type to Siri
function siri(){
    cliclick kd:fn kp:space ku:fn w:250 t:$1 kp:return
}

function chpwd() {
  eza -lbhGF --git --icons --group-directories-first
}

config() {
    local config_file

    case "$1" in
        zsh)
            code "$HOME/.zshrc"
            ;;
        vim)
            code "$HOME/.vimrc"
            ;;
        git)
            code "$HOME/.gitconfig"
            ;;
        httpd)
            code /opt/homebrew/etc/httpd/httpd.conf
            ;;
        sites)
            code /opt/homebrew/etc/httpd/sites
            ;;
        hosts)
            sudo nano /etc/hosts
            ;;
        *)
            echo "Usage: config {zsh|vim|git|httpd|hosts}"
            return 1
            ;;
    esac
}

function man() {
	env \
		LESS_TERMCAP_md=$(tput bold; tput setaf 4) \
		LESS_TERMCAP_me=$(tput sgr0) \
		LESS_TERMCAP_mb=$(tput blink) \
		LESS_TERMCAP_us=$(tput setaf 2) \
		LESS_TERMCAP_ue=$(tput sgr0) \
		LESS_TERMCAP_so=$(tput smso) \
		LESS_TERMCAP_se=$(tput rmso) \
		PAGER="${commands[less]:-$PAGER}" \
		man "$@"
}
