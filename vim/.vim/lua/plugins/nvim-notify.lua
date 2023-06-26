return {
	"rcarriga/nvim-notify",
	config = function()
		local colors = require("catppuccin.palettes").get_palette()
		require("notify").setup({
			background_colour = colors.base,
		})
		vim.notify = require("notify")
	end,
}
