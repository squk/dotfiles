source /usr/share/vim/google/glug/bootstrap.vim
source /usr/share/vim/google/core.vim

Plug 'vim-scripts/vcscommand.vim'
Plug 'sso://googler@user/piloto/cmp-nvim-ciderlsp'

let g:VCSCommandDisableMappings = 1

let g:signify_skip_filename_pattern = ['\.pipertmp.*']

Glug alert
Glug csearch
Glug codefmt ktfmt_executable=`["/google/bin/releases/kotlin-google-eng/ktfmt/ktfmt_deploy.jar", "--google-style"]`
Glug codefmt-google
Glug languages
" applies google coding style settings to files whitelisted as google code. probably also want
Glug googlestyle
" internal spell-checking integration and improved default configuration.
Glug googlespell
" hooks for google-internal virtual file paths such as //depot and /cns.
Glug googlepaths
" core syntax and filetype settings for google-internal filetypes.
Glug google-filetypes
Glug ft-java
Glug ft-kotlin
Glug ft-proto
Glug critique
Glug piper
Glug gtimporter
Glug blaze
let g:blazevim_quickfix_autoopen = 1

Glug buganizer plugin[mappings]
Glug relatedfiles plugin[mappings]
Glug g4

" Update the current file's build deps
Plug 'junegunn/fzf', { 'do': { -> fzf#install() }, 'commit': '3f75a83' }
Plug 'junegunn/fzf.vim'
Glug outline-window
Glug fzf-query

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

nnoremap <Leader>br  :call BlazeRun()<cr>
nnoremap <Leader>bb  :call BlazeBuild()<cr>
nnoremap <Leader>bt  :call BlazeTest()<cr>
nnoremap <Leader>btd  :call BlazeTestDebug()<cr>
nnoremap <Leader>bc  :call BuildCleanerTarget()<cr>
nnoremap <Leader>bcf  :call BuildCleanerFile()<cr>
nnoremap <Leader>ud  :call UnusedDeps()<cr>

let g:asyncrun_open = 1

function! s:AsyncBlaze(cmd, targets) abort
  "open cwindow manually and immediately when blaze starts.
  "simulate the same behavior from google-emacs blaze plugin.
  let l:aro = g:asyncrun_open
  let g:asyncrun_open = 0
  let l:target = ':'.expand('%:r')
  call setqflist([]) | copen 15
  " don't use !, so we scrolling the output.
  call asyncrun#run("", {"rows": 15}, a:cmd . ' ' . join(a:targets, ' '))
  let g:asyncrun_open = l:aro
endfunction

function AsyncBlazeBuild() abort
    call <SID>AsyncBlaze("blaze build", blaze#GetTargets())
endfunction

function AsyncBlazeTest() abort
    call <SID>AsyncBlaze("blaze test", blaze#GetTargets())
endfunction

augroup autoformat_settings
  autocmd FileType borg,gcl,patchpanel AutoFormatBuffer gclfmt
  autocmd FileType bzl AutoFormatBuffer buildifier
  autocmd FileType c,cpp,javascript,typescript AutoFormatBuffer clang-format
  autocmd FileType dart AutoFormatBuffer dartfmt
  autocmd FileType go AutoFormatBuffer gofmt
  autocmd FileType java AutoFormatBuffer google-java-format
  autocmd FileType jslayout AutoFormatBuffer jslfmt
  autocmd FileType markdown AutoFormatBuffer mdformat
  autocmd FileType ncl AutoFormatBuffer nclfmt
  autocmd FileType python AutoFormatBuffer pyformat
  autocmd FileType soy AutoFormatBuffer soyfmt
  autocmd FileType textpb AutoFormatBuffer text-proto-format
  autocmd FileType proto AutoFormatBuffer protofmt
  autocmd FileType sql AutoFormatBuffer format_sql
  autocmd FileType kotlin AutoFormatBuffer ktfmt
  " autocmd FileType html,css,json AutoFormatBuffer js-beautify
augroup END

function! CitCWorkspace()
    let l:workspace = substitute(getcwd(), '/google/src/cloud/[^/]\+/\([^/]\+\)/.*', '\1', 'g')
    return l:workspace
endfunction

function! G4Blame(...)
  " Grab the filename from the argument, use expand() to expand '%'.
  if a:0 > 0
    let file = expand(a:1)
  else
    let file = expand('%')
  endif
  " Lock scrolling in right pane
  setl scb
  " Create left pane
  vnew
  " It's 37 columns wide
  vert res 37
  " Get the output, split it on newline and keep empty lines, skip the first 2
  " lines because they're headers we don't need, and put it in starting on line
  " 1 of the left pane
  call setline(1, split(system('g4 blame ' . file), '\n', 1)[2:])
  " Lock scrolling in left pane, turn off word wrap, set the buffer as
  " not-modified, remove any listchars highlighting (common in google code), set
  " it readonly (to make modifications slightly more annoying).
  setl scb nowrap nomod nolist ro
  " Move back to the right pane (not sure if there's a better way to do this?)
  exe "normal \<c-w>\<right>"
  " if a file was specified, open it
  if a:0 > 0
    execute "e ". file
  endif
  " Get the non-active pane scrolled to the same relative offset.
  syncbind
endfunction

com! -nargs=? -complete=file Blame :call G4Blame(<f-args>)

" nnoremap <leader>cs :FzfCs<space>
" The buffer n can be replaced by any other unused buffer.
" <c-u> removes the visual range because csearch doesn't support ranges.
" Removes newlines to allow the entire line search using V-LINE mode.
" vnoremap <leader>cs "ny:<c-u>FzfCs "<c-r>=substitute(@n, '\n', '', '')<cr>"<cr>
"
" nnoremap <leader>CS :FzfCs<Space> <C-r><C-w> <cr>

nnoremap <leader>cc :CritiqueUnresolvedComments<space><cr>

" nnoremap <leader>ps :PiperSelectActiveFiles<CR>
nnoremap <leader>ps :FzfHgFiles<CR>
nnoremap <leader>pl :PiperLoadActiveAsBuffers<CR>
nnoremap <leader>po :PiperOpenPath<CR>

" search in codesearch for the word under the cursor
nnoremap <leader>ws :CorpWebCs <cword> <CR>
" search in codesearch for the current file
nnoremap <leader>wf :CorpWebCsFile<CR>

nmap <leader>rbs ss <leader>rb
