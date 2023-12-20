vim.cmd([[
function s:blazeExec(cmd, targets)
    if len(a:targets) == 0
        exe VimuxRunCommand("build_target.py " . expand('%:p') . " " . a:cmd)
    else
        exe VimuxRunCommand(a:cmd . " " . join(a:targets, ' '))
    endif
endfunction

function BlazeRun() abort
    call <SID>blazeExec("blaze run", blaze#GetTargets())
endfunction

function BlazeBuild() abort
    call <SID>blazeExec("blaze build", blaze#GetTargets())
endfunction

function BlazeTest() abort
    call <SID>blazeExec("blaze test", blaze#GetTargets())
endfunction

function BlazeTestDebug() abort
    call <SID>blazeExec("blaze test --java_debug", blaze#GetTargets())
endfunction

function BuildCleanerFile() abort
    exe VimuxRunCommand("build_cleaner " . expand('%'))
endfunction

function UnusedDeps() abort
    exe VimuxRunCommand("unused_deps --nouse_build_api --blaze_options='--config=gmscore_tap' " . join(blaze#GetTargets(), ' '))
endfunction

function BuildCleanerTarget() abort
    exe VimuxRunCommand("build_cleaner " . join(blaze#GetTargets(), ' '))
endfunction

nnoremap <Leader>bc  :call BuildCleanerFile()<cr>
nnoremap <Leader>ud  :call UnusedDeps()<cr>
]])
