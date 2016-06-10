# 2 following functions are there for Cygwin, somehow this is needed...
function x86
    echo '(x86)'
end

function R
    echo '(R)'
end

function command_exists
    command --search $argv[1]>/dev/null
end

command_exists keychain; and begin
    keychain --eval --quiet --nogui --quick | sed 's/[[:space:]]\?and//g' | source
end; or begin
    echo "'keychain' is not installed."
end

set path_prefixes ~/bin ~/.local/bin /opt/local/bin /opt/local/sbin /usr/local/sbin

for p in (seq (count $path_prefixes))
    if test -d $path_prefixes[$p]
        set -U fish_user_paths $path_prefixes[$p] $fish_user_paths
    end
end

# TODO: Find a way to efficiently check if virtualfish is installed
eval (python -m virtualfish)

# Load prm-fish and setup completions
if not test -d ~/dev/prm-fish/
    git clone https://github.com:FredDeschenes/prm-fish.git $HOME/dev/prm-fish
    echo "Installed 'prm-fish'."
end
source ~/dev/prm-fish/prm.fish

# Load homeshick + completions
if not test -d ~/.homesick/repos/homeshick/
    git clone https://github.com/andsens/homeshick.git $HOME/.homesick/repos/homeshick
    echo "Installed 'homeshick'."
end
source ~/.homesick/repos/homeshick/homeshick.fish
source ~/.homesick/repos/homeshick/completions/homeshick.fish

# Load 'upto' (to get completions)
source ~/.config/fish/functions/upto.fish
