vim.cmd([[
function UnusedDeps() abort
    exe VimuxRunCommand("unused_deps --nouse_build_api --blaze_options='--config=gmscore_tap' " . join(blaze#GetTargets(), ' '))
endfunction

nnoremap <Leader>ud :call UnusedDeps()<cr>
]])
