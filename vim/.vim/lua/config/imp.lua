local map = require("utils").map
local use_google = require("utils").use_google

map("n", "<leader>csi", ":ImpSuggest <C-r><C-w><cr>")
map("n", "<leader>ii", ":ImpSuggest <C-r><C-w><cr>")
map("n", "<leader>if", ":ImpSuggest <C-r><C-w><cr>")

if use_google() then
    vim.cmd([[Glug! glaive]])

-- vim.cmd([[Glaive imp Pick[default]=fzf Suggest[default]=buffer,primp,csearch,prompt Report[default]=echo]])

    vim.cmd([[
    set runtimepath+=/google/src/files/head/depot/google3/experimental/users/tstone/vim/vim-imp
    set runtimepath+=/google/src/files/head/depot/google3/experimental/users/tstone/vim/imp-csearch
    Glug imp-google
    Glaive imp Suggest[default]=buffer,csearch,prompt
    ]])
    -- To search for imports in the file's parent directory before using Code Search across all of google3, install ripgrep and try
    vim.cmd([[
Glaive imp Suggest[gcl]=buffer,ripgrep,csearch,prompt
    \ Location[gcl]=parent Location[borg]=parent
    \ Suggest[borg]=buffer,ripgrep,csearch,prompt
    \ Suggest[aidl]=buffer,ripgrep,csearch,prompt
    ]])
end
