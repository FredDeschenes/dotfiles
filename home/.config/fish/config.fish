# 2 following functions are there for Cygwin, somehow this is needed...
function x86
    echo '(x86)'
end

function R
    echo '(R)'
end

# TODO: Check if keychain is installed before running this
keychain --eval --quiet --nogui --quick | sed 's/[[:space:]]\?and//g' | source

set -gx PATH ~/bin /opt/local/bin /opt/local/sbin /usr/local/sbin $PATH

eval (python -m virtualfish)

# Load prm-fish and setup completions
. ~/dev/prm-fish/prm.fish
emit prm_setup

# Load homeshick + completions
source "$HOME/.homesick/repos/homeshick/homeshick.fish"
source "$HOME/.homesick/repos/homeshick/completions/homeshick.fish"
