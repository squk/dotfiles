local map = require("utils").map

require("nvim-tree").setup()

map("n", "<C-T>", ":NvimTreeToggle<CR>")
