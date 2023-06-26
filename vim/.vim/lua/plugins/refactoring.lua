return {
	{
		"ThePrimeagen/refactoring.nvim",
		dependencies = {
			{ "nvim-lua/plenary.nvim" },
			{ "nvim-treesitter/nvim-treesitter" },
		},
		config = function()
			require("config.refactoring")
		end,
		keys = {
			-- remap to open the Telescope refactoring menu in visual mode
			{
				"<leader>rr",
				"<Esc><cmd>lua require('telescope').extensions.refactoring.refactors()<CR>",
			},

			-- Remaps for the refactoring operations currently offered by the plugin
			{
				"<leader>rx",
				[[ <Esc><Cmd>lua require('refactoring').refactor('Extract Function')<CR>]],
				mode = "v",
			},
			{
				"<leader>rxf",
				[[ <Esc><Cmd>lua require('refactoring').refactor('Extract Function To File')<CR>]],
				mode = "v",
			},
			{
				"<leader>rxv",
				[[ <Esc><Cmd>lua require('refactoring').refactor('Extract Variable')<CR>]],
				mode = "v",
			},
			{
				"<leader>ri",
				[[ <Esc><Cmd>lua require('refactoring').refactor('Inline Variable')<CR>]],
				mode = "v",
			},

			-- Extract block doesn't need visual mode
			{
				"<leader>rxb",
				[[ <Cmd>lua require('refactoring').refactor('Extract Block')<CR>]],
			},
			{
				"<leader>rxbf",
				[[ <Cmd>lua require('refactoring').refactor('Extract Block To File')<CR>]],
			},

			-- Inline variable can also pick up the identifier currently under the cursor without visual mode
			{
				"<leader>ri",
				[[ <Cmd>lua require('refactoring').refactor('Inline Variable')<CR>]],
			},
			{
				"<leader>rx",
				[[ <Cmd>lua require('refactoring').refactor('Extract Variable')<CR>]],
			},
		},
	},
}
