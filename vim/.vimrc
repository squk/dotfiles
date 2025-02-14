set nocompatible              " be iMproved, required

let mapleader="," " BEST LEADER OF ALL TIME (BLOT)
filetype off                  " required

set directory=/tmp
set undofile
set nobackup
set formatoptions+=j
set nowritebackup
set termguicolors

set laststatus=2
set cmdheight=1
set relativenumber
set copyindent
set preserveindent
set autoindent

set wrap
set linebreak
set showbreak=⇇

set number
set showcmd
set cursorline
set showmatch
set visualbell      " don't beep
set history=6000    " remember more commands and search history
set undolevels=6000 " use many levels of undo

set ignorecase   " ignore case when searching
set smartcase    " ignore case if search pattern is all lowercase, case-sensitive otherwise
set incsearch    " search as characters are entered
set hlsearch     " highlight matches

set splitright     " Puts new vsplit windows to the right of the current
set splitbelow     " Puts new split windows to the bottom of the current

set shortmess=A " disable swapg
set shortmess+=O
set modifiable
set noscrollbind
set expandtab

set encoding=utf-8
set t_Co=256
let base16colorspace=256
set colorcolumn=100
set background=dark
let $NVIM_TUI_ENABLE_TRUE_COLOR=1


let g:lsp_log_verbose = 1
let g:lsp_log_file = expand('~/vim-lsp.log')

"Don't ask to save when changing buffers (i.e. when jumping to a type definition)
set hidden

" makes sure that when opening, files are normal, i.e. not folded.
set nofoldenable

" Disable built in neovim plugins to speed up
let g:loaded_matchparen        = 1
let g:loaded_matchit           = 1
let g:loaded_logiPat           = 1
let g:loaded_rrhelper          = 1
let g:loaded_tarPlugin         = 1
" let g:loaded_man               = 1
let g:loaded_gzip              = 1
let g:loaded_zipPlugin         = 1
let g:loaded_2html_plugin      = 1
let g:loaded_shada_plugin      = 1
let g:loaded_spellfile_plugin  = 1
let g:loaded_netrwPlugin       = 0
let g:loaded_tutor_mode_plugin = 0
let g:loaded_remote_plugins    = 1

filetype plugin indent on
syntax on

source ~/.vim/prefs/mappings.vim
source ~/.vim/prefs/leader.vim
source ~/.vim/prefs/mappings.vim
source ~/.vim/prefs/leader.vim
