return {
  "nvim-lualine/lualine.nvim",
  lazy = false,
  config = function()
    local lsp_status = require("lsp-status")

    require("lualine").setup({
      options = {
        theme = "auto",
        globalstatus = false,
        refresh = {
          statusline = 100,
          tabline = 100,
          winbar = 100,
        },
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch", "diff" },
        lualine_c = {
          require("nvim-lightbulb").get_status_text,
          {
            "filename",
            path = 4, -- 0 = just filename, 1 = relative path, 2 = absolute path
          },
        },
        lualine_x = {
          "",
          {
            "diagnostics",
            sources = { "nvim_lsp" },
            symbols = { error = " ", warn = " ", info = " ", hint = " " },
          },
          "filetype",
        },
        lualine_y = { "progress" },
        lualine_z = { "location" },
      },
    })
  end,
}
