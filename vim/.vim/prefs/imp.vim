source ~/.vim/prefs/google_comments.vim

set runtimepath+=/google/src/files/head/depot/google3/experimental/users/tstone/vim/vim-imp
set runtimepath+=/google/src/files/head/depot/google3/experimental/users/tstone/vim/imp-csearch

Glug! glaive
Glaive imp plugin[mappings] Suggest[default]=buffer,csearch,prompt,primp Report[default]=popupnotify
"
" nnoremap <leader>csi :CsImporter<cr>
nnoremap <leader>csi :ImpSuggest
" nnoremap <leader>ii :ImpSuggest
" nnoremap <leader>if :ImpFirst
