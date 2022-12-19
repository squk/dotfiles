-- Diagnostics
require("trouble").setup({
  position = "bottom", -- position of the list can be: bottom, top, left, right
  height = 10, -- height of the trouble list when position is top or bottom
  width = 50, -- width of the list when position is left or right
  icons = true, -- use devicons for filenames
  mode = "document_diagnostics", -- "workspace_diagnostics", "document_diagnostics", "quickfix", "lsp_references", "loclist"
  -- fold_open = "", -- icon used for open folds
  -- fold_closed = "", -- icon used for closed folds
  group = true, -- group results by file
  padding = true, -- add an extra new line on top of the list
  indent_lines = true, -- add an indent guide below the fold icons
  auto_open = false, -- automatically open the list when you have diagnostics
  auto_close = true, -- automatically close the list when you have no diagnostics
  auto_jump = { "lsp_definitions" }, -- for the given modes, automatically jump if there is only a single result
  signs = {
    -- icons / text used for a diagnostic
    error = ' ',
    warning = ' ',
    hint = ' ',
    information = ' ',
    other = "﫠",
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
