# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

if [ -f ~/.zsh_env ]; then
  source ~/.zsh_env
fi

if [ -f ~/.zshenv ]; then
  source ~/.zshenv
fi

if [ ! -f ~/.local/bin/antibody ]; then
    curl -sfL git.io/antibody | sh -s - -b ~/.local/bin
fi

source <(antibody init)

if type "bat" > /dev/null; then
  alias "cat"="bat"
fi

if type "vivid" > /dev/null; then
  # https://github.com/sharkdp/vivid
  export LS_COLORS="$(vivid generate snazzy)"
else if [ -f ~/.ls_colors ]
  export LS_COLORS="$(cat ~/.ls_colors)"
fi

# Note: Bash on Windows does not currently apply umask properly.
if [[ "$(umask)" = "000" ]]; then
  umask 0022
fi

if grep -q Microsoft /proc/version; then
    # Use Windows Docker on WSL
    export DOCKER_HOST=tcp://localhost:2375
fi

fpath=($HOME/.zfunc $HOME/.zsh/gradle-completion /usr/local/share/zsh-completions $fpath)

export PATH=$HOME/.local/bin:/usr/local/sbin/:$PATH

export TYPEWRITTEN_CURSOR="block"
export TYPEWRITTEN_MULTILINE=false

# https://github.com/wting/autojump/issues/474
unsetopt BG_NICE

antibody bundle < ~/.zsh_plugins

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

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

if command -v lsd &> /dev/null
then
  alias ls="lsd"
fi

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
