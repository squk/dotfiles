" Statusline modifications, added Fugitive Status Line & Syntastic Error Message
let g:last_mode = ''
function! Mode()
  let l:mode = mode()

  if l:mode !=# g:last_mode
    let g:last_mode = l:mode

    hi User2 guifg=#005f00 guibg=#dfff00 gui=BOLD ctermfg=22 ctermbg=190 cterm=BOLD
    hi User3 guifg=#FFFFFF guibg=#414243 ctermfg=255 ctermbg=241
    hi User4 guifg=#414234 guibg=#2B2B2B ctermfg=241 ctermbg=234
    hi User5 guifg=#4e4e4e guibg=#FFFFFF gui=bold ctermfg=239 ctermbg=255 cterm=bold
    hi User6 guifg=#FFFFFF guibg=#8a8a8a ctermfg=255 ctermbg=245
    hi User7 guifg=#ffff00 guibg=#8a8a8a gui=bold ctermfg=226 ctermbg=245 cterm=bold
    hi User8 guifg=#8a8a8a guibg=#414243 ctermfg=245 ctermbg=241

    if l:mode ==# 'n'
      hi User3 guifg=#dfff00 ctermfg=190
    elseif l:mode ==# "i"
      hi User2 guifg=#005fff guibg=#FFFFFF ctermfg=27 ctermbg=255
      hi User3 guifg=#FFFFFF ctermfg=255
    elseif l:mode ==# "R"
      hi User2 guifg=#FFFFFF guibg=#df0000 ctermfg=255 ctermbg=160
      hi User3 guifg=#df0000 ctermfg=160
    elseif l:mode ==? "v" || l:mode ==# ""
      hi User2 guifg=#4e4e4e guibg=#ffaf00 ctermfg=239 ctermbg=214
      hi User3 guifg=#ffaf00 ctermfg=214
    endif
  endif

  if l:mode ==# "n"
    return "  NORMAL "
  elseif l:mode ==# "i"
    return "  INSERT "
  elseif l:mode ==# "R"
    return "  REPLACE "
  elseif l:mode ==# "v"
    return "  VISUAL "
  elseif l:mode ==# "V"
    return "  V·LINE "
  elseif l:mode ==# ""
    return "  V·BLOCK "
  else
    return l:mode
  endif
endfunction

set laststatus=2
set noshowmode
set term=xterm-256color
set statusline=%2*%{Mode()}%3*%1*
set statusline+=%#StatusLine#
set statusline+=%{strlen(fugitive#statusline())>0?'\ ':''}
set statusline+=%{matchstr(fugitive#statusline(),'(\\zs.*\\ze)')}
set statusline+=%{strlen(fugitive#statusline())>0?'\ ':'\ '}
set statusline+=%f\ %{&ro?'':''}%{&mod?'+':''}%<
set statusline+=%4*
set statusline+=%#warningmsg#
jset statusline+=%=
set statusline+=%4*
set statusline+=%#StatusLine#
set statusline+=\ %{strlen(&fileformat)>0?&fileformat.'\ \>\ ':''}
set statusline+=%{strlen(&fileencoding)>0?&fileencoding.'\ \>\ ':''}
set statusline+=%{strlen(&filetype)>0?&filetype:''}
set statusline+=\ %8*
set statusline+=%7*\ %p%%\ 
set statusline+=%6*%5*\ \ %l:%c\ 
