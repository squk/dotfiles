return {
	"rcarriga/nvim-notify",
	event = "VimEnter",
	lazy = true,
	config = function()
		local colors = require("catppuccin.palettes").get_palette()
		require("notify").setup({
			background_colour = colors.base,
			fps = 10, -- default 30
			stages = "slide", -- default fade_in_slide_out
			timeout = 5000, -- default 5000
		})
	end,
}
