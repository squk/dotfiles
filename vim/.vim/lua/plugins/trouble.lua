return {
	"folke/trouble.nvim",
	event = "VimEnter",
	config = function()
		-- Diagnostics
		require("trouble").setup({
			signs = {
				-- icons / text used for a diagnostic
				error = " ",
				warning = " ",
				hint = " ",
				information = " ",
				other = "?﫠",
			},
			use_diagnostic_signs = false, -- enabling this will use the signs defined in your lsp client
		})
	end,
	keys = {
		{ "<Leader>xx", "<Cmd>Trouble<CR>" },
		{ "<Leader>xw", "<Cmd>Trouble workspace_diagnostics<CR>" },
		{ "<Leader>xd", "<Cmd>Trouble document_diagnostics<CR>" },
		{ "<Leader>xl", "<Cmd>Trouble loclist<CR>" },
		{ "<Leader>xq", "<Cmd>Trouble quickfix<CR>" },
		{ "[g", "<cmd>lua vim.diagnostic.goto_prev()<CR>" },
		{ "]g", "<cmd>lua vim.diagnostic.goto_next()<CR>" },
	},
}
