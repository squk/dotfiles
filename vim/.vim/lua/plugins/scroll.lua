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
	-- {
	-- 	"kevinhwang91/nvim-hlslens",
	-- 	config = function()
	-- 		require("hlslens").setup({
	-- 			nearest_only = true,
	-- 			build_position_cb = function(plist, _, _, _)
	-- 				require("scrollbar.handlers.search").handler.show(plist.start_pos)
	-- 			end,
	-- 		})
	--
	-- 		vim.cmd([[
	--        augroup scrollbar_search_hide
	--            autocmd!
	--            autocmd CmdlineLeave : lua require('scrollbar.handlers.search').handler.hide()
	--        augroup END
	--    ]])
	-- 	end,
	-- },
}
