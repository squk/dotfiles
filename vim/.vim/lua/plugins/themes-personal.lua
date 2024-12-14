local use_google = require("utils").use_google

return {
	{
		"bluz71/vim-moonfly-colors",
		name = "moonfly",
		cond = not use_google(),
		lazy = false,
		priority = 1000,
		config = function()
			vim.cmd("colorscheme moonfly")
		end,
	},
	-- {
	-- 	"EdenEast/nightfox.nvim",
	-- 	lazy = use_google(), -- make sure we load this during startup if it is your main colorscheme
	-- 	priority = 1000, -- make sure to load this before all the other start plugins
	-- 	cond = not use_google(),
	-- 	config = function()
	-- 		-- vim.cmd("colorscheme nightfox")
	-- 		-- vim.cmd("colorscheme carbonfox")
	-- 		-- vim.cmd("colorscheme terafox")
	-- 		vim.cmd("colorscheme duskfox")
	-- 		-- vim.cmd("colorscheme nordfox")
	-- 		-- vim.cmd("colorscheme dayfox")
	-- 		-- vim.cmd("colorscheme dawnfox")
	-- 	end,
	-- },
}
