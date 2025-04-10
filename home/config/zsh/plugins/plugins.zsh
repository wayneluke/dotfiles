# zsh_unplugged - https://github.com/mattmc3/zsh_unplugged
#
# A simple, fast, minimalist Zsh plugin management function in <20 lines of code.
#
# Usage:
# ZPLUGINDIR=${ZDOTDIR:-~}/plugins
# source $ZPLUGINDIR/zsh_unplugged/zsh_unplugged.zsh
# repos=(
#   ...
#   zsh-users/zsh-syntax-highlighting
#   zsh-users/zsh-autosuggestions
#   zsh-users/zsh-history-substring-search
# )
# plugin-load $repos
#

##? Clone a plugin, identify its init file, source it, and add it to your fpath.
function plugin-load {
  local repo plugdir initfile initfiles
  : ${ZPLUGINDIR:=${ZDOTDIR:-~/.config/zsh}/plugins}
  
  for repo in "$@"; do
    plugdir="$ZPLUGINDIR/${repo:t}"
    initfile="$plugdir/${repo:t}.plugin.zsh"

    if [[ ! -d "$plugdir" ]]; then
      echo "Cloning $repo..."
      git clone -q --depth 1 --recursive --shallow-submodules \
        "https://github.com/$repo" "$plugdir"
    fi

    if [[ ! -e "$initfile" ]]; then
      initfiles=("${(@f)$(print -l "$plugdir"/*.{plugin.zsh,zsh-theme,zsh,sh}(N))}")
      if (( ${#initfiles} == 0 )); then
        echo >&2 "No init file found for '$repo'."
        continue
      fi
      ln -sf "$initfiles[1]" "$initfile"
    fi

    fpath+="$plugdir"
    if (( $+functions[zsh-defer] )); then
      zsh-defer . "$initfile"
    else
      . "$initfile"
    fi
  done
}

# make a list of github repos
repos=(
  zsh-users/zsh-autosuggestions
  zsh-users/zsh-history-substring-search
  zdharma-continuum/fast-syntax-highlighting
  MichaelAquilina/zsh-you-should-use
)
plugin-load $repos

