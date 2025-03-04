local use_google = require("utils").use_google
local flags = require("utils").flags

return {
  {
    "saghen/blink.compat",
    -- use the latest release, via version = '*', if you also use the latest release for blink.cmp
    version = "*",
    -- lazy.nvim will automatically load the plugin when it's required by blink.cmp
    lazy = true,
    cond = flags.blink,
    -- make sure to set opts so that lazy.nvim calls blink.compat's setup
    opts = {
      impersonate_nvim_cmp = true,
      debug = true,
    },
  },
  {
    "saghen/blink.cmp",
    lazy = false, -- lazy loading handled internally
    cond = flags.blink,
    dependencies = {
      "chrisgrieser/cmp-nerdfont",
      "hrsh7th/cmp-nvim-lsp",
      "mikavilpas/blink-ripgrep.nvim",
      "moyiz/blink-emoji.nvim",
      "rafamadriz/friendly-snippets", -- optional: provides snippets for the snippet source
      "saghen/blink.compat",
    },
    version = "v0.*", -- use a release tag to download pre-built binaries
    -- build = 'cargo build --release',

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      -- stylua: ignore
      keymap = {
        preset = "none",
        ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
        ["<C-e>"] = { "hide", "fallback" },
        ["<CR>"] = { "accept", "fallback" },

        ["<Tab>"] = { "select_next", "snippet_forward", "accept", "fallback" },
        ["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },

        ["<Up>"] = { "select_prev", "fallback" },
        ["<Down>"] = { "select_next", "fallback" },

        ["<S-Up>"] = { "scroll_documentation_up", "fallback" },
        ["<S-Down>"] = { "scroll_documentation_down", "fallback" },
      },
      sources = {
        default = function(ctx)
          local providerToEnable = {
            "lsp",
            "path",
            "snippets",
            "ripgrep",
            "emoji",
            "nerdfont",
            "buffer",
          }
          if use_google() then
            table.insert(providerToEnable, "nvim_ciderlsp")
            table.insert(providerToEnable, "buganizer")
          else
            table.insert(providerToEnable, "codeium")
          end
          return providerToEnable
        end,
        -- default = { "lsp" },
        providers = {
          lsp = { name = "LSP", module = "blink.cmp.sources.lsp", score_offset = 90 },
          -- dont show LuaLS require statements when lazydev has items
          lazydev = { name = "LazyDev", module = "lazydev.integrations.blink", fallbacks = { "lsp" } },
          ripgrep = {
            module = "blink-ripgrep",
            name = "Ripgrep",
            -- the options below are optional, some default values are shown
            ---@module "blink-ripgrep"
            ---@type blink-ripgrep.Options
            opts = {
              prefix_min_len = 3,
              context_size = 5,
              max_filesize = "1M",
              additional_rg_options = {},
            },
          },
          -- https://github.com/moyiz/blink-emoji.nvim
          emoji = {
            module = "blink-emoji",
            name = "Emoji",
            score_offset = 15,  -- the higher the number, the higher the priority
            opts = { insert = true }, -- Insert emoji (default) or complete its name
          },
          buffer = {
            name = "Buffer",
            enabled = true,
            max_items = 3,
            module = "blink.cmp.sources.buffer",
            min_keyword_length = 4,
            score_offset = 15, -- the higher the number, the higher the priority
          },
          -- compat sources
          nerdfont = {
            name = "nerdfont",
            module = "blink.compat.source",
          },
          codeium = {
            name = "codeium",
            module = "blink.compat.source",
            score_offset = 100,
          },
          nvim_ciderlsp = {
            name = "nvim_ciderlsp",
            module = "blink.compat.source",
            score_offset = 100,
          },
          buganizer = {
            name = "nvim_buganizer",
            module = "blink.compat.source",
          },
        },
      },
      -- experimental signature help support
      signature = { enabled = true },
      completion = {
        list = {
          -- stylua: ignore
          selection = {
            preselect = function(ctx) return ctx.mode ~= 'cmdline' end,
            auto_insert = function(ctx) return ctx.mode ~= 'cmdline' end,
          },
        },
        documentation = {
          auto_show = true,
        },
        -- Displays a preview of the selected item on the current line
        ghost_text = {
          enabled = true,
        },
        trigger = {
          show_on_x_blocked_trigger_characters = { "'", '"', "(", "{" },
        },
      },
    },

    -- allows extending the providers array elsewhere in your config
    -- without having to redefine it
    opts_extend = { "sources.default" },
  },
}
