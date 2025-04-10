# Add custom function directory to fpath
fpath=($ZDOTDIR/functions $fpath)

# Autoload all function files in ~/.config/zsh/functions
for func_file in $ZDOTDIR/functions/*; do
  autoload -Uz $(basename "$func_file")
done

########
## Load other functions.
########

up() {
  num_levels="${1:-1}" # Default to 1 level if no argument is given
  if [[ ! "$num_levels" =~ ^[0-9]+$ ]]; then
    echo "Error: Argument must be a non-negative integer."
    return 1
  fi
  
  for ((i = 0; i < num_levels; i++)); do
    cd ..
  done
}

plugins() {
    local plugin_dir="$ZDOTDIR/plugins"
    
    if [[ -d "$plugin_dir" ]]; then
        find "$plugin_dir" -mindepth 1 -maxdepth 1 -type d -exec basename {} \; | sort
    else
        echo "Directory $plugin_dir does not exist."
    fi
}

# Type to Siri
function siri(){
    cliclick kd:fn kp:space ku:fn w:250 t:$1 kp:return
}

# Shows directory listing after CD.
#function chpwd() {
#  eza -lbhGF --git --icons --group-directories-first
#}

# Reload Zsh configuration files
reload() {
    local zdotdir=${ZDOTDIR:-$HOME}
    [[ -f "$zdotdir/.zprofile" ]] && source "$zdotdir/.zprofile"
    [[ -f "$zdotdir/.zshrc" ]] && source "$zdotdir/.zshrc" 
    [[ -f "$zdotdir/.zlogin" ]] && source "$zdotdir/.zlogin"
    [[ -f "$zdotdir/.zlogout" ]] && source "$zdotdir/.zlogout"
}

# Colored Man Pages.
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


# Required for $langinfo
zmodload zsh/langinfo

# URL-encode a string
#
# Encodes a string using RFC 2396 URL-encoding (%-escaped).
# See: https://www.ietf.org/rfc/rfc2396.txt
#
# By default, reserved characters and unreserved "mark" characters are
# not escaped by this function. This allows the common usage of passing
# an entire URL in, and encoding just special characters in it, with
# the expectation that reserved and mark characters are used appropriately.
# The -r and -m options turn on escaping of the reserved and mark characters,
# respectively, which allows arbitrary strings to be fully escaped for
# embedding inside URLs, where reserved characters might be misinterpreted.
#
# Prints the encoded string on stdout.
# Returns nonzero if encoding failed.
#
# Usage:
#  omz_urlencode [-r] [-m] [-P] <string> [<string> ...]
#
#    -r causes reserved characters (;/?:@&=+$,) to be escaped
#
#    -m causes "mark" characters (_.!~*''()-) to be escaped
#
#    -P causes spaces to be encoded as '%20' instead of '+'
function omz_urlencode() {
  emulate -L zsh
  setopt norematchpcre

  local -a opts
  zparseopts -D -E -a opts r m P

  local in_str="$@"
  local url_str=""
  local spaces_as_plus
  if [[ -z $opts[(r)-P] ]]; then spaces_as_plus=1; fi
  local str="$in_str"

  # URLs must use UTF-8 encoding; convert str to UTF-8 if required
  #local encoding=$langinfo[CODESET]
  local encoding='UTF-8'
  local safe_encodings
  safe_encodings=(UTF-8 utf8 US-ASCII)
  if [[ -z ${safe_encodings[(r)$encoding]} ]]; then
    str=$(echo -E "$str" | iconv -f $encoding -t UTF-8)
    if [[ $? != 0 ]]; then
      echo "Error converting string from $encoding to UTF-8" >&2
      return 1
    fi
  fi

  # Use LC_CTYPE=C to process text byte-by-byte
  # Note that this doesn't work in Termux, as it only has UTF-8 locale.
  # Characters will be processed as UTF-8, which is fine for URLs.
  local i byte ord LC_ALL=C
  export LC_ALL
  local reserved=';/?:@&=+$,'
  local mark='_.!~*''()-'
  local dont_escape="[A-Za-z0-9"
  if [[ -z $opts[(r)-r] ]]; then
    dont_escape+=$reserved
  fi
  # $mark must be last because of the "-"
  if [[ -z $opts[(r)-m] ]]; then
    dont_escape+=$mark
  fi
  dont_escape+="]"

  # Implemented to use a single printf call and avoid subshells in the loop,
  # for performance (primarily on Windows).
  local url_str=""
  for (( i = 1; i <= ${#str}; ++i )); do
    byte="$str[i]"
    if [[ "$byte" =~ "$dont_escape" ]]; then
      url_str+="$byte"
    else
      if [[ "$byte" == " " && -n $spaces_as_plus ]]; then
        url_str+="+"
      elif [[ "$PREFIX" = *com.termux* ]]; then
        # Termux does not have non-UTF8 locales, so just send the UTF-8 character directly
        url_str+="$byte"
      else
        ord=$(( [##16] #byte ))
        url_str+="%$ord"
      fi
    fi
  done
  echo -E "$url_str"
}

function open_command() {
  local open_cmd

  # define the open command
  case "$OSTYPE" in
    darwin*)  open_cmd='open' ;;
    cygwin*)  open_cmd='cygstart' ;;
    linux*)   [[ "$(uname -r)" != *icrosoft* ]] && open_cmd='nohup xdg-open' || {
                open_cmd='cmd.exe /c start ""'
                [[ -e "$1" ]] && { 1="$(wslpath -w "${1:a}")" || return 1 }
              } ;;
    msys*)    open_cmd='start ""' ;;
    *)        echo "Platform $OSTYPE not supported"
              return 1
              ;;
  esac

  # If a URL is passed, $BROWSER might be set to a local browser within SSH.
  # See https://github.com/ohmyzsh/ohmyzsh/issues/11098
  if [[ -n "$BROWSER" && "$1" = (http|https)://* ]]; then
    "$BROWSER" "$@"
    return
  fi

  ${=open_cmd} "$@" &>/dev/null
}