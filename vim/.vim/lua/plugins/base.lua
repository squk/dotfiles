local use_google = require("utils").use_google

return {
  "tikhomirov/vim-glsl",
  "sindrets/diffview.nvim",
  { "folke/todo-comments.nvim", dependencies = { "nvim-lua/plenary.nvim" } },
  {
    "MagicDuck/grug-far.nvim",
    config = function()
      require("grug-far").setup({
        -- search and replace engines configuration
        engines = {
          -- see https://github.com/BurntSushi/ripgrep
          ripgrep = {
            -- ripgrep executable to use, can be a different path if you need to configure
            path = "rg",
            -- extraArgs = "-.",
          },
        },
      })
    end,
  },
  {
    "shellRaining/hlchunk.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      line_num = { enable = true },
      chunk = {
        enable = true,
        priority = 15,
        style = {
          { fg = "#393d4c" },
        },
        chars = {
          horizontal_line = "─",
          -- vertical_line = "│",
          vertical_line = "┊",
          left_top = "╭",
          left_bottom = "╰",
          right_arrow = ">",
        },
        use_treesitter = true,
        textobject = "",
        max_file_size = 1024 * 1024,
        error_sign = true,
        -- animation related
        duration = 0,
        delay = 0,
      },
    },
  },
  "RRethy/vim-illuminate",
  "kdheepak/lazygit.nvim",
  "flwyd/vim-conjoin",
  "rafcamlet/nvim-luapad",
  "vim-scripts/vcscommand.vim",
  "AndrewRadev/tagalong.vim",
  "AndrewRadev/yankwin.vim",
  { "squk/gdrama-syntax.vim",   ft = "gdrama" },
  { "nvim-lua/plenary.nvim",    lazy = false },
  { "squk/java-syntax.vim",     ft = "java" },
  { "udalov/kotlin-vim",        event = "VeryLazy",                        ft = "kotlin" },
  { "andymass/vim-matchup",     event = "VimEnter" },
  { "jghauser/mkdir.nvim",      event = "BufWritePre" },
  {
    "rmagatti/auto-session",
    dependencies = {
      "nvim-telescope/telescope.nvim", -- Only needed if you want to use session lens
    },
    config = function()
      require("auto-session").setup({
        auto_session_suppress_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
        args_allow_single_directory = false,
        bypass_save_filetypes = { "netrw" },
      })
    end,
  },
  "tpope/vim-abolish",
  {
    "johmsalas/text-case.nvim",
    dependencies = { "nvim-telescope/telescope.nvim" },
    config = function()
      require("textcase").setup({})
      require("telescope").load_extension("textcase")
    end,
    cmd = {
      "Subs",
    },
  },
  {
    "NvChad/nvim-colorizer.lua",
    ft = "lua",
    config = function()
      require("colorizer").setup()
    end,
  },
  {

    "andweeb/presence.nvim",
    cond = not use_google(),
    config = function()
      require("presence").setup({
        main_image = "file",
        show_time = false,
      })
    end,
  },
  {
    "ntpeters/vim-better-whitespace",
    config = function()
      vim.g.better_whitespace_filetypes_blacklist = { "dashboard" }
    end,
  },
  {
    "mbbill/undotree",
    cmd = "UndotreeToggle",
    config = function()
      vim.g.undotree_SetFocusWhenToggle = 1
    end,
    -- stylua: ignore
    keys = { { "<leader>ut", ":UndotreeToggle<CR>" } },
  },
  {
    "stevearc/aerial.nvim",
    opts = {},
    cmd = { "AerialToggle", "AerialOn" },
    -- stylua: ignore
    keys = { { "<leader>so", ":AerialToggle<CR>", desc = "[S]symbols [O]utline" } },
  },
  {
    "andrewferrier/debugprint.nvim",
    opts = {},
    -- Dependency only needed for NeoVim 0.8
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
    -- Remove the following line to use development versions,
    -- not just the formal releases
    version = "*",
    -- stylua: ignore
    keys = {
      { "<leader>dp", ":lua require('debugprint').debugprint()<cr>",                                desc = "Debug print" },
      { "<leader>dP", ":lua require('debugprint').debugprint({above = true})<cr>",                  desc = "Debug print" },
      { "<leader>dq", ":lua require('debugprint').debugprint({variable = true})<cr>",               desc = "Debug print" },
      { "<leader>dQ", ":lua require('debugprint').debugprint({variable = true, above = true})<cr>", desc = "Debug print", },
    },
  },
}
