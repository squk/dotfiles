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
			{ "<leader>xw", "<cmd>:Trouble workspace_diagnostics<CR>" },
			{ "<leader>xd", "<cmd>:Trouble document_diagnostics<CR>" },
			{ "[g", "<cmd>lua vim.diagnostic.goto_prev()<CR>" },
			{ "]g", "<cmd>lua vim.diagnostic.goto_next()<CR>" },
		},
	},
	{
		"Maan2003/lsp_lines.nvim",
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

			vim.schedule(function()
				vim.diagnostic.config({
					severity_sort = true,
					virtual_text = false,
					virtual_improved = {
						current_line = "hide",
					},
					virtual_lines = { highlight_whole_line = false, only_current_line = true },
				})
			end)
		end,
		keys = {
			{
				"<leader>l",
				function()
					local new_value = not vim.diagnostic.config().virtual_lines.only_current_line
					vim.diagnostic.config({
						virtual_improved = {
							current_line = new_value and "default" or "hide",
						},
						virtual_lines = { only_current_line = new_value },
					})
					return new_value
				end,
				desc = "Toggle LSP Lines",
			},
		},
	},
}
