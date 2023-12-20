return {
	{
		"tiagovla/scope.nvim",
		config = function()
			-- vim.opt.sessionoptions = { -- required
			--     "buffers",
			--     "tabpages",
			--     "globals",
			-- }
			require("scope").setup({})
		end,
	},
	{
		"akinsho/bufferline.nvim",
		version = "*",
		dependencies = "nvim-tree/nvim-web-devicons",
		config = function()
			vim.opt.termguicolors = true
			require("bufferline").setup({
				options = {
					-- separator_style = "slope",
					separator_style = "slant",
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
					custom_areas = {
						left = function()
							local result = {}
							local seve = vim.diagnostic.severity
							local error = #vim.diagnostic.get(0, { severity = seve.ERROR })
							local warning = #vim.diagnostic.get(0, { severity = seve.WARN })
							local info = #vim.diagnostic.get(0, { severity = seve.INFO })
							local hint = #vim.diagnostic.get(0, { severity = seve.HINT })

							if error ~= 0 then
								table.insert(result, { text = " " .. error, fg = "#EC5241" })
							end

							if warning ~= 0 then
								table.insert(result, { text = "  " .. warning, fg = "#EFB839" })
							end

							if hint ~= 0 then
								table.insert(result, { text = "󱠂 " .. hint, fg = "#A3BA5E" })
							end

							if info ~= 0 then
								table.insert(result, { text = " " .. info, fg = "#7EA9A7" })
							end
							return result
						end,
					},
					max_name_length = 30,
					truncate_name = false,
					show_close_icon = false,
					show_buffer_close_icons = false,
				},
			})
		end,
	},
}
