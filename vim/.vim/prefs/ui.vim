" disable/enable the cursor line on window enter/exit
au WinEnter * setlocal cursorline
au WinLeave * setlocal nocursorline

highlight ExtraWhitespace ctermbg=red

" enable extra syntax hilighting for C++
let g:cpp_class_scope_highlight = 1
let g:cpp_experimental_template_highlight = 1

" Function to let me know what syntax hilighting group is under the cursor.
" Not used often
function! SynGroup()
    let l:s = synID(line('.'), col('.'), 1)
    echo synIDattr(l:s, 'name') . ' -> ' . synIDattr(synIDtrans(l:s), 'name')
endfun
