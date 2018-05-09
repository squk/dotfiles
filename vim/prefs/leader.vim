" --------- MAPPINGS FOR QUICK CONFIG EDITS ---------
    " mnemonic: (e)dit (v)imrc
    nmap <leader>ev :tabedit $MYVIMRC<cr>

    " mnemonic: (e)dit (t)mux.conf
    nmap <leader>et :tabedit ~/.tmux.conf<cr>

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

    " mnemonic: (e)dit (p)refs, (m)appings.vim
    nmap <leader>epm :tabedit ~/.vim/prefs/mappings.vim<cr>

    " mnemonic: (e)dit (p)refs, (p)lug_prefs.vim
    nmap <leader>epp :tabedit ~/.vim/prefs/plug_prefs.vim<cr>

    " mnemonic: (e)dit (p)refs, (u)i.vim
    nmap <leader>epu :tabedit ~/.vim/prefs/ui.vim<cr>

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


" --------- SEARCH MAPPINGS ---------
    " unhilight search
    nnoremap <leader><space> :nohlsearch<CR>

   " EZ Ack search
    nnoremap <leader>a :Ack!<Space>
    nnoremap <leader>A :Ack!<Space> <C-r><C-w>


" --------- CLIPBOARD MAPPINGS ---------
    " copy current filename into system clipboard - mnemonic: (c)urrent(f)ilename
    nnoremap <leader>cf :let @* = expand("%:~")<CR>
    nnoremap <leader>cn :let @* = expand("%:t")<CR>

    " Paste from OS clipboard
    map <leader>v    i<ESC>"+pa<ESC>
    vmap <leader>v   c<ESC>"+p<ESC>
    imap <leader>v    <ESC>"+pa

    " Copy to OS clipboard
    map <leader>y   "+Y
    vmap <leader>y  "+y


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


" --------- GOLANG MAPPINGS ---------
    nmap <leader>gor :GoRun<cr>
    nmap <leader>god :GoDef<cr>
    nmap <leader>gob :GoBuild<cr>
    nmap <leader>gof :GoFmt<cr>
    nmap <leader>goa :GoAddTags<cr>


" --------- FUGITIVE MAPPINGS ---------
    nmap <leader>dg :diffget<cr>
    nmap <leader>dp :diffput<cr>
    nmap <leader>du :diffupdate<cr>
    vmap <leader>dg :diffget<cr>
    vmap <leader>dp :diffput<cr>
    vmap <leader>du :diffupdate<cr>

    nmap <leader>gw :Gwrite<cr>
    nmap <leader>gc :Gcommit -v<cr>
    nmap <leader>gd :Gdiff<cr>
    nmap <leader>gs :Gstatus<cr>

" --------- OBSESSION MAPPINGS ---------
    nnoremap <leader>s :Obsess<CR>
