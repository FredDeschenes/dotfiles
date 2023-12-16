source_if_exists () {
  if [[ -r "$1" ]]; then
    source "$1"
  fi
}

source_if_exists "$HOME/.zshenv"
source_if_exists "$HOME/.zsh_env"

if [ ! -d ${ZDOTDIR:-~}/.antidote ]; then
  git clone --depth=1 https://github.com/mattmc3/antidote.git ${ZDOTDIR:-~}/.antidote
fi

export PATH=$HOME/.local/bin:$HOME/.fzf/bin/:/usr/local/sbin/:$PATH

source ${ZDOTDIR:-~}/.antidote/antidote.zsh

# Note: Bash on Windows does not currently apply umask properly.
if [[ "$(umask)" = "000" ]]; then
  umask 0022

  # https://github.com/wting/autojump/issues/474
  unsetopt BG_NICE
fi

fpath=($HOME/.zfunc $HOME/.zsh/gradle-completion /usr/local/share/zsh-completions $fpath)

antidote load

if type "bat" > /dev/null; then
  alias "cat"="bat"
fi

if type "vivid" > /dev/null; then
  # https://github.com/sharkdp/vivid
  export LS_COLORS="$(vivid generate snazzy)"
else if [ -f ~/.ls_colors ]
  export LS_COLORS="$(cat ~/.ls_colors)"
fi

if type "lsd" > /dev/null; then
  alias ls="lsd"
fi

# Set zsh-users/zsh-autosuggestions suggestion color
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=244'

# Keybindings for "zsh-history-substring-search" plugin
bindkey '\eOA' history-substring-search-up
bindkey '\eOB' history-substring-search-down

zstyle :omz:plugins:ssh-agent agent-forwarding on
zstyle :omz:plugins:ssh-agent lifetime 4h

export EDITOR='vim'

alias zshconfig="$EDITOR ~/.zshrc"
alias gs="gsb"
alias myip="dig +short myip.opendns.com @resolver1.opendns.com"
alias ssh-genkey="ssh-keygen -o -a 100 -t ed25519"
alias :q="exit"
alias :Q="exit"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
source_if_exists "$HOME/.p10k.zsh"
