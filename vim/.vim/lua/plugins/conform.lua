local use_google = require("utils").use_google

vim.g.disable_autoformat = false
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

vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*",
	callback = function(args)
		if vim.g.disable_autoformat or vim.b[args.buf].disable_autoformat then
			return
		end
		require("conform").format({ bufnr = args.buf })
	end,
})

vim.api.nvim_create_user_command("Format", function(args)
	local range = nil
	if args.count ~= -1 then
		local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
		range = {
			start = { args.line1, 0 },
			["end"] = { args.line2, end_line:len() },
		}
	end
	require("conform").format({ async = true, lsp_format = "fallback", range = range })
end, { range = true })

return {
	{
		"stevearc/conform.nvim",
		event = { "BufWritePre" },
		cmd = { "ConformInfo", "FormatDisable", "FormatEnable" },
		keys = {
      -- stylua: ignore
      { "<leader>fmt", function() require("conform").format({ async = true, lsp_fallback = true }) end, mode = "", desc = "Format buffer", },
			{ "<leader>fj", ":%!python -m json.tool" },
		},
		-- This will provide type hinting with LuaLS
		---@module "conform"
		---@type conform.setupOpts
		opts = {
			log_level = vim.log.levels.DEBUG,
			formatters_by_ft = {
				rust = { "rustfmt", lsp_format = "fallback" },
				-- Conform will run multiple formatters sequentially
				-- go = { "goimports", "gofmt" },
				-- Use a sub-list to run only the first available formatter
				lua = { "stylua" },
				-- Conform will run multiple formatters sequentially
				python = { "isort" },
				-- Use a sub-list to run only the first available formatter
				javascript = { { "prettier" } },
				gdscript = { "gdformat" },
				ron = { "ronfmt" },
				dashboard = {},
				-- Use the "*" filetype to run formatters on all filetypes.
				-- ["*"] = { "codespell" },
				-- Use the "_" filetype to run formatters on filetypes that don't
				-- have other formatters configured.
				["_"] = { "trim_whitespace" },
			},
			formatters = {
				-- ronfmt = {
				-- 	command = "ronfmt",
				-- 	args = { "-d", "$FILENAME" },
				-- },
				gdformat = {
					prepend_args = { "-l", "100" },
				},
			},
		},
	},
}
