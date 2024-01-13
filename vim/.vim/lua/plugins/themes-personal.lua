local use_google = require("utils").use_google

return {
	{
		"sainnhe/sonokai",
		config = function()
			vim.g.sonokai_diagnostic_virtual_text = "highlighted"
			vim.g.sonokai_style = "andromeda"
			vim.g.sonokai_dim_inactive_windows = 1
			vim.cmd("colorscheme sonokai")
		end,
	},
	{
		"rebelot/kanagawa.nvim",
		lazy = use_google(), -- make sure we load this during startup if it is your main colorscheme
		priority = 1000, -- make sure to load this before all the other start plugins
		-- cond = not use_google(),
		config = function()
			-- vim.cmd("colorscheme kanagawa-wave")
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
