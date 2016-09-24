function ssh-genkey -d "Generates an ED25519 SSH key" -w dig
    ssh-keygen -o -a 100 -t ed25519 $argv
end

