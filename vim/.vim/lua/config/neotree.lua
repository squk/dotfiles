local map = require("utils").map
require("neo-tree").setup({
    hijack_netrw_behavior = "open_current"
})


map('n', '<C-n>', ':Neotree filesystem reveal toggle reveal_force_cwd<cr>')
