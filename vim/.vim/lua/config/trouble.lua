-- Diagnostics
require("trouble").setup({
  signs = {
    -- icons / text used for a diagnostic
    error = ' ',
    warning = ' ',
    hint = ' ',
    information = ' ',
    other = "?﫠",
  },
  use_diagnostic_signs = false, -- enabling this will use the signs defined in your lsp client
})

-- Mappings
local opts = { noremap = true, silent = true }
vim.api.nvim_set_keymap("n", "gr", "<Cmd>Trouble lsp_references<CR>", opts)
vim.api.nvim_set_keymap("n", "<Leader>xx", "<Cmd>Trouble<CR>", opts)
vim.api.nvim_set_keymap("n", "<Leader>xw", "<Cmd>Trouble workspace_diagnostics<CR>", opts)
vim.api.nvim_set_keymap("n", "<Leader>xd", "<Cmd>Trouble document_diagnostics<CR>", opts)
vim.api.nvim_set_keymap("n", "<Leader>xl", "<Cmd>Trouble loclist<CR>", opts)
vim.api.nvim_set_keymap("n", "<Leader>xq", "<Cmd>Trouble quickfix<CR>", opts)
vim.api.nvim_set_keymap("n", "[g", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
vim.api.nvim_set_keymap("n", "]g", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)

vim.cmd [[autocmd! CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]]
