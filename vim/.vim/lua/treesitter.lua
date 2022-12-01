-- Load custom treesitter grammar for org filetype
require('orgmode').setup_ts_grammar()

require('nvim-treesitter.configs').setup {
  -- A list of parser names, or "all"
  -- ensure_installed = { "c", "lua", "vim", "java", "kotlin"},
  ensure_installed = "all",

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  highlight = {
    -- `false` will disable the whole extension
    enable = true,
    -- Required for spellcheck, some LaTex highlights and
    -- code block highlights that do not have ts grammar
    additional_vim_regex_highlighting = {'org'},

    disable = {"java"},
  },
}
