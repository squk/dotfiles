return {
	url = "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
	name = "lsp_lines.nvim",
	lazy = false,
	config = function()
		vim.diagnostic.config({
			virtual_lines = { only_current_line = true },

			-- update_in_insert = true,
			virtual_text = false,
		})

		require("lsp_lines").setup()
	end,
	keys = {
		{
			"<leader>l",
			function()
				require("lsp_lines").toggle()
			end,
			desc = "Toggle LSP Lines",
		},
	},
}
