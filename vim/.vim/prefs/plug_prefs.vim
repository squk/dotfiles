let pyxversion = 3


" -------- FZF --------
nmap <C-P> :FZF<CR>

nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)
let g:fzf_preview_window = ['right:50%', 'ctrl-/']

let g:fzf_command_prefix = 'Fzf'
" use the same keybindings for fzf as in shell
" nnoremap <silent> <c-s-t> :FzfHgFiles<CR>
" nnoremap <silent> <c-s-f> :FzfHgRg<space>
let s:hg_command = 'hg files 2>/dev/null'

command! -bang FzfHgFiles
\ call fzf#run(fzf#wrap({
\     'source': s:hg_command,
\     'options': $FZF_DEFAULT_OPTS . " " . $FZF_CTRL_T_OPTS,
\   }),
\   <bang>0
\ )
command! -bang -nargs=* FzfHgRg
\ call fzf#vim#grep(
\   s:rg_command . " " . <q-args> . " " . "$(" . s:hg_command . ")", 1,
\   <bang>0 ? fzf#vim#with_preview('up:60%')
\           : fzf#vim#with_preview('right:50%'),
\   <bang>0)

"
"
" -------- CTRL-P --------
" let g:ctrlp_map = '<c-o>'
" let g:ctrlp_show_hidden = 1
" let g:ctrlp_working_path_mode = 'ra'
" set wildignore+=*/tmp/*,*.so,*.swo,*.swp,*.zip,*.o,*.d " MacOSX/Linux
" "let g:ctrlp_custom_ignore = '\v[\/](vendor|node_modules|target|dist|build)|(\.(swp|ico|git|svn))$'
" let g:ctrlp_custom_ignore = {
"     \ 'dir': 'vendor\|node_modules\|target\|dist\|build\|mntdeps',
"     \'file': '\v\.(swp|ico|git|svn|exe)'
" \ }
" "let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']
" let g:ctrlp_extensions = ['smarttabs']
" let g:ctrlp_switch_buffer = 'ETVH'
" let g:ctrlp_open_new_file = 't'
"
" " Let CtrlP not go all the way up to the root of the client. Instead, consider a
" " METADATA file to delimit a project.
" let g:ctrlp_root_markers = ['METADATA']
"
" " CtrlP auto cache clearing.
" function! SetupCtrlP()
"   if exists("g:loaded_ctrlp") && g:loaded_ctrlp
"     augroup CtrlPExtension
"       autocmd!
"       autocmd FocusGained  * CtrlPClearCache
"       autocmd BufWritePost * CtrlPClearCache
"     augroup END
"   endif
" endfunction
" if has("autocmd")
"   autocmd VimEnter * :call SetupCtrlP()
" endif
"
" " Ripgrep (rg) is a super fast search utility
" " Use rg for ctrl-p plugin
" if executable('rg')
"   set grepprg=rg\ --hidden\ --color=never
"   let g:ctrlp_use_caching = 0
"   let g:ctrlp_user_command = 'rg --files --hidden --color=never * %s'
" endif


" -------- VIM-MARKDOWN --------
let g:vim_markdown_folding_disabled = 1


" -------- LATEX --------
let g:windowswap_map_keys = 0 "prevent default bindings
nnoremap <silent> <leader>ww :call WindowSwap#EasyWindowSwap()<CR>

"Don't ask to save when changing buffers (i.e. when jumping to a type definition)
set hidden

let g:UltiSnipsExpandTrigger = "<nop>"
inoremap <expr> <CR> pumvisible() ? "<C-R>=UltiSnips#ExpandSnippetOrJump()<CR>" : "\<CR>"
let g:vim_php_refactoring_use_default_mapping = 0
nnoremap <Leader>da :call PhpDocAll()<CR>

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

let g:php_html_in_heredoc = 0
let g:php_html_in_nowdoc = 0
let g:php_sql_query = 0
let g:php_sql_heredoc = 0
let g:php_sql_nowdoc = 0

let jshint2_read = 1
" set statusline+=%#warningmsg#
" set statusline+=%{SyntasticStatuslineFlag()}
" set statusline+=%*
set statusline=%{pathshorten(expand('%:f'))}

let g:rainbow_active = 1 "set to 0 if you want to enable it later via :RainbowToggle

" FZF
"nnoremap <silent> <C-p> :FZF -m<cr>
"let $FZF_DEFAULT_COMMAND = 'ag -g ""'
let g:fzf_history_dir = '~/.local/share/fzf-history'

" vim-easy-align

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)
let g:scratchpad_ftype = 'md'

" NERDTree
" Help w/ lag
let g:NERDTreeLimitedSyntax = 1

let s:brown = "964B00"
let s:aqua =  "3AFFDB"
let s:blue = "689FB6"
let s:darkBlue = "44788E"
let s:purple = "834F79"
let s:lightPurple = "834F79"
let s:red = "AE403F"
let s:beige = "F5C06F"
let s:yellow = "F09F17"
let s:orange = "D4843E"
let s:darkOrange = "F16529"
let s:pink = "CB6F6F"
let s:salmon = "EE6E73"
let s:green = "8FAA54"
let s:lightGreen = "31B53E"
let s:white = "FFFFFF"
let s:rspec_red = 'FE405F'
let s:git_orange = 'F54D27'

" If you have vim-devicons you can customize your icons for each file type.
let g:NERDTreeExtensionHighlightColor = {} "this line is needed to avoid error
let g:NERDTreeExtensionHighlightColor['java'] = s:lightGreen "assigning it to an empty string will skip highlight

let g:jdbPort="5005"

" Set a nicer foldtext function
set foldtext=MyFoldText()
function! MyFoldText()
  let line = getline(v:foldstart)
  if match( line, '^[ \t]*\(\/\*\|\/\/\)[*/\\]*[ \t]*$' ) == 0
    let initial = substitute( line, '^\([ \t]\)*\(\/\*\|\/\/\)\(.*\)', '\1\2', '' )
    let linenum = v:foldstart + 1
    while linenum < v:foldend
      let line = getline( linenum )
      let comment_content = substitute( line, '^\([ \t\/\*]*\)\(.*\)$', '\2', 'g' )
      if comment_content != ''
        break
      endif
      let linenum = linenum + 1
    endwhile
    let sub = initial . ' ' . comment_content
  else
    let sub = line
    let startbrace = substitute( line, '^.*{[ \t]*$', '{', 'g')
    if startbrace == '{'
      let line = getline(v:foldend)
      let endbrace = substitute( line, '^[ \t]*}\(.*\)$', '}', 'g')
      if endbrace == '}'
        let sub = sub.substitute( line, '^[ \t]*}\(.*\)$', '...}\1', 'g')
      endif
    endif
  endif
  let n = v:foldend - v:foldstart + 1
  let info = " " . n . " lines"
  let sub = sub . "                                                                                                                  "
  let num_w = getwinvar( 0, '&number' ) * getwinvar( 0, '&numberwidth' )
  let fold_w = getwinvar( 0, '&foldcolumn' )
  let sub = strpart( sub, 0, winwidth(0) - strlen( info ) - num_w - fold_w - 1 )
  return sub . info
endfunction
