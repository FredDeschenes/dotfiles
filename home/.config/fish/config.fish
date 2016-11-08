set -eg EDITOR
set -Ux EDITOR (which vim)

function command_exists
    command --search $argv[1]>/dev/null
end

command_exists keychain; and begin
    keychain --eval --quiet --nogui --quick | sed 's/[[:space:]]\?and//g' | source
end

set path_prefixes ~/bin ~/.local/bin /opt/local/bin /opt/local/sbin /usr/local/sbin /usr/local/bin

for p in (seq (count $path_prefixes))
    if test -d $path_prefixes[$p]
        if not contains $path_prefixes[$p] $fish_user_paths
            set -U fish_user_paths $path_prefixes[$p] $fish_user_paths
        end
    end
end

set --local pip_list (pip list --format=legacy)

command echo $pip_list | grep virtualfish>/dev/null
if test $status = 0
    eval (python -m virtualfish)
end


command echo $pip_list | grep thefuck>/dev/null
if test $status = 0
    eval (thefuck --alias | tr '\n' ';')
end

# Load prm-fish and setup completions
if test -d ~/dev/prm-fish/
    source ~/dev/prm-fish/prm.fish
end

# Load homeshick + completions
source ~/.homesick/repos/homeshick/homeshick.fish
source ~/.homesick/repos/homeshick/completions/homeshick.fish

# Load 'upto' (to get completions)
source ~/.config/fish/functions/upto.fish
