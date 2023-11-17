local use_google = require("utils").use_google
return {
	{
		"habamax/vim-godot",
		cond = not use_google(),
	},
	{
		"QuickGD/quickgd.nvim",
		ft = { "gdshader", "gdshaderinc" },
		cmd = { "GodotRun", "GodotRunLast", "GodotStart" },
		cond = not use_google(),
		-- Use opts if passing in settings else use config
		init = function()
			vim.filetype.add({
				extension = {
					gdshaderinc = "gdshaderinc",
				},
			})
		end,
		config = true,
		opts = {}, -- remove config and use this if changing settings.
	},
}
