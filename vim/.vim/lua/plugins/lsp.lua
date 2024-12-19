local use_google = require("utils").use_google
local flags = require("utils").flags

return {
  {
    "ray-x/lsp_signature.nvim",
    event = "VeryLazy",
    opts = {
      floating_window = true,
      hint_prefix = "󰡱 ",
    },
    config = function(_, opts)
      require("lsp_signature").setup(opts)
    end,
  },
  {
    "luozhiya/lsp-virtual-improved.nvim",
    event = { "LspAttach" },
    config = function()
      require("lsp-virtual-improved").setup()
    end,
  },
  {
    "kosayoda/nvim-lightbulb",
    commit = "1cae7b7153ae98dcf1b11173a443ac1b6d8e3d49",
    event = { "LspAttach" },
    opts = {
      autocmd = { enabled = true },
      virtual_text = {
        enabled = true,
        text = " 󱐋",
        hl = "DiagnosticWarn",
      },
      sign = { enabled = false },
    },
  },
  {
    "L3MON4D3/LuaSnip",
    build = "make install_jsregexp",
    config = function()
      require("luasnip.loaders.from_vscode").lazy_load()
    end,
    dependencies = { "rafamadriz/friendly-snippets" },
  },
  {
    "hinell/lsp-timeout.nvim",
    event = { "LspAttach" },
    dependencies = { "neovim/nvim-lspconfig" },
    -- cond = not use_google(),
    config = function()
      vim.g.lspTimeoutConfig = {
        filetypes = {
          ignore = { -- filetypes to ignore; empty by default
            "gdscript",
            "rust",
          }, -- for these filetypes
        },
      }
    end,
  },
  {
    "ray-x/go.nvim",
    dependencies = { -- optional packages
      "ray-x/guihua.lua",
      "neovim/nvim-lspconfig",
      "nvim-treesitter/nvim-treesitter",
    },
    -- cond = not use_google(),
    config = function()
      local capabilities = flags.blink
          and require("blink.cmp").get_lsp_capabilities(vim.lsp.protocol.make_client_capabilities())
          or require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
      capabilities.offsetEncoding = { "utf-16" }
      require("go").setup({
        lsp_cfg = { capabilities = capabilities },
        lsp_keymaps = false,
        lsp_inlay_hints = {
          enable = not use_google(), -- doesn't work with ciderlsp
        },
      })
      -- Run gofmt + goimports on save

      local format_sync_grp = vim.api.nvim_create_augroup("goimports", {})
      vim.api.nvim_create_autocmd("BufWritePre", {
        pattern = "*.go",
        callback = function()
          require("go.format").goimports()
        end,
        group = format_sync_grp,
      })
    end,
    ft = { "go", "gomod" },
    build = ':lua require("go.install").update_all_sync()', -- if you need to install/update all binaries
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "hrsh7th/nvim-cmp",
      "nvim-lua/lsp-status.nvim",
      "VonHeikemen/lsp-zero.nvim",
    },
    keys = {
      { "<leader>F",  ":lua vim.lsp.buf.format()<CR>" },
      { "<leader>rn", ":>lua vim.lsp.buf.rename()<CR>" },
      { "L",          ":lua vim.lsp.buf.hover()<CR>" },
      { "gr",         ":Telescope lsp_references<CR>" },
      { "gd",         ":lua vim.lsp.buf.definition()<CR>" },
      -- { "gd", "<cmd>Telescope lsp_definitions<CR>" },
      { "gD",         ":tab split | lua vim.lsp.buf.definition()<CR>" },
      { "gi",         ":lua vim.lsp.buf.implementation()<CR>" },
      { "gI",         ":lua vim.lsp.buf.implementation()<CR>" },
      { "gR",         ":lua vim.lsp.buf.references()<CR>" },
      { "gt",         ":lua vim.lsp.buf.type_definition()<CR>" },
      { "<C-g>",      ":lua vim.lsp.buf.signature_help()<CR>" },
      { "<C-g>",      ":lua vim.lsp.buf.signature_help()<CR>",        mode = "i" },
    },
    config = function()
      local lsp_status = require("lsp-status")
      lsp_status.register_progress()

      local capabilities = flags.blink
          and require("blink.cmp").get_lsp_capabilities(vim.lsp.protocol.make_client_capabilities())
          or require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
      capabilities = vim.tbl_extend("keep", capabilities or {}, lsp_status.capabilities)
      capabilities.offsetEncoding = { "utf-16" }

      local lspconfig = require("lspconfig")
      local configs = require("lspconfig.configs")
      require("config.lsp-google").setup(capabilities)

      -- Godot
      lspconfig.gdscript.setup({
        -- flags = {
        -- 	debounce_text_changes = 2000, -- Wait 5 seconds before sending didChange
        -- },
      })
      vim.cmd([[autocmd FileType gdscript setlocal commentstring=#\ %s]])
      vim.cmd([[autocmd FileType gdscript setlocal autoindent noexpandtab tabstop=4 shiftwidth=4]])
    end,
  },
}
