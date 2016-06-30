function myip -d "Returns the current (external) IP address" -w dig
    command dig +short myip.opendns.com @resolver1.opendns.com $argv
end

