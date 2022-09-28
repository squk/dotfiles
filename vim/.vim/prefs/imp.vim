source ~/.vim/prefs/google_comments.vim

set runtimepath+=/google/src/files/head/depot/google3/experimental/users/tstone/vim/vim-imp
set runtimepath+=/google/src/files/head/depot/google3/experimental/users/tstone/vim/imp-csearch

Glug! glaive
" Glaive imp Suggest[default]=buffer,primp,csearch,prompt Report[default]=popupnotify
" Glaive imp Suggest[default]=buffer,csearch,prompt,primp Report[default]=popupnotify
" Glaive imp Pick[default]=inputlist Suggest[default]=buffer,primp,csearch,prompt Report[default]=echo
Glaive imp Pick[default]=fzf Suggest[default]=buffer,primp,csearch,prompt Report[default]=echo
"
" nnoremap <leader>csi :CsImporter<cr>
nnoremap <leader>csi :ImpSuggest <C-r><C-w><cr>
nnoremap <leader>ii :ImpSuggest <C-r><C-w><cr>
nnoremap <leader>if :ImpFirst <C-r><C-w><cr>

