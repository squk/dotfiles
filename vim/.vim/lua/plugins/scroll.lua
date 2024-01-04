return {
	-- {
	-- 	"dstein64/nvim-scrollview",
	-- 	config = function()
	-- 		require("scrollview").setup({
	-- 			excluded_filetypes = { "nerdtree" },
	-- 			current_only = true,
	-- 			-- base = "buffer",
	-- 			-- column = 80,
	-- 			signs_on_startup = { "all" },
	-- 			diagnostics_severities = { vim.diagnostic.severity.ERROR },
	-- 		})
	-- 	end,
	-- },

	{
		"petertriho/nvim-scrollbar",
		config = function()
			require("scrollbar").setup({
				show_in_active_only = true,
				excluded_filetypes = {
					"cmp_docs",
					"cmp_menu",
					"noice",
					"prompt",
					"TelescopePrompt",
					"neo-tree",
				},
			})
		end,
		lazy = false,
	},
	{
		"kevinhwang91/nvim-hlslens",
		config = function()
			-- require('hlslens').setup() is not required
			require("scrollbar.handlers.search").setup({
				-- hlslens config overrides
			})
		end,
	},
}
