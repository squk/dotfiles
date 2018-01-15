"--------------------------------------------------------------------------------
"     File Name           :     /Users/christian/.vimrc
"     Created By          :     christian
"     Creation Date       :     [2017-11-30 15:35]
"     Last Modified       :     [2017-11-30 15:35]
"     Description         :      Vim config
"--------------------------------------------------------------------------------

set nocompatible              " be iMproved, required

filetype off                  " required

" -----------------------------------------------------------
" ------------------------PLUGINS----------------------------
" -----------------------------------------------------------
call plug#begin('~/.vim/plugged')
    source ~/.vim/prefs/plugins.vim
call plug#end()            " required

filetype plugin on     " redundant?

source ~/.vim/prefs/init.vim
source ~/.vim/prefs/plug_prefs.vim
source ~/.vim/prefs/mappings.vim
source ~/.vim/prefs/leader.vim
source ~/.vim/prefs/ui.vim

" auto-reload vimrc on save
augroup myvimrc
    au!
    au BufWritePost .vimrc,_vimrc,vimrc,.gvimrc,_gvimrc,gvimrc,*.vim nested so $MYVIMRC | if has('gui_running') | so $MYGVIMRC | endif
augroup END

set directory=~/.vim/tmp/swap
set undodir=~/.vim/tmp/undo
set backupdir=~/.vim/tmp/bak

fun! InitBex()
 let myvar = strftime("(%y%m%d)[%Hh%M]")
 let myvar = "set backupext=_". myvar
 execute myvar
 echo myvar
endfun
map <Esc> :call InitBex()<CR>

fun! NewInitBex()
    let &bex = '-' . strftime("(%Y%m%d)-{%H%M}")
endfun

autocmd BufWritePre * call NewInitBex()

set noshowmode
set encoding=utf-8

let base16colorspace=256
set colorcolumn=80

set background=dark
colorscheme osiris
