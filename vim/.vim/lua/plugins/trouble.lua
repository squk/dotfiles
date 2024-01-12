return {
	{
		"luozhiya/lsp-virtual-improved.nvim",
		event = { "LspAttach" },
		config = function()
			require("lsp-virtual-improved").setup()
		end,
	},
	{
		"dgagn/diagflow.nvim",
		opts = {
			toggle_event = { "InsertEnter" },
		},
	},
	{
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
			{ "<leader>xw", "<cmd>:Trouble workspace_diagnostics<CR>" },
			{ "<leader>xd", "<cmd>:Trouble document_diagnostics<CR>" },
			{ "[g", "<cmd>lua vim.diagnostic.goto_prev()<CR>" },
			{ "]g", "<cmd>lua vim.diagnostic.goto_next()<CR>" },
		},
	},
}
