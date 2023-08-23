return {
	-- {
	--     "tiagovla/scope.nvim",
	--     config = function()
	--         -- vim.opt.sessionoptions = { -- required
	--         --     "buffers",
	--         --     "tabpages",
	--         --     "globals",
	--         -- }
	--         require("scope").setup({})
	--     end,
	-- },
	{
		"akinsho/bufferline.nvim",
		version = "*",
		dependencies = "nvim-tree/nvim-web-devicons",
		config = function()
			vim.opt.termguicolors = true
			require("bufferline").setup({
				options = {
					mode = "tabs",
					diagnostics = "nvim_lsp",
					diagnostics_indicator = function(count, level, diagnostics_dict, context)
						local symbols = { error = " ", warning = " ", info = " ", hint = " " }
						local icon = symbols[level] or level
						return "" .. icon .. count
					end,
					max_name_length = 30,
					truncate_name = false,
					show_close_icon = false,
					show_buffer_close_icons = false,
				},
			})
		end,
	},
}
