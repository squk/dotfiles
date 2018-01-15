" disable/enable the cursor line on window enter/exit
au WinEnter * setlocal cursorline
au WinLeave * setlocal nocursorline

highlight ExtraWhitespace ctermbg=red

" enable extra syntax hilighting for C++
let g:cpp_class_scope_highlight = 1
let g:cpp_experimental_template_highlight = 1
let g:cpp_experimental_template_highlight = 1

" AirLine visual settings
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

let g:airline_theme = "deus"

let g:airline_left_sep=''
let g:airline_left_alt_sep = ''
let g:airline_right_sep=''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_buffers = 0
let g:airline#extensions#tabline#show_splits = 0
let g:airline#extensions#tabline#show_tabs = 1
let g:airline#extensions#tabline#show_tab_nr = 0
let g:airline#extensions#tabline#show_tab_type = 0
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#tabline#exclude_preview = 1
let g:airline#extensions#tabline#show_close_button = 0
let g:airline#extensions#tabline#fnamemod = ':t'

let g:PaperColor_Theme_Options = {
\   'language': {
\     'python': {
\       'highlight_builtins' : 1
\     },
\     'cpp': {
\       'highlight_standard_library': 1
\     },
\     'c': {
\       'highlight_builtins' : 1
\     }
\   },
\   'theme': {
\     'default.dark': {
\       'transparent_background': 1
\     }
\   }
\ }


" Function to let me know what syntax hilighting group is under the cursor.
" Not used often
function! SynGroup()
    let l:s = synID(line('.'), col('.'), 1)
    echo synIDattr(l:s, 'name') . ' -> ' . synIDattr(synIDtrans(l:s), 'name')
endfun

" colorscheme should be assigned in .vimrc
