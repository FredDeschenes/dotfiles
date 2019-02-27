LS_COLORS='no=00;37:fi=01;34:rs=00;37:di=00;34:ln=00;36:mh=00;37:pi=40;33:so=00;35:do=00;35:bd=40;33;01:cd=40;33;01:or=00;05;37;41:mi=00;05;37;41:su=37;41:sg=30;43:ca=30;41:tw=30;42:ow=04;34:st=37;44:ex=00;32:*.cmd=00;33:*.exe=00;33:*.com=00;33:*.btm=00;33:*.bat=00;33:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.lzma=01;31:*.tlz=01;31:*.txz=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.dz=01;31:*.gz=01;31:*.lz=01;31:*.xz=01;31:*.bz=01;31:*.bz2=01;31:*.bzip2=01;31:*.tbz=01;31:*.tbz2=01;31:*.tz=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.rar=01;31:*.ace=01;31:*.zoo=01;31:*.cpio=01;31:*.7z=01;31:*.rz=01;31:*.apk=01;31:*.gem=01;31:*.jpg=00;35:*.JPG=00;35:*.jpeg=00;35:*.gif=00;35:*.bmp=00;35:*.pbm=00;35:*.pgm=00;35:*.ppm=00;35:*.tga=00;35:*.xbm=00;35:*.xpm=00;35:*.tif=00;35:*.tiff=00;35:*.png=00;35:*.svg=00;35:*.svgz=00;35:*.mng=00;35:*.pcx=00;35:*.dl=00;35:*.xcf=00;35:*.xwd=00;35:*.yuv=00;35:*.cgm=00;35:*.emf=00;35:*.eps=00;35:*.CR2=00;35:*.ico=00;35:*.pdf=00;32:*.ps=00;32:*.txt=00;32:*.html=00;32:*.css=00;32:*.rst=00;32:*.md=00;32:*.patch=00;32:*.diff=00;32:*.tex=00;32:*.xls=00;32:*.xlsx=00;32:*.doc=00;32:*.docx=00;32:*.ppt=00;32:*.pptx=00;32:*.key=00;32:*.ods=00;32:*.odt=00;32:*.pt=01;32:*.tmpl=01;32:*.in=01;32:*.ots=01;32:*.ott=01;32:*.aac=01;36:*.au=01;36:*.flac=01;36:*.mid=01;36:*.midi=01;36:*.mka=01;36:*.mp3=01;36:*.mpc=01;36:*.ogg=01;36:*.ra=01;36:*.wav=01;36:*.m4a=01;36:*.axa=01;36:*.oga=01;36:*.spx=01;36:*.xspf=01;36:*.mov=01;36:*.mpg=01;36:*.mpeg=01;36:*.m2v=01;36:*.mkv=01;36:*.ogm=01;36:*.mp4=01;36:*.m4v=01;36:*.mp4v=01;36:*.vob=01;36:*.qt=01;36:*.nuv=01;36:*.wmv=01;36:*.asf=01;36:*.rm=01;36:*.rmvb=01;36:*.flc=01;36:*.avi=01;36:*.fli=01;36:*.flv=01;36:*.gl=01;36:*.m2ts=01;36:*.divx=01;36:*.webm=01;36:*.axv=01;36:*.anx=01;36:*.ogv=01;36:*.ogx=01;36:*.conf=00;36:*.config=00;36:*.cnf=00;36:*.cfg=00;36:*.ini=00;36:*.properties=00;36:*.yaml=00;36:*.vcl=00;36:*.c=00;33:*.cpp=00;33:*.py=00;33:*.coffesscript=00;33:*.js=00;33:*.rb=00;33:*.sh=00;33:*.zsh=00;33:*.env=00;33:*.bash=00;33:*.php=00;33:*.java=00;33:*.zcml=00;33:*.pl=00;33:*.lua=00;33:*.clj=00;33:*.cs=00;33:*.fs=00;33:*.fsx=00;33:*.go=00;33:*.db=00;32:*.sql=00;32:*.json=00;32:*.plist=00;32:*.xml=00;32:*.tex=01;37:*.rdf=01;37:*.owl=01;37:*.n3=01;37:*.ttl=01;37:*.nt=01;37:*.torrent=01;37:*.xml=01;37:*Makefile=01;37:*makefile=01;37:*Rakefile=01;37:*build.xml=01;37:*rc=01;37:*.nfo=01;37:*README=01;37:*README.txt=01;37:*readme.txt=01;37:*README.markdown=01;37:*README.md=01;37:*.cc=01;37:*.log=01;30:*.bak=01;30:*.aux=01;30:*.lof=01;30:*.lol=01;30:*.lot=01;30:*.out=01;30:*.toc=01;30:*.bbl=01;30:*.blg=01;30:*~=01;30:*#=01;30:*.part=01;30:*.incomplete=01;30:*.swp=01;30:*.tmp=01;30:*.temp=01;30:*.o=01;30:*.obj=01;30:*.pyc=01;30:*.pyo=01;30:*.class=01;30:*.cache=01;30:*.egg-info=01;30:';
export LS_COLORS

if grep -q Microsoft /proc/version; then
    # Use Windows Docker on WSL
    export DOCKER_HOST=tcp://localhost:2375
fi

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
antigen bundle aws
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

if [ "$OSTYPE" = "cygwin" ]; then
    SPACESHIP_PROMPT_ADD_NEWLINE=false
    SPACESHIP_PROMPT_SEPARATE_LINE=false
    SPACESHIP_EXEC_TIME_SHOW=false
    SPACESHIP_BATTERY_SHOW=false
    SPACESHIP_KUBECONTEXT_SHOW=false
    SPACESHIP_GIT_STATUS_SHOW=false
    # See : https://github.com/robbyrussell/oh-my-zsh/issues/5486
    antigen theme https://github.com/denysdovhan/spaceship-prompt spaceship
else
    export PROMPT_END_TAG=' $'
    export AM_ERROR_ON_START_TAG=1
    export AM_SHOW_FULL_DIR=1
    export AM_KEEP_PROMPT=1
    export AM_VERSIONS_PROMPT=(JAVA)
    export USE_NERD_FONT=1
    antigen theme eendroroy/alien-minimal alien-minimal
fi

# https://github.com/wting/autojump/issues/474
unsetopt BG_NICE

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

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
