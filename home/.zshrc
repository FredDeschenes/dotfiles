antigen_dir=$HOME/dev/antigen
if [ ! -d $antigen_dir ];then
    git clone https://github.com/zsh-users/antigen.git $antigen_dir
fi

source $antigen_dir/antigen.zsh

antigen use oh-my-zsh

antigen bundle archlinux
antigen bundle branch
antigen bundle git
antigen bundle gradle
antigen bundle redis-cli
antigen bundle ssh-agent
antigen bundle systemd
antigen bundle tmux
antigen bundle zsh_reload

if [ "$OSTYPE" != "cygwin" ];then
    # This runs awefully slow on Cygwin
    antigen bundle zsh-users/zsh-autosuggestions
fi
antigen bundle zsh-users/zsh-completions
antigen bundle zsh-users/zsh-syntax-highlighting

antigen theme simple

antigen apply

zstyle :omz:plugins:ssh-agent agent-forwarding on
zstyle :omz:plugins:ssh-agent lifetime 4h

export EDITOR='vim'

alias zshconfig="$EDITOR ~/.zshrc"
alias ga="git add"
alias gc="git commit"
alias gd="git diff"
alias gl="git log"
alias gs="git st"
alias myip="dig +short myip.opendns.com @resolver1.opendns.com"
alias ssh-genkey="ssh-keygen -o -a 100 -t ed25519"

homeshick_dir="$HOME/.homesick/repos/homeshick"
if [ -d $homeshick_dir ]; then
    source "$HOME/.homesick/repos/homeshick/homeshick.sh"
    fpath=($HOME/.homesick/repos/homeshick/completions $fpath)
fi

prm_dir="$HOME/dev/prm"
if [ -d $prm_dir ]; then
    alias prm=". ${prm_dir}/prm.sh"
fi
