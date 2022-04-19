Glug youcompleteme-google

let g:ycm_key_invoke_completion = '<C-Space>'
let g:ycm_filetype_specific_completion_to_disable = {'cpp': 1, 'c': 1}

let g:ycm_language_server =
  \ [
  \   {
  \     'name': 'ciderlsp',
  \     'cmdline': [ '/google/bin/releases/cider/ciderlsp/ciderlsp', '--noforward_sync_responses' ],
  \     'filetypes': [ 'java' ]
  \   },
  \ ]

nmap <silent> gd :YcmCompleter GoToDeclaration<CR>
nmap <silent> gt :YcmCompleter GetType<CR>
nmap <silent> gr :YcmCompleter GoToReferences<CR>
nmap <leader>qf  :YcmCompleter FixIt<CR>
nmap <leader>rn  :YcmCompleter RefactorRename<space>

let s:ycm_hover_popup = -1
function s:Hover()
  let response = youcompleteme#GetCommandResponse( 'GetDoc' )
  if response == ''
    return
  endif

  call popup_hide( s:ycm_hover_popup )
  let s:ycm_hover_popup = popup_atcursor( balloon_split( response ), {} )
endfunction

" CursorHold triggers in normal mode after a delay
autocmd CursorHold * call s:Hover()
" Or, if you prefer, a mapping:
" nnoremap <silent> <leader>D :call <SID>Hover()<CR>
nnoremap <silent> <leader>D <plug>(YCMHover)
