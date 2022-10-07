" AirLine visual settings
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

let g:airline_theme='onedark'
" let g:airline_stl_path_style = 'short'

let g:airline#extensions#coc#enabled = 1

let g:airline_left_sep=''
let g:airline_left_alt_sep = ''
let g:airline_right_sep=''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.dirty = ''
let g:airline_symbols.linenr = '␤'
"let g:airline_symbols.whitespace = 'Ξ'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
let g:airline#extensions#tabline#show_buffers = 0
let g:airline#extensions#tabline#show_splits = 1
let g:airline#extensions#tabline#show_tabs = 1
let g:airline#extensions#tabline#show_tab_nr = 0
let g:airline#extensions#tabline#show_tab_type = 0
let g:airline#extensions#tabline#exclude_preview = 1
let g:airline#extensions#tabline#show_close_button = 0
let g:airline#extensions#tabline#fnamemod = ':t'

lua << EOF
function getCitc()
    local fname = vim.api.nvim_buf_get_name(0)
    if string.find(fname, '/google/src/cloud/', 1, true) then
      local parts = split(fname, '/')
      return parts[5]
    end
end
EOF

" let g:airline_section_c = execute("lua getCitc()")
let g:airline_mode_map = {
            \ '__' : '------',
            \ 'n'  : 'NORMAL',
            \ 'c'  : 'COMMAND',
            \ 'i'  : 'INSERT',
            \ 'R'  : 'REPLACE',
            \ 's'  : 'SELECT',
            \ 'S'  : 'S-LINE',
            \ '' : 'S-BLOCK',
            \ 'v'  : 'VISUAL',
            \ 'V'  : 'V-LINE',
            \ '' : 'V-BLOCK',
            \ }

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

