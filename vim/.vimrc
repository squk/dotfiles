set nocompatible              " be iMproved, required

let mapleader="," " BEST LEADER OF ALL TIME (BLOT)
filetype off                  " required
set rtp+=~/.vim/after

set directory=/tmp
set undodir=/tmp
set nobackup
set nowritebackup
au BufWritePre * let &bex = '@' . strftime("%F.%H:%M")

autocmd BufWritePre * StripWhitespace
set termguicolors
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
let &t_AB="\e[48;5;%dm"
let &t_AF="\e[38;5;%dm"
syntax on

set laststatus=2
set cmdheight=1
set ttyfast
set relativenumber
set copyindent
set preserveindent
set lazyredraw " Enable if running slow...
set autoindent

set wrap
set linebreak
set textwidth=79
set showbreak=⇇

" use intelligent indentation for C
" configure tabwidth and insert spaces instead of tabs
set tabstop=4        " tab width is 4 spaces
set shiftwidth=4     " indent also with 4 spaces
set expandtab        " expand tabs to spaces

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

set scrolljump=5   " Line to scroll when cursor leaves screen
set scrolloff=3    " Minumum lines to keep above and below cursor

" makes sure that when opening, files are normal, i.e. not folded.
set nofoldenable
set foldmethod=syntax

let g:clipboard = #{
      \   name: 'xsel',
      \   copy: {
      \     '+': ['xclip', '--nodetach', '-i', '-b'],
      \     '*': ['xclip', '--nodetach', '-i', '-p'],
      \   },
      \   paste: {
      \     '+': ['xclip', '-o', '-b'],
      \     '*': ['xclip', '-o', '-p'],
      \   },
      \   cache_enabled: 1,
      \ }
set shortmess=A

set updatetime=100

call plug#begin('~/.vim/plugged')
  source ~/.vim/prefs/plugins.vim
  if filereadable(expand("~/.vimrc.local"))
      source ~/.vimrc.local
  endif

  if filereadable(expand("~/use_google"))
      source ~/.vim/prefs/google.vim
  endif

   source ~/.vim/prefs/mappings.vim
   source ~/.vim/prefs/leader.vim
   source ~/.vim/prefs/plug_prefs.vim
   source ~/.vim/prefs/ui.vim
   source ~/.vim/prefs/golang.vim
   source ~/.vim/prefs/ultisnips.vim
   source ~/.vim/prefs/ripgrep.vim
   source ~/.vim/prefs/fzf.vim
   source ~/.vim/prefs/devicons.vim
   source ~/.vim/prefs/airline.vim
call plug#end()            " required

" Require CiderLSP and Diagnostics modules
" IMPORTANT: Must come after plugins are loaded
lua << EOF
  -- CiderLSP
  vim.opt.completeopt = { "menu", "menuone", "noselect" }

  require 'lspconfig'
  require("lsp")
  require("diagnostics")
  require("treesitter")
  require("telescope_config")

EOF
if filereadable(expand("~/use_google"))
    source ~/.vim/prefs/cmp.vim
    source ~/.vim/prefs/imp.vim
endif

filetype plugin on     " redundant?
filetype plugin indent on

" auto-reload vimrc on save
augroup myvimrc
    au!
au BufWritePost .vimrc,_vimrc,.vimrc.local,vimrc,.gvimrc,_gvimrc,gvimrc,*.vim nested so $MYVIMRC | if has('gui_running') | so $MYGVIMRC | endif
augroup END

fun! NewInitBex()
    let &bex = '-' . strftime("(%Y%m%d)-{%H%M}")
endfun

autocmd BufWritePre * call NewInitBex()

set noshowmode
set encoding=utf-8

set t_Co=256

let base16colorspace=256
set colorcolumn=100
if has('macunix')
    let g:python3_host_prog='/usr/local/bin/python3'
    let g:python_host_prog='/usr/local/bin/python3'
else
    let g:python3_host_prog='/usr/bin/python3'
    let g:python_host_prog='/usr/bin/python'
endif

if (has("termguicolors"))
 set termguicolors
endif
set background=dark
let $NVIM_TUI_ENABLE_TRUE_COLOR=1
colorscheme quantum
let g:airline_theme='quantum'
set modifiable
set omnifunc= completeopt=menuone,noinsert,noselect

let g:lsp_log_verbose = 1
let g:lsp_log_file = expand('~/vim-lsp.log')

"Don't ask to save when changing buffers (i.e. when jumping to a type definition)
set hidden
