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
  -- stylua: ignore
		keys = {
			-- remap to open the Telescope refactoring menu in visual mode
			{ "<leader>R", "<cmd>lua require('telescope').extensions.refactoring.refactors()<CR>", },

			-- Remaps for the refactoring operations currently offered by the plugin
			{ "<leader>rx", [[ <Cmd>lua require('refactoring').refactor('Extract Function')<CR>]], mode = "v", },
			{ "<leader>rxf", [[ <Cmd>lua require('refactoring').refactor('Extract Function To File')<CR>]], mode = "v", },
			{ "<leader>rxv", [[ <Cmd>lua require('refactoring').refactor('Extract Variable')<CR>]], mode = "v", },
			{ "<leader>ri", [[ <Cmd>lua require('refactoring').refactor('Inline Variable')<CR>]], mode = "v", },
		},
	},
}
