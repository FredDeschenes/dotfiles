# See https://github.com/driv/upto

function upto -d "Allows to go up to a certain directory"
    if test (count $argv) -lt 1
        echo "A folder expression must be provided." >&2
        return 1
    end

    set -l expression $argv[1]

    if test $expression = "/"
        cd "/"
        return 0
    end

    set current_folder (pwd)
    set matched_dir ""
    set matching 1

    while test 1 -eq $matching
        command echo $current_folder | grep -q -E $expression
        if test 0 -eq $status
            set matched_dir $current_folder
            set current_folder (dirname $current_folder)
        else
            set matching 0
        end
    end

    if test -n $matched_dir
        cd $matched_dir
        return 0
    else
        echo "No match." >&2
        return 1
    end
end

complete -x -c upto -a "(pwd | sed -e 's/\//\n/g' | sed -e '/^\$/d')"
