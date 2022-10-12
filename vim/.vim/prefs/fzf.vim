"nnoremap <silent> <C-p> :FZF -m<cr>
"let $FZF_DEFAULT_COMMAND = 'ag -g ""'

" nmap <C-P> :FZF<CR>

nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)
let g:fzf_preview_window = ['right:50%', 'ctrl-/']
let g:fzf_history_dir = '~/.local/share/fzf-history'
let g:fzf_command_prefix = 'Fzf'
" use the same keybindings for fzf as in shell
" nnoremap <silent> <c-s-t> :FzfHgFiles<CR>
" nnoremap <silent> <c-s-f> :FzfHgRg<space>
let s:hg_command = 'hg pstatus -ma -n --template= -- 2>/dev/null'
let s:rg_command = 'rg --ignore-case --hidden --follow --color auto --line-number'

command! -bang FzfHgFiles
\ call fzf#run(fzf#wrap({
\     'source': s:hg_command,
\   }),
\   <bang>0
\ )
command! -bang -nargs=* ClSearch
\ call fzf#vim#grep(
\   s:rg_command . " " . <q-args> . " " . "$(" . s:hg_command . ")", 1,
\   <bang>0 ? fzf#vim#with_preview('up:60%')
\           : fzf#vim#with_preview('right:50%'),
\   <bang>0)

