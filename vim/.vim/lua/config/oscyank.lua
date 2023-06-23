vim.keymap.set("n", "<leader>y", require("osc52").copy_operator, { expr = true })
vim.keymap.set("v", "<leader>y", require("osc52").copy_visual)
