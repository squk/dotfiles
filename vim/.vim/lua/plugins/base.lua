local use_google = require("utils").use_google

return {
	"kdheepak/lazygit.nvim",
	"flwyd/vim-conjoin",
	"vim-scripts/vcscommand.vim",
	"jghauser/mkdir.nvim",
	"AndrewRadev/tagalong.vim",
	{ "nvim-lua/plenary.nvim", lazy = false },
	{ "squk/java-syntax.vim", ft = "java" },
	{ "udalov/kotlin-vim", ft = "kotlin" },
	{ "ray-x/go.nvim", ft = "go" },
	{ "ray-x/guihua.lua", ft = "go" },
	{ "andymass/vim-matchup", event = "VimEnter" },
	{ "squk/gdrama-syntax.vim", dir = vim.fn.expand("$HOME/dev/gdrama-syntax.vim") },
	{
		"NvChad/nvim-colorizer.lua",
		ft = "lua",
		config = function()
			require("colorizer").setup()
		end,
	},
	{

		"andweeb/presence.nvim",
		cond = not use_google(),
		config = function()
			require("presence").setup({
				main_image = "file",
				show_time = false,
			})
		end,
	},
	{
		"rafcamlet/nvim-luapad",
		config = function()
			require("luapad").setup({
				eval_on_change = false,
			})
		end,
	},
	{
		"kosayoda/nvim-lightbulb",
		opts = {
			autocmd = { enabled = true },
			virtual_text = {
				enabled = true,
				text = " 󱐋",
				hl = "DiagnosticWarn",
			},
			sign = { enabled = false },
		},
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
}
