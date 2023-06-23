require("symbols-outline").setup({
	show_relative_numbers = true,
	keymaps = { -- These keymaps can be a string or a table for multiple keys
		-- close = {"<Esc>", "q"},
		goto_location = "<Cr>",
		-- focus_location = "o",
		hover_symbol = "<C-space>",
		toggle_preview = "L",
		-- rename_symbol = "r",
		-- code_actions = "a",
		-- fold = "h",
		-- unfold = "l",
		fold_all = "H",
		unfold_all = "L",
		fold_reset = "R",
	},
})

local map = require("utils").map

map("n", "<leader>so", ":SymbolsOutline<cr>")
