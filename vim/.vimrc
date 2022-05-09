set nocompatible              " be iMproved, required

let mapleader="," " BEST LEADER OF ALL TIME (BLOT)
filetype off                  " required
set rtp+=~/.vim/after

" -----------------------------------------------------------
" ------------------------PLUGINS----------------------------
" -----------------------------------------------------------
call plug#begin('~/.vim/plugged')
  source ~/.vim/prefs/plugins.vim
  source ~/.vim/prefs/init.vim
  if filereadable(expand("~/.vimrc.local"))
      source ~/.vim/prefs/google.vim
  endif
  source ~/.vim/prefs/mappings.vim
  source ~/.vim/prefs/leader.vim
  source ~/.vim/prefs/plug_prefs.vim
  source ~/.vim/prefs/ui.vim
  source ~/.vim/prefs/golang.vim
  source ~/.vim/prefs/ultisnips.vim
  " source ~/.vim/prefs/coc.vim
  " source ~/.vim/prefs/asynclsp.vim
  " source ~/.vim/prefs/ycm.vim
call plug#end()            " required

source ~/.vim/prefs/cmp.vim
source ~/.vim/prefs/google_comments.vim
" source ~/.vim/prefs/ale.vim

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
