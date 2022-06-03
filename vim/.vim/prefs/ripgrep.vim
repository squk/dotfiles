Plug 'kyoh86/vim-ripgrep'

" command! -nargs=+ -complete=file Rg :call ripgrep#search(<q-args>)
command! -nargs=+ -complete=file Rg :call s:ripgrep(<q-args>)
function s:ripgrep(searchterm)
    let l:dir = fnameescape(expand("%:p:h")."/")
    let l:rel = ripgrep#path#rel(l:dir)
    " echomsg 'DIR: ' . l:dir . '\tREL: ' . l:rel
    call ripgrep#call('rg --smart-case --json ' . a:searchterm, l:dir, l:rel)
endfunction
nnoremap <leader>rg :Rg<Space>

let g:rg_root_marks = ['BUILD', 'METADATA', '.git']
