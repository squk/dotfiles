" --------- MAPPINGS FOR QUICK CONFIG EDITS ---------
" mnemonic: (e)dit (v)imrc
nmap <leader>ev :tabedit $MYVIMRC<cr>

" mnemonic: (e)dit (t)mux.conf
nmap <leader>et :tabedit ~/.tmux.conf<cr>

" mnemonic: (e)dit (g)oogle.vim
nmap <leader>eg :tabedit ~/.vim/prefs/google.vim<cr>

" mnemonic: (e)dit (b)ash_profile
nmap <leader>eb :tabedit ~/.bash_profile<cr>

" mnemonic: (e)dit (f)tplugin
nmap <leader>ef :tabedit ~/.vim/after/ftplugin<cr>

" mnemonic: (e)dit (p)lugins
nmap <leader>ep :tabedit ~/.vim/prefs/plugins.vim<cr>

" mnemonic: (e)dit (c)onfigs     * opens NERDTree on the prefs dir
nmap <leader>ec :tabedit ~/.vim/prefs/<cr>

" mnemonic: (e)dit (p)refs, (i)nit.vim
nmap <leader>epi :tabedit ~/.vim/prefs/init.vim<cr>

" mnemonic: (e)dit (p)refs, (l)eader.vim
nmap <leader>epl :tabedit ~/.vim/prefs/leader.vim<cr>

" mnemonic: (e)dit (p)refs, (c)oc.vim
nmap <leader>epc :tabedit ~/.vim/prefs/coc.vim<cr>

" mnemonic: (e)dit (p)refs, (m)appings.vim
nmap <leader>epm :tabedit ~/.vim/prefs/mappings.vim<cr>

" mnemonic: (e)dit (p)refs, (p)lug_prefs.vim
nmap <leader>epp :tabedit ~/.vim/prefs/plug_prefs.vim<cr>

" mnemonic: (e)dit (p)refs, (u)i.vim
nmap <leader>epu :tabedit ~/.vim/prefs/ui.vim<cr>
"
" mnemonic: (e)dit (p)refs, (g)olang.vim
nmap <leader>epg :tabedit ~/.vim/prefs/google.vim<cr>

" mnemonic: (e)dit (z)shrc
nmap <leader>ez :tabedit ~/.zshrc<cr>
"
" mnemonic: (i)nsert (l)ambda
imap <leader>il <C-K>l*


" HEX<->ASCII
" mnemonic: (h)ex (t)o (a)scii
vnoremap <leader>hta :<c-u>s/\%V\x\x/\=nr2char(printf("%d", "0x".submatch(0)))/g<cr><c-l>`<
" mnemonic: (a)scii (t)o (h)ex
vnoremap <leader>ath :<c-u>s/\%V./\=printf("%x",char2nr(submatch(0)))/g<cr><c-l>`<



let g:windowswap_map_keys = 0 "prevent default bindings
nnoremap <silent> <leader>yw :call WindowSwap#MarkWindowSwap()<CR>


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
 " vnoremap <silent><Leader>y "yy <Bar> :call system('xclip', @y)<CR>
map <leader>y !xclip -selection clipboard
vmap <leader>y !xclip -selection clipboard<cr>
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


" --------- FUGITIVE MAPPINGS ---------
nmap <leader>dg :diffget<cr>
nmap <leader>dp :diffput<cr>
nmap <leader>du :diffupdate<cr>
vmap <leader>dg :diffget<cr>
vmap <leader>dp :diffput<cr>
vmap <leader>du :diffupdate<cr>

nmap <leader>giw :Gwrite<cr>
nmap <leader>gic :Gcommit -v<cr>
nmap <leader>gid :Gdiff<cr>
nmap <leader>gis :Gstatus<cr>

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

nnoremap ,c<Space> :call nerdcommenter#Comment(0,"toggle")<CR>
vnoremap ,c<Space> :call nerdcommenter#Comment(0,"toggle")<CR>

nnoremap ,c$ :call nerdcommenter#Comment(0,"ToEOL")<CR>
vnoremap ,c$ :call nerdcommenter#Comment(0,"ToEOL")<CR>
