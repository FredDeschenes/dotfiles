prm_dir="$HOME/dev/prm"
if [ -d $prm_dir ]; then
    alias prm=". ${prm_dir}/prm.sh"
fi

if [ -f $HOME/.cargo/env ]; then
    source $HOME/.cargo/env
fi

fpath=($HOME/.zfunc /usr/local/share/zsh-completions $fpath)

export PATH=$HOME/.local/bin:/usr/local/sbin/:$PATH

antigen_dir=$HOME/.antigen-git
if [ ! -d $antigen_dir ];then
    git clone https://github.com/zsh-users/antigen.git $antigen_dir
fi

source $antigen_dir/antigen.zsh

antigen use oh-my-zsh

if [ -f "/etc/arch-release"  ]; then
    antigen bundle archlinux
fi
antigen bundle branch
antigen bundle docker
antigen bundle docker-compose
antigen bundle git
antigen bundle gradle
antigen bundle redis-cli
antigen bundle ssh-agent
antigen bundle systemd
antigen bundle tmux
antigen bundle zsh_reload
antigen bundle osx

if [ "$OSTYPE" != "cygwin" ];then
    # This runs awefully slow on Cygwin
    antigen bundle zsh-users/zsh-autosuggestions
fi
antigen bundle zsh-users/zsh-completions
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-history-substring-search

SPACESHIP_PROMPT_ADD_NEWLINE=false
SPACESHIP_PROMPT_SEPARATE_LINE=false
SPACESHIP_EXEC_TIME_SHOW=false
SPACESHIP_BATTERY_SHOW=false
SPACESHIP_KUBECONTEXT_SHOW=false
if [ "$OSTYPE" = "cygwin" ]; then
    # Incredibly slow on Cygwin
    # See : https://github.com/robbyrussell/oh-my-zsh/issues/5486
    SPACESHIP_GIT_STATUS_SHOW=false
fi
antigen theme https://github.com/denysdovhan/spaceship-zsh-theme spaceship

antigen bundle jamesob/desk shell_plugins/zsh

antigen apply

# Set zsh-users/zsh-autosuggestions suggestion color
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=244'

# Keybindings for "zsh-history-substring-search" plugin
bindkey '\eOA' history-substring-search-up
bindkey '\eOB' history-substring-search-down

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
alias :q="exit"
alias :Q="exit"
if type "thefuck" > /dev/null; then
    eval $(thefuck --alias)
fi

compdef _gradlew_tasks gw

# Hook for desk activation
[ -n "$DESK_ENV" ] && source "$DESK_ENV" || true

# Terminix initilization stuff
if [[ $TERMINIX_ID ]] && [[ -f /etc/profile.d/vte.sh ]]; then
    source /etc/profile.d/vte.sh
fi
