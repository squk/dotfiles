return {
	"mhartington/formatter.nvim",
	config = function()
		-- Utilities for creating configurations
		local util = require("formatter.util")

		-- Provides the Format, FormatWrite, FormatLock, and FormatWriteLock commands
		require("formatter").setup({
			-- Enable or disable logging
			logging = true,
			-- Set the log level
			log_level = vim.log.levels.WARN,
			-- All formatter configurations are opt-in
			filetype = {
				-- xml = {
				--     function()
				--         return {
				--             exe = "tidy",
				--             args = {
				--                 "-quiet",
				--                 "-xml",
				--                 "--indent auto",
				--                 "--indent-spaces 2",
				--                 "--verical-space yes",
				--                 "--tidy-mark no",
				--             },
				--             stdin = true,
				--             try_node_modules = true,
				--         }
				--     end,
				-- },
				--
				-- Use the special "*" filetype for defining formatter configurations on
				-- any filetype
			},
		})
		vim.cmd([[
            augroup FormatAutogroup
              autocmd!
              autocmd BufWritePost * FormatWrite
            augroup END
		]])
	end,
}
