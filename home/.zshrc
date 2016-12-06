source ~/dev/antigen/antigen.zsh

antigen use oh-my-zsh

antigen bundle branch
antigen bundle git
antigen bundle gradle
antigen bundle ssh-agent
antigen bundle tmux
antigen bundle zsh_reload

antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-completions
antigen bundle zsh-users/zsh-syntax-highlighting

antigen theme simple

antigen apply

zstyle :omz:plugins:ssh-agent agent-forwarding on
zstyle :omz:plugins:ssh-agent lifetime 4h

source "$HOME/.homesick/repos/homeshick/homeshick.sh"
fpath=($HOME/.homesick/repos/homeshick/completions $fpath)

export EDITOR='vim'

alias zshconfig="$EDITOR ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias ga="git add"
alias gc="git commit"
alias gd="git diff"
alias gl="git log"
alias gs="git st"
alias myip="dig +short myip.opendns.com @resolver1.opendns.com"
alias ssh-genkey="ssh-keygen -o -a 100 -t ed25519"

if [ -d "${HOME}/dev/prm/" ]; then
    alias prm=". ${HOME}/dev/prm/prm.sh"
fi
