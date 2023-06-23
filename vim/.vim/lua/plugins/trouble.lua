return {
	"folke/trouble.nvim",
	event = "VimEnter",
	config = function()
		vim.diagnostic.config({
			virtual_lines = true,
			virtual_text = true,
			severity_sort = true,
			update_in_insert = true,
		})

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
		{ "gr", "<Cmd>Trouble lsp_references<CR>" },
		{ "<Leader>xx", "<Cmd>Trouble<CR>" },
		{ "<Leader>xw", "<Cmd>Trouble workspace_diagnostics<CR>" },
		{ "<Leader>xd", "<Cmd>Trouble document_diagnostics<CR>" },
		{ "<Leader>xl", "<Cmd>Trouble loclist<CR>" },
		{ "<Leader>xq", "<Cmd>Trouble quickfix<CR>" },
		{ "[g", "<cmd>lua vim.diagnostic.goto_prev()<CR>" },
		{ "]g", "<cmd>lua vim.diagnostic.goto_next()<CR>" },
	},
}
