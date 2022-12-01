require('nvim-treesitter.configs').setup {
  -- A list of parser names, or "all"
  -- ensure_installed = { "c", "lua", "vim", "java", "kotlin"},
  ensure_installed = "all",

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  highlight = {
    -- `false` will disable the whole extension
    enable = true,

    disable = {"java"},
  },
}
