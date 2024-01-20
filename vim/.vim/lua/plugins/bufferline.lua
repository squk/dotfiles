return {
	{
		"akinsho/bufferline.nvim",
		version = "*",
		dependencies = "nvim-tree/nvim-web-devicons",
		config = function()
			vim.opt.termguicolors = true
			require("bufferline").setup({
				options = {
					-- separator_style = "slope",
					-- separator_style = "slant",
					hover = {
						enabled = true,
						delay = 200,
						reveal = { "close" },
					},
					indicator = {
						-- icon = "▎", -- this should be omitted if indicator style is not 'icon'
						style = "icon", -- | 'underline' | 'none',
					},
					offsets = {
						{
							filetype = "NvimTree",
							text = "File Explorer",
							highlight = "Directory",
							separator = true, -- use a "true" to enable the default, or set your own character
						},
					},
					mode = "tabs",
					diagnostics = "nvim_lsp",
					diagnostics_indicator = function(count, level, diagnostics_dict, context)
						local symbols = { error = " ", warning = " ", info = " ", hint = "󱠂 " }
						local icon = symbols[level] or level
						return "" .. icon .. count
					end,
					max_name_length = 30,
					truncate_name = false,
					show_close_icon = false,
					show_buffer_close_icons = false,
					-- custom_areas = {
					-- 	right = function()
					-- 		local result = {}
					-- 		table.insert(result, { text = " " .. vim.api.nvim_buf_get_name(0), fg = "#edf" })
					-- 		return result
					-- 	end,
					-- },
				},
			})
		end,
	},
}
