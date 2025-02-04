return {
  {
    "akinsho/bufferline.nvim",
    version = "*",
    cond = false,
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      options = {
        hover = {
          enabled = true,
          delay = 200,
          reveal = { "close" },
        },
        indicator = {
          -- icon = "▎", -- this should be omitted if indicator style is not 'icon'
          style = "icon", -- | 'underline' | 'none',
        },
        offsets = {
          {
            filetype = "NvimTree",
            text = "File Explorer",
            highlight = "Directory",
            separator = true, -- use a "true" to enable the default, or set your own character
          },
        },
        -- mode = "tabs",
        diagnostics = "nvim_lsp",
        diagnostics_indicator = function(count, level, diagnostics_dict, context)
          local symbols = { error = " ", warning = " ", info = " ", hint = "󱠂 " }
          local icon = symbols[level] or level
          return "" .. icon .. count
        end,
        max_name_length = 30,
        truncate_name = false,
        show_close_icon = false,
        show_buffer_close_icons = false,
        groups = {
          options = {
            toggle_hidden_on_enter = true, -- when you re-enter a hidden group this options re-opens that group so the buffer is visible
          },
          items = {
            {
              name = "Tests", -- Mandatory
              highlight = { sp = "lightblue" }, -- Optional
              priority = 2, -- determines where it will appear relative to other groups (Optional)
              icon = " ", -- Optional
              matcher = function(buf) -- Mandatory
                return buf.path:match("%_test.cc$") or buf.path:match("%Test.java$")
              end,
            },
            {
              name = "Docs",
              highlight = { sp = "lightgreen" },
              auto_close = false, -- whether or not close this group if it doesn't contain the current buffer
              matcher = function(buf)
                return buf.path:match("%.md$") or buf.path:match("%.txt$")
              end,
            },
            {
              name = "Lua",
              highlight = { sp = "lightblue" },
              auto_close = false, -- whether or not close this group if it doesn't contain the current buffer
              matcher = function(buf)
                return buf.path:match("%.lua$")
              end,
            },
          },
        },
      },
    },
  },
}
