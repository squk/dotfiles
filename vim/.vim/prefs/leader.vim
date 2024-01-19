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
map <leader>H :wincmd H<cr>
map <leader>K :wincmd K<cr>
map <leader>L :wincmd L<cr>
map <leader>J :wincmd J<cr>
map <leader>T :wincmd T<cr>

" resize vertical split to 1/3 or 2/3 size
nnoremap <silent> <Leader>s+ :exe "vertical resize " . (winwidth(0) * 5/4)<CR>
nnoremap <silent> <Leader>s- :exe "vertical resize " . (winwidth(0) * 4/5)<CR>

" resize horizontal split to 1/3 or 2/3 size
nnoremap <silent> <Leader>x+ :exe "resize " . (winheight(0) * 3/2)<CR>
nnoremap <silent> <Leader>x- :exe "resize " . (winheight(0) * 2/3)<CR>

" --------- FORMATTING MAPPINGS ---------
" indent file
map <leader>= gg=G ``
nmap <leader>yf :let @+ = expand("%") | let @" = expand("%")<cr>
" replace currently selected text with default register
" without yanking it
vnoremap <leader>p "_dP
nnoremap <leader><leader> :VimuxOpenRunner<cr> :VimuxRunCommand '!!'<cr> :call VimuxSendKeys("Enter")<cr>
nnoremap <leader>s :SessionSave<CR>
