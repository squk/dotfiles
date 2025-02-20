-- disable underline
local use_google = require("utils").use_google
vim.diagnostic.handlers.underline.show = function() end

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
    -- stylua: ignore
		keys = {
			{ "<leader>xt", ":Telescope diagnostics<CR>" },
			{ "gr", ":Telescope lsp_references<CR>" },
			{ "<leader>xd", ":Trouble diagnostics toggle <CR>" },
			{ "<leader>xbd", ":Trouble diagnostics toggle filter.buf=0<CR>" },
			{ "<leader>xe", ":Trouble diagnostics toggle filter.severity=vim.diagnostic.severity.ERROR<CR>" },
			{ "[g", ":lua vim.diagnostic.goto_prev()<CR>" },
			{ "]g", ":lua vim.diagnostic.goto_next()<CR>" },
		},
	},
	{
		"rachartier/tiny-inline-diagnostic.nvim",
		event = "LspAttach",
		priority = 1000, -- needs to be loaded in first
		cond = not use_google(),
		config = function()
			vim.diagnostic.config({ virtual_text = false })

			require("tiny-inline-diagnostic").setup({
				preset = "classic", -- Can be: "modern", "classic", "minimal", "powerline", ghost", "simple", "nonerdfont", "amongus"

				-- Show the source of the diagnostic.
				show_source = false,

				-- Use your defined signs in the diagnostic config table.
				use_icons_from_diagnostic = true,

				-- Enable diagnostic message on all lines.
				multilines = true,

				-- Show all diagnostics on the cursor line.
				show_all_diags_on_cursorline = false,
			})
		end,
	},
	{
		"ErichDonGubler/lsp_lines.nvim",
		event = { "LspAttach" },
		name = "lsp_lines.nvim",
		cond = use_google(),
		config = function()
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
