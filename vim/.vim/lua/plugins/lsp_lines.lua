return {
	url = "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
	name = "lsp_lines.nvim",
	-- "ErichDonGubler/lsp_lines.nvim",
	lazy = false,
	config = function()
		require("lsp_lines").setup()
	end,
	keys = {
		{
			"<leader>l",
			":lua require('lsp_lines').toggle()<CR>",
			-- function()
			--     require("lsp_lines").toggle()
			-- end,
			desc = "Toggle LSP Lines",
		},
	},
}
