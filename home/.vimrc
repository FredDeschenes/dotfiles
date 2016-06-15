if has("unix")
  " Set shell before loading Vim-Plug (required for gitgutter)
  set shell=/bin/bash

  set backupdir=/tmp/
  set directory=/tmp/
else
  set noswapfile
  set nobackup
endif

let mapleader = "\<Space>" " Remap leader key to spacebar
set encoding=utf-8
set incsearch
set tabstop=4
set shiftwidth=4
set expandtab
set autoindent
set nocompatible
set exrc " Enable use of directory-specific .vimrc
set secure " Only run autocommands owned by me
set number
set mouse=a
set scrolloff=5 " Always show 5 lines around cursor when scrolling
set fileformats=unix,dos,mac " Use 'unix' fileformat by default
filetype plugin indent on

if has("gui")
  set guioptions-=m  "remove menu bar
  set guioptions-=T  "remove toolbar
  set guioptions-=r  "remove right-hand scroll bar
  set guioptions-=L  "remove left-hand scroll bar
  nnoremap <C-F1> :if &go=~#'m'<Bar>set go-=m<Bar>else<Bar>set go+=m<Bar>endif<CR>
  set guifont=Hack:h9:cANSI
  if has("win32")
    " Maximize window on launch
    " http://vim.wikia.com/wiki/Maximize_or_set_initial_window_size
    " ~x = English, ~n = French
    au GUIEnter * simalt ~n
  endif
endif

" Load vim-plug if not installed
if executable("curl") && empty(glob("~/.vim/autoload/plug.vim"))
  execute '!curl --create-dirs -fLo ~/.vim/autoload/plug.vim https://raw.github.com/junegunn/vim-plug/master/plug.vim'
endif

if has("unix")
  call plug#begin('~/.vim/plugged')
else
  call plug#begin('~/vimfiles/bundle')
endif

Plug 'mileszs/ack.vim'
Plug 'rking/ag.vim'
Plug 'kien/ctrlp.vim'
Plug 'FelikZ/ctrlp-py-matcher'
Plug 'scrooloose/nerdtree'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'jreybert/vimagit'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tomasr/molokai'
Plug 'Raimondi/delimitMate'
Plug 'vim-scripts/LargeFile'
Plug 'tfnico/vim-gradle'
Plug 'christoomey/vim-tmux-navigator'
Plug 'airblade/vim-gitgutter'
Plug 'fidian/hexmode'
Plug 'ekalinin/Dockerfile.vim'
Plug 'smerrill/vcl-vim-plugin'
Plug 'FredDeschenes/httplog'
Plug 'ntpeters/vim-better-whitespace'
Plug 'udalov/kotlin-vim'
Plug 'sjl/gundo.vim', { 'on': 'GundoToggle' }
Plug 'jiangmiao/auto-pairs'
Plug 'xolox/vim-shell'
Plug 'xolox/vim-misc'

if executable("ctags")
  Plug 'majutsushi/tagbar'
  nnoremap <Leader>t :TagbarToggle<CR>
endif

if executable("rustc")
  Plug 'rust-lang/rust.vim'
endif

if has("unix") && !has("win32unix")
  Plug 'Valloric/YouCompleteMe', { 'do': './install.py' }
else
  Plug 'ervandew/supertab'
  let g:SuperTabDefaultCompletionType = "context"
endif

call plug#end()

" vim-airline
set timeoutlen=500
set laststatus=2
set noshowmode
let g:airline_theme = 'molokai'
let g:airline_powerline_fonts = 1

if !executable('ack')
  let g:ackprg = 'ack.cmd'
endif

" NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
map <C-n> :NERDTreeToggle<CR>
map ,m :NERDTreeFind<CR>
autocmd StdinReadPre * let s:std_in=1

" Color stuff
syntax enable
set background=dark
if has("termguicolors")
  " 24 bit color
  set t_8f=[38;2;%lu;%lu;%lum
  set t_8b=[48;2;%lu;%lu;%lum
set termguicolors
end
colorscheme molokai

command! FormatJSON %!python -m json.tool
command! RemoveTrailingWhitespace %s/\s*$//g

" YouCompleteMe setup
let g:ycm_autoclose_preview_window_after_completion=1

" The Silver Searcher
" NOTE: If using this in Cygwin, make sure you have the Cygwin version of 'ag'
" as the windows one from Chocolatey will not be recognized
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Make ctrlp use ag too
  if has('win32') && !has('win32unix')
    " Windows version of 'ag' has parameters in a different order...
    let g:ctrlp_user_command = 'ag -i --nocolor --nogroup --hidden -g "" %s'
  else
    let g:ctrlp_user_command = 'ag %s -i --nocolor --nogroup -g ""'
  endif
endif

let g:ctrlp_match_func = { 'match': 'pymatcher#PyMatch' }

" Http log plugin
autocmd BufNewFile,BufRead access*.log   set syntax=httplog

" Gundo setup
nnoremap <F5> :GundoToggle<CR>
