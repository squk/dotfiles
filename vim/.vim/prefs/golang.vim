" -------- VIM-GO --------
let g:go_def_mode='gopls'
let g:go_info_mode="gopls"
let g:go_auto_type_info='gopls'
let g:go_fmt_command = "goimports"
let g:go_metalinter_autosave = 0
let g:go_metalinter_command = "golangci-lint"
let g:go_metalinter_enabled = ['govet', 'errcheck', 'deadcode', 'staticcheck', 'ineffassign']
let g:go_metalinter_deadline = "10s"
let g:go_metalinter_autosave_enabled = ['govet', 'errcheck', 'deadcode', 'staticcheck', 'ineffassign']

let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_methods = 1
let g:go_highlight_fields = 1
let g:go_highlight_types = 1
let g:go_highlight_structs = 1
let g:go_highlight_interfaces = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
let g:go_code_completion_enabled = 1

let g:go_auto_type_info = 1

let g:syntastic_c_checkers = []
let g:syntastic_rust_checkers = []
let g:syntastic_cpp_checkers = []
let g:syntastic_python_python_exec = 'python3'

" get rid of bull shit mappings
let g:go_doc_keywordprg_enabled = 0
let g:go_def_mapping_enabled = 0
let g:go_bin_path = "/usr/lib/google-golang/bin/go "
"let $GOPATH = $HOME."/go"

" --------- GOLANG MAPPINGS ---------
nmap <leader>d :GoDef<cr>
nmap <leader>b :GoBuild<cr>
nmap <leader>tf :GoTestFunc<cr>
nmap <leader>fs :GoFillStruct<cr>
nmap <leader>at :GoAddTags<cr>
nmap <leader>ie :GoIfErr<cr>

nmap <leader>ga :GoAlternate<cr>
nmap <leader>gat :GoAddTags<cr>
nmap <leader>grt :GoRemoveTags<cr>
nmap <leader>gc :GoCoverageToggle<cr>
nmap <leader>gd :GoDef<cr>
nmap <leader>gfs :GoFillStruct<cr>
nmap <leader>gl :GoMetaLinter<cr>
nmap <leader>gr :GoRun<cr>
nmap <leader>gt :GoTest<cr>
nmap <leader>gtf :GoTestFunc<cr>
nmap <leader>gv :GoVet<cr>

autocmd FileType go nmap gtj :CocCommand go.tags.add json<cr>
autocmd FileType go nmap gty :CocCommand go.tags.add yaml<cr>
autocmd FileType go nmap gtx :CocCommand go.tags.clear<cr>

"nmap <leader>gd <Plug>(coc-definition)
"nmap <leader>gy <Plug>(coc-type-definition)
"nmap <leader>gi <Plug>(coc-implementation)
"nmap <leader>gr <Plug>(coc-references)
