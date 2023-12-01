local use_google = require("utils").use_google

return {
	{
		"rebelot/kanagawa.nvim",
		lazy = use_google(), -- make sure we load this during startup if it is your main colorscheme
		priority = 1000, -- make sure to load this before all the other start plugins
		-- cond = not use_google(),
		config = function()
			vim.cmd("colorscheme kanagawa-wave")
		end,
	},
	{
		"nyoom-engineering/oxocarbon.nvim",
		lazy = use_google(), -- make sure we load this during startup if it is your main colorscheme
		priority = 1000, -- make sure to load this before all the other start plugins
		cond = not use_google(),
		config = function()
			-- vim.cmd("colorscheme oxocarbon")
		end,
	},
	{
		"uloco/bluloco.nvim",
		dependencies = { "rktjmp/lush.nvim" },
		lazy = use_google(), -- make sure we load this during startup if it is your main colorscheme
		priority = 1000, -- make sure to load this before all the other start plugins
		cond = not use_google(),
		config = function()
			-- vim.cmd("colorscheme bluloco")
		end,
	},
}
