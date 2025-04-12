
# Download Znap, if it's not there yet.
[[ -r $ZDOTDIR/plugins/znap/znap.zsh ]] ||
    git clone --depth 1 -- \
        https://github.com/marlonrichert/zsh-snap.git $ZDOTDIR/plugins/znap
source $ZDOTDIR/plugins/znap/znap.zsh  # Start Znap

znap source zsh-users/zsh-autosuggestions
znap source zsh-users/zsh-history-substring-search
znap source zdharma-continuum/fast-syntax-highlighting
znap source MichaelAquilina/zsh-you-should-use


