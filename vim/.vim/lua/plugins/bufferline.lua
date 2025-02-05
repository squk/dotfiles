return {
  {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      options = {
        separator_style = "slope",
        offsets = { {
          filetype = "neo-tree",
          text = "NeoTree",
          highlight = "Directory",
          separator = true, -- use a "true" to enable the default, or set your own character
        }, },
        mode = "tabs",
        diagnostics = "nvim_lsp",
        -- diagnostics_indicator = function(count, level, diagnostics_dict, context)
        --   local symbols = { error = " ", warning = " ", info = " ", hint = "󱠂 " }
        --   local icon = symbols[level] or level
        --   return "" .. icon .. count
        -- end,
        max_name_length = 30,
        tab_size = 27,
        truncate_name = false,
        show_close_icon = false,
        show_buffer_close_icons = false,
      },
    },
  },
}
