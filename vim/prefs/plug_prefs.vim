" -------- NERDTree --------
map <C-n> :NERDTreeToggle<CR>
map <C-t> :TagbarToggle<CR>
let NERDTreeShowHidden=1


" -------- VIM-GO --------
let g:go_fmt_command = "goimports"
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_fields = 1
let g:go_highlight_types = 1
let g:go_highlight_structs = 1
let g:go_highlight_interfaces = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1

let g:syntastic_go_checkers = ['golint', 'govet', 'errcheck']

" get rid of bull shit mappings
let g:go_doc_keywordprg_enabled = 0
let g:go_def_mapping_enabled = 0


" -------- CTRL-P --------
let g:ctrlp_show_hidden = 1
let g:ctrlp_working_path_mode = 'ra'
set wildignore+=*/tmp/*,*.so,*.swo,*.swp,*.zip,*.o,*.d " MacOSX/Linux
let g:ctrlp_custom_ignore = '\v[\/](node_modules|target|dist)|(\.(swp|ico|git|svn))$'
let g:ctrlp_extensions = ['smarttabs']
let g:ctrlp_switch_buffer = 'ETVH'
let g:ctrlp_open_new_file = 't'


" -------- VIM-MARKDOWN --------
let g:vim_markdown_folding_disabled = 1


" -------- LATEX --------
nnoremap <leader>cl :w<CR>:!rubber --pdf --warn all %<CR>
nnoremap <leader>ol :!open -a Preview %:r.pdf &<CR><CR>


" ------- COMPLETOR --------
let g:completor_completion_delay=80
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<cr>"

"
let g:ansible_options = {'ignore_blank_lines': 0}
