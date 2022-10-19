-- Require CiderLSP and Diagnostics modules
-- IMPORTANT: Must come after plugins are loaded

-- CiderLSP
vim.opt.completeopt = { "menu", "menuone", "noselect" }

require 'lspconfig'

require("lsp")
require("diagnostics")
require("treesitter")
require("telescope_config")
require("lualine_config")
require("notify_config")
require("catppuccin-config")
require("symbols-outline-config")

require "fidget".setup{}

-- redundant w/ lsp_lines
vim.diagnostic.config({
  virtual_text = false,
})
require("lsp_lines").setup()
