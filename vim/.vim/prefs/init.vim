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

" ------------------------------------------------
" -------------------SEARCHING--------------------
" ------------------------------------------------
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

" set clipboard=unnamed
set shortmess=A

set updatetime=100
