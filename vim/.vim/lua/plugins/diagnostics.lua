-- disable underline
vim.diagnostic.handlers.underline.show = function() end

return {
	{
		"folke/trouble.nvim",
		event = { "LspAttach" },
		config = function()
			-- Diagnostics
			require("trouble").setup({
				use_diagnostic_signs = true, -- enabling this will use the signs defined in your lsp client
			})
		end,
		keys = {
			{ "<leader>xt", "<cmd>:Telescope diagnostics<CR>" },
			{ "gr", ":Telescope lsp_references<CR>" },
			{ "<leader>xd", ":Trouble<CR>" },
			{ "[g", "<cmd>lua vim.diagnostic.goto_prev()<CR>" },
			{ "]g", "<cmd>lua vim.diagnostic.goto_next()<CR>" },
		},
	},
	{
		"https://git.sr.ht/~whynothugo/lsp_lines.nvim",
		event = { "LspAttach" },
		name = "lsp_lines.nvim",
		config = function()
			local signs = {
				Error = " ",
				Warning = " ",
				Warn = " ",
				Hint = "",
				Info = " ",
				Other = "",
			}
			for type, icon in pairs(signs) do
				local hl = "DiagnosticSign" .. type
				vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
			end

			require("lsp_lines").setup()

			-- vim.schedule(function()
			vim.diagnostic.config({
				severity_sort = true,
				virtual_text = false,
				virtual_improved = {
					severity = { min = vim.diagnostic.severity.WARN },
					current_line = "hide",
				},
				virtual_lines = {
					severity = { min = vim.diagnostic.severity.HINT },
					highlight_whole_line = false,
					only_current_line = true,
				},
			})
			-- end)
		end,
		keys = {
			{
				"<leader>l",
				function()
					if vim.diagnostic.config().virtual_improved then
						vim.diagnostic.config({ virtual_improved = false })
					else
						vim.diagnostic.config({
							virtual_improved = {
								severity = { min = vim.diagnostic.severity.WARN },
								current_line = "hide",
							},
						})
					end
				end,
				desc = "Toggle Virtual Text",
			},
		},
	},
}
