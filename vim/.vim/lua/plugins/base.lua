local use_google = require("utils").use_google

return {
	"kdheepak/lazygit.nvim",
	"flwyd/vim-conjoin",
	"rafcamlet/nvim-luapad",
	"vim-scripts/vcscommand.vim",
	"AndrewRadev/tagalong.vim",
	{ "squk/gdrama-syntax.vim", ft = "gdrama" },
	{ "nvim-lua/plenary.nvim", lazy = false },
	{ "squk/java-syntax.vim", ft = "java" },
	{ "udalov/kotlin-vim", event = "VeryLazy", ft = "kotlin" },
	{ "ray-x/go.nvim", ft = "go" },
	{ "ray-x/guihua.lua", ft = "go" },
	{ "andymass/vim-matchup", event = "VimEnter" },
	{ "jghauser/mkdir.nvim", event = "BufWritePre" },
	{
		"andweeb/presence.nvim", -- session management
		cond = not use_google(),
		config = function()
			require("presence").setup({
				main_image = "file",
				show_time = false,
			})
		end,
	},
	{
		"ntpeters/vim-better-whitespace",
		config = function()
			vim.g.better_whitespace_filetypes_blacklist = { "dashboard" }
		end,
	},
	{
		"mbbill/undotree",
		cmd = "UndotreeToggle",
		config = function()
			vim.g.undotree_SetFocusWhenToggle = 1
		end,
	},
	{
		"stevearc/aerial.nvim",
		opts = {},
		cmd = { "AerialToggle", "AerialOn" },
		keys = { { "<leader>so", ":AerialToggle<CR>", desc = "[S]symbols [O]utline" } },
	},
	{
		"olimorris/persisted.nvim",
		config = function()
			require("persisted").setup({})
			require("telescope").load_extension("persisted")
		end,
	},
	{
		"iamcco/markdown-preview.nvim",
		build = "cd app && npm install",
		init = function()
			vim.g.mkdp_filetypes = { "markdown" }
		end,
		ft = { "markdown" },
	},
	{
		"andrewferrier/debugprint.nvim",
		opts = {},
		-- Dependency only needed for NeoVim 0.8
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
		},
		-- Remove the following line to use development versions,
		-- not just the formal releases
		version = "*",
		keys = {
			{ "<leader>dp", ":lua require('debugprint').debugprint()<cr>", desc = "Debug print" },
			{ "<leader>dP", ":lua require('debugprint').debugprint({above = true})<cr>", desc = "Debug print" },
			{ "<leader>dq", ":lua require('debugprint').debugprint({variable = true})<cr>", desc = "Debug print" },
			{
				"<leader>dQ",
				":lua require('debugprint').debugprint({variable = true, above = true})<cr>",
				desc = "Debug print",
			},
		},
	},
}
