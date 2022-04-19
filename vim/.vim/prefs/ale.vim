function! s:FindProjectRoot(buffer) abort
  for l:path in ale#path#Upwards(expand('#' . a:buffer . ':p:h'))
    if filereadable(l:path . '/BUILD')
      return l:path
    endif
  endfor
endfunction

let ciderlsp = {
\   'name': 'CiderLSP',
\   'lsp': 'stdio',
\   'executable': '/google/bin/releases/cider/ciderlsp/ciderlsp',
\   'command': '%e --noforward_sync_responses',
\   'project_root': function('s:FindProjectRoot'),
\}

call ale#linter#Define('java', ciderlsp)
let g:ale_lint_on_save = 1
let g:ale_detail_to_floating_preview = 1
let g:ale_linters={'java': ['CiderLSP']}
let g:ale_completion_enabled = 1
