vim.cmd([[
Glaive imp Suggest[default]=buffer,csearch,prompt  Pick[default]=fzf
]])

-- To search for imports in the file's parent directory before using Code Search across all of google3, install ripgrep and try
vim.cmd([[
Glaive imp Suggest[gcl]=buffer,ripgrep,csearch,prompt
\ Location[gcl]=parent Location[borg]=parent
\ Suggest[borg]=buffer,ripgrep,csearch,prompt
\ Suggest[aidl]=buffer,ripgrep,csearch,prompt
]])
