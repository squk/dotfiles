" -------- CTRL-P --------
let g:ctrlp_map = '<c-o>'
let g:ctrlp_show_hidden = 1
let g:ctrlp_working_path_mode = 'ra'
set wildignore+=*/tmp/*,*.so,*.swo,*.swp,*.zip,*.o,*.d " MacOSX/Linux
"let g:ctrlp_custom_ignore = '\v[\/](vendor|node_modules|target|dist|build)|(\.(swp|ico|git|svn))$'
let g:ctrlp_custom_ignore = {
    \ 'dir': 'vendor\|node_modules\|target\|dist\|build\|mntdeps',
    \'file': '\v\.(swp|ico|git|svn|exe)'
\ }
"let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']
let g:ctrlp_extensions = ['smarttabs']
let g:ctrlp_switch_buffer = 'ETVH'
let g:ctrlp_open_new_file = 't'

" Let CtrlP not go all the way up to the root of the client. Instead, consider a
" METADATA file to delimit a project.
let g:ctrlp_root_markers = ['METADATA']

" CtrlP auto cache clearing.
function! SetupCtrlP()
  if exists("g:loaded_ctrlp") && g:loaded_ctrlp
    augroup CtrlPExtension
      autocmd!
      autocmd FocusGained  * CtrlPClearCache
      autocmd BufWritePost * CtrlPClearCache
    augroup END
  endif
endfunction
if has("autocmd")
  autocmd VimEnter * :call SetupCtrlP()
endif

" Ripgrep (rg) is a super fast search utility
" Use rg for ctrl-p plugin
if executable('rg')
  set grepprg=rg\ --hidden\ --color=never
  let g:ctrlp_use_caching = 0
  let g:ctrlp_user_command = 'rg --files --hidden --color=never * %s'
endif


