nnoremap <silent> <leader>yw :call WindowSwap#EasyWindowSwap()<CR>
unmap <leader>ww

" --------- SURROUND MAPPINGS ---------
" <leader>" Surround a word with "quotes"
map <leader>" ysiw"
vmap <leader>" c"<C-R>""<ESC>

" <leader>' Surround a word with 'single quotes'
map <leader>' ysiw'
vmap <leader>' c'<C-R>"'<ESC>

" <leader>' Surround a word with 'ticks'
map <leader>` ysiw`
vmap <leader>` c`<C-R>"`<ESC>

" --------- SEARCH MAPPINGS ---------
" unhilight search
nnoremap <leader><space> :nohlsearch<CR>

" --------- CLIPBOARD MAPPINGS ---------
" Paste from OS clipboard
map <leader>v    i<ESC>"+pa<ESC>
vmap <leader>v   c<ESC>"+p<ESC>
imap <leader>v    <ESC>"+pa

" --------- WINDOW/PANE MAPPINGS ---------
map <leader>wr <C-W>r
map <leader>H :wincmd H<cr>
map <leader>K :wincmd K<cr>
map <leader>L :wincmd L<cr>
map <leader>J :wincmd J<cr>
map <leader>x :wincmd x<cr>

" resize vertical split to 1/3 or 2/3 size
nnoremap <silent> <Leader>s+ :exe "vertical resize " . (winwidth(0) * 5/4)<CR>
nnoremap <silent> <Leader>s- :exe "vertical resize " . (winwidth(0) * 4/5)<CR>

" resize horizontal split to 1/3 or 2/3 size
nnoremap <silent> <Leader>x+ :exe "resize " . (winheight(0) * 3/2)<CR>
nnoremap <silent> <Leader>x- :exe "resize " . (winheight(0) * 2/3)<CR>

" --------- FORMATTING MAPPINGS ---------
" indent file
map <leader>= gg=G ``

nmap <leader>yf :let @+ = expand("%")<cr>
nmap <leader>e :e %%

" replace currently selected text with default register
" without yanking it
vnoremap <leader>p "_dP

nnoremap <leader>rp :VimuxOpenRunner<cr> :VimuxRunCommand '!!'<cr> :call VimuxSendKeys("Enter")<cr>

nnoremap <leader>s :SessionSave<CR>

" copy to attached terminal using the yank(1) script:
" https://github.com/sunaku/home/blob/master/bin/yank
function! Yank(text) abort
  let escape = system('yank', a:text)
  if v:shell_error
    echoerr escape
  else
    call writefile([escape], '/dev/tty', 'b')
  endif
endfunction
noremap <silent> <Leader>y y:<C-U>call Yank(@0)<CR>

" automatically run yank(1) whenever yanking in Vim
" (this snippet was contributed by Larry Sanderson)
function! CopyYank() abort
  call Yank(join(v:event.regcontents, "\n"))
endfunction

" autocmd TextYankPost * call CopyYank()
noremap <leader>y :call CopyYank()
vnoremap <leader>y :call CopyYank()
