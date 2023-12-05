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
				other = " ",
			},
			use_diagnostic_signs = false, -- enabling this will use the signs defined in your lsp client
		})
	end,
	keys = {
		{ "<leader>xt", "<cmd>:Telescope diagnostics<CR>" },
		{ "<leader>xd", "<cmd>:Trouble workspace<CR>" },
		{ "[g", "<cmd>lua vim.diagnostic.goto_prev()<CR>" },
		{ "]g", "<cmd>lua vim.diagnostic.goto_next()<CR>" },
	},
}
