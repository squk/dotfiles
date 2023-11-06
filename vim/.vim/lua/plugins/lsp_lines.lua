return {
	url = "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
	event = "VimEnter",
	name = "lsp_lines.nvim",
	config = function()
		local signs = {
			Error = " ",
			Warning = " ",
			Hint = " ",
			Info = " ",
			Other = " ",
		}
		for type, icon in pairs(signs) do
			local hl = "DiagnosticSign" .. type
			vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
		end

		require("lsp_lines").setup()

		vim.diagnostic.config({ virtual_text = false })
		vim.diagnostic.config({ virtual_lines = { highlight_whole_line = false, only_current_line = false } })
	end,
	keys = {
		{
			"<leader>l",
			function()
				local new_value = not vim.diagnostic.config().virtual_lines.only_current_line
				vim.diagnostic.config({ virtual_lines = { only_current_line = new_value } })
				return new_value
			end,
			desc = "Toggle LSP Lines",
		},
	},
}
