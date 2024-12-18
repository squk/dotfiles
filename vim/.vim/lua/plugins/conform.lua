local use_google = require("utils").use_google

if use_google() then
	return {}
end

vim.api.nvim_create_user_command("FormatDisable", function(args)
	if args.bang then
		-- FormatDisable! will disable formatting just for this buffer
		vim.b.disable_autoformat = true
	else
		vim.g.disable_autoformat = true
	end
end, {
	desc = "Disable autoformat-on-save",
	bang = true,
})
vim.api.nvim_create_user_command("FormatEnable", function()
	vim.b.disable_autoformat = false
	vim.g.disable_autoformat = false
end, {
	desc = "Re-enable autoformat-on-save",
})

return {
	{
		"stevearc/conform.nvim",
		event = { "BufWritePre" },
		cmd = { "ConformInfo", "Format", "FormatDisable", "FormatEnable" },
		keys = {
      -- stylua: ignore
      { "<leader>fmt", function() require("conform").format({ async = true, lsp_fallback = true }) end, mode = "", desc = "Format buffer", },
		},
		opts = {
			formatters_by_ft = {
				-- Conform will run multiple formatters sequentially
				-- go = { "goimports", "gofmt" },
				-- Use a sub-list to run only the first available formatter
				-- javascript = { { "prettierd", "prettier" } },
				lua = { "stylua" },
				-- Conform will run multiple formatters sequentially
				python = { "isort", "black" },
				-- Use a sub-list to run only the first available formatter
				javascript = { { "prettierd", "prettier" } },
				gdscript = { "gdformat" },
				dashboard = {},
				-- Use the "*" filetype to run formatters on all filetypes.
				["*"] = { "codespell" },
				-- Use the "_" filetype to run formatters on filetypes that don't
				-- have other formatters configured.
				["_"] = { "trim_whitespace" },
			},
			format_on_save = function(bufnr)
				-- Disable with a global or buffer-local variable
				if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
					return
				end
				return { timeout_ms = 500, lsp_format = "fallback" }
			end,
			formatters = {
				gdformat = {
					prepend_args = { "-l", "100" },
				},
			},
		},
	},
}
