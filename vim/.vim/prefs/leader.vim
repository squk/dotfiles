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

" EZ Ack search
" nnoremap <leader>a :Ack!<Space>
" nnoremap <leader>A :Ack!<Space> <C-r><C-w>

" --------- CLIPBOARD MAPPINGS ---------
" Paste from OS clipboard
map <leader>v    i<ESC>"+pa<ESC>
vmap <leader>v   c<ESC>"+p<ESC>
imap <leader>v    <ESC>"+pa

" Copy to OS clipboard
vnoremap <leader>y "yy <Bar> :call system('xclip', @y)<CR>
map <leader>y "yy <Bar> :call system('xclip', @y)<CR>
" map <leader>y !xclip -selection clipboard
" vmap <leader>y !xclip -selection clipboard<cr>
" map <leader>y   "+Y
" vmap <leader>y  "+y

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

" format HTML/JSON
map <leader>fh :%s/>\s*</>\r</g<cr>
map <leader>fj :%!python -m json.tool<cr>

map <leader>fjs :call UnMinify()<cr>
"command! UnMinify call UnMinify()
function! UnMinify()
    %s/{\ze[^\r\n]/{\r/g
    %s/){/) {/g
    %s/};\?\ze[^\r\n]/\0\r/g
    %s/;\ze[^\r\n]/;\r/g
    %s/[^\s]\zs[=&|]\+\ze[^\s]/ \0 /g
    normal ggVG=
endfunction


nmap <leader>toi :CocCommand tsserver.organizeImports<cr>

"" --------- NERD Commenter
" Create default mappings
let g:NERDCreateDefaultMappings = 0

" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1

" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1

" Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDDefaultAlign = 'left'

" Set a language to use its alternate delimiters by default
let g:NERDAltDelims_java = 1

" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1

" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1

"Enable NERDCommenterToggle to check all selected lines is commented or not
let g:NERDToggleCheckAllLines = 1

nnoremap <leader>c<Space> :call nerdcommenter#Comment(0,"toggle")<CR>
vnoremap <leader>c<Space> :call nerdcommenter#Comment(0,"toggle")<CR>

nnoremap <leader>c$ :call nerdcommenter#Comment(0,"ToEOL")<CR>
vnoremap <leader>c$ :call nerdcommenter#Comment(0,"ToEOL")<CR>

nmap <leader>yf :let @" = expand("%")<cr>
nmap <leader>ut :UndotreeToggle<cr>
nmap <leader>e :e %%

" replace currently selected text with default register
" without yanking it
vnoremap <leader>p "_dP

nnoremap <leader>rp :VimuxOpenRunner<cr> :VimuxRunCommand '!!'<cr> :call VimuxSendKeys("Enter")<cr>

"Showing highlight groups
" nmap <leader>sp :call <SID>SynStack()<CR>
nmap <leader>shg :call <SID>SynStack()<CR>
function! <SID>SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc

nnoremap <leader>s :SaveSession()<CR>
