" Set shell before loading Vundle (required for gitgutter)
set shell=/bin/bash

" Remap leader key to spacebar
let mapleader = "\<Space>"

" Use Utf-8 by default
set encoding=utf-8

" Use incremental search (search as you type)
set incsearch

" Tab stuff
set tabstop=4
set shiftwidth=4
set expandtab
set autoindent

set nocompatible              " be iMproved, required
set exrc " Enable use of directory-specific .vimrc
set secure " Only run autocommands owned by me

" Load vim-plug
if empty(glob("~/.vim/autoload/plug.vim"))
     execute '!curl --create-dirs -fLo ~/.vim/autoload/plug.vim https://raw.github.com/junegunn/vim-plug/master/plug.vim'
endif

call plug#begin('~/.vim/plugged')

Plug 'mileszs/ack.vim'
Plug 'rking/ag.vim'
Plug 'kien/ctrlp.vim'
Plug 'FelikZ/ctrlp-py-matcher'
Plug 'scrooloose/nerdtree'
Plug 'bling/vim-airline'
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

if executable("ctags")
    Plug 'majutsushi/tagbar'
endif

if executable("rustc")
    Plug 'rust-lang/rust.vim'
endif

if has("unix")
    if !has("win32unix")
        Plug 'Valloric/YouCompleteMe', { 'do': './install.py --clang-completer' }
    else
        Plug 'ervandew/supertab'
        let g:SuperTabDefaultCompletionType = "context"
    endif
endif

call plug#end()

filetype plugin indent on    " required

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
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" Color stuff
syntax enable
set background=dark
set t_Co=256
colorscheme molokai

" Line numbers
set number

" Enable mouse
set mouse=a

" Command to auto-format a Json file
command! FormatJSON %!python -m json.tool

" YouCompleteMe setup
let g:ycm_autoclose_preview_window_after_completion=1

" Send swapfiles to temp dir
set backupdir=/tmp/
set directory=/tmp/

" Always show 5 lines around cursor when scrolling
set scrolloff=5

" The Silver Searcher
" NOTE: If using this in Cygwin, make sure you have the Cygwin version of 'ag'
" as the windows one from Chocolatey will not be recognized
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Make ctrlp use ag too
  let g:ctrlp_user_command = 'ag %s -i --nocolor --nogroup -g ""'
endif

let g:ctrlp_match_func = { 'match': 'pymatcher#PyMatch' }

" Tagbar config
nnoremap <Leader>t :TagbarToggle<CR>

" Http log plugin
autocmd BufNewFile,BufRead access*.log   set syntax=httplog

" Gundo setup
nnoremap <F5> :GundoToggle<CR>
