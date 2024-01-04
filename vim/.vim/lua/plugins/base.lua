local use_google = require("utils").use_google

return {
	-- "sindrets/diffview.nvim",
	{ "nvim-lua/plenary.nvim", lazy = false },
	{ "nvim-tree/nvim-web-devicons", lazy = false },
	{ "squk/java-syntax.vim", ft = "java" },
	{ "squk/gdrama-syntax.vim", dir = vim.fn.expand("$HOME/dev/gdrama-syntax.vim") },
	{ "echasnovski/mini.splitjoin", version = "*" },
	{
		"andweeb/presence.nvim",
		cond = not use_google(),
		config = function()
			require("presence").setup({ show_time = false })
		end,
	},
	{
		"petertriho/nvim-scrollbar",
		config = function()
			require("scrollbar").setup()
		end,
		lazy = false,
	},
	{
		"kevinhwang91/nvim-hlslens",
		config = function()
			-- require('hlslens').setup() is not required
			require("scrollbar.handlers.search").setup({
				-- hlslens config overrides
			})
		end,
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

	{
		"rafcamlet/nvim-luapad",
		config = function()
			require("luapad").setup({
				eval_on_change = false,
			})
		end,
	},
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
	"AndrewRadev/tagalong.vim",
	"tversteeg/registers.nvim",
	"jremmen/vim-ripgrep",
	"viniciusgerevini/clyde.vim",
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
		"iamcco/markdown-preview.nvim",
		build = "cd app && npm install",
		init = function()
			vim.g.mkdp_filetypes = { "markdown" }
		end,
		ft = { "markdown" },
	},
	{
		"glacambre/firenvim",

		-- Lazy load firenvim
		-- Explanation: https://github.com/folke/lazy.nvim/discussions/463#discussioncomment-4819297
		config = function()
			vim.g.firenvim_config = {
				localSettings = {
					[ [[.*]] ] = {
						cmdline = "firenvim",
						priority = 0,
						selector = 'textarea:not([readonly]):not([class="handsontableInput"]), div[role="textbox"]',
						takeover = "always",
					},
					[ [[.*notion\.so.*]] ] = {
						priority = 9,
						takeover = "never",
					},
					[ [[.*docs\.google\.com.*]] ] = {
						priority = 9,
						takeover = "never",
					},
					[ [[google\.com.*]] ] = {
						priority = 9,
						takeover = "never",
					},
					[ [[twitch\.tv.*]] ] = {
						priority = 9,
						takeover = "never",
					},
				},
			}
		end,
		lazy = not vim.g.started_by_firenvim,
		build = function()
			vim.fn["firenvim#install"](0)
		end,
	},
}
