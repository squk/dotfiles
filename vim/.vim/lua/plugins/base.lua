local use_google = require("utils").use_google

return {
	{ "nvim-lua/plenary.nvim", lazy = false },
	{ "nvim-tree/nvim-web-devicons", lazy = false },
	{ "squk/java-syntax.vim", lazy = false },
	{ "echasnovski/mini.splitjoin", version = "*" },
	{
		"andweeb/presence.nvim",
		cond = not use_google(),
		config = function()
			require("presence").setup()
		end,
	},
	{
		"petertriho/nvim-scrollbar",
		config = function()
			require("scrollbar").setup()
		end,
		lazy = false,
	},
	{ "udalov/kotlin-vim", ft = "kotlin" },
	{ "ray-x/go.nvim", ft = "go" },
	{ "ray-x/guihua.lua", ft = "go" },
	{
		"saecki/crates.nvim",
		ft = "rust",
		version = "v0.3.0",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("crates").setup()
		end,
	},
	{ "simrat39/rust-tools.nvim", ft = "rust" },

	"RRethy/vim-illuminate",
	"rafcamlet/nvim-luapad",
	"flwyd/vim-conjoin",
	"godlygeek/tabular",
	"wesQ3/vim-windowswap",
	"cakebaker/scss-syntax.vim",
	"vim-scripts/vcscommand.vim",
	"jghauser/mkdir.nvim",
	"google/vim-searchindex",
	"kosayoda/nvim-lightbulb",
	"ntpeters/vim-better-whitespace",
	"junegunn/fzf.vim",
	"tversteeg/registers.nvim",
	"jremmen/vim-ripgrep",
	{ "andymass/vim-matchup", event = "VimEnter" },
	-- Undo tree
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
		-- Optional dependencies
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
		},
		cmd = { "AerialToggle", "AerialOn" },
		keys = {
			{ "<leader>so", ":AerialToggle<CR>", desc = "[S]ymbols [O]utline" },
		},
	},
	{
		"rmagatti/auto-session",
		config = function()
			require("auto-session").setup({ log_level = "error" })
		end,
	},
	{
		"ipod825/libp.nvim",
		config = function()
			require("libp").setup()
		end,
	},
	{
		"folke/which-key.nvim",
		config = function()
			require("which-key").setup({})
		end,
	},
	{
		"mhinz/vim-signify",
		event = "VimEnter",
		keys = {
			{ "]d", "<plug>(signify-next-hunk)" },
			{ "[d", "<plug>(signify-prev-hunk)" },
		},
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
