return {
	-- {
	-- 	"rcarriga/nvim-notify",
	-- 	event = "VimEnter",
	-- 	cond = true,
	-- 	lazy = true,
	-- 	config = function()
	-- 		-- local colors = require("catppuccin.palettes").get_palette()
	-- 		require("notify").setup({
	-- 			-- background_colour = colors.base,
	-- 			fps = 20, -- default 30
	-- 			stages = "slide", -- default fade_in_slide_out
	-- 			timeout = 5000, -- default 5000
	-- 			render = "wrapped-compact",
	-- 		})
	-- 		vim.notify = require("notify")
	-- 	end,
	-- },
	-- {
	-- 	"j-hui/fidget.nvim",
	-- 	event = "VimEnter",
	-- 	-- cond = false,
	-- 	opts = {
	-- 		progress = {
	-- 			display = {
	-- 				done_ttl = 5,
	-- 				done_icon = "󰞑 ",
	-- 			},
	-- 		},
	-- 		notification = {
	-- 			override_vim_notify = true,
	-- 		},
	-- 	},
	-- },
	{
		"echasnovski/mini.notify",
		version = false,
		dependencies = {
			"rcarriga/nvim-notify",
			-- "j-hui/fidget.nvim",
		},
		config = function()
			vim.api.nvim_create_user_command("Notifications", require("mini.notify").show_history, {})
			vim.notify = require("mini.notify").make_notify()
		end,
	},
}
