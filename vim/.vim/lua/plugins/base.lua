local use_google = require("utils").use_google

return {
	-- Pretty symbols
	{
		"nvim-tree/nvim-web-devicons",
		lazy = false,
	},
	"jghauser/mkdir.nvim",
	"will133/vim-dirdiff",
	"renerocksai/calendar-vim",
	"google/vim-searchindex",
	"kosayoda/nvim-lightbulb",
	{
		"L3MON4D3/LuaSnip",
		build = "make install_jsregexp",
		config = function()
			require("luasnip.loaders.from_vscode").lazy_load()
		end,
		dependencies = { "rafamadriz/friendly-snippets" },
	},
	"ntpeters/vim-better-whitespace",
	"junegunn/fzf.vim",
	"nathanaelkane/vim-indent-guides",
	"tversteeg/registers.nvim",
	"jremmen/vim-ripgrep",
	"nvim-lua/plenary.nvim",
	-- Undo tree
	{
		"mbbill/undotree",
		cmd = "UndotreeToggle",
		config = function()
			vim.g.undotree_SetFocusWhenToggle = 1
		end,
	},

	{
		"renerocksai/telekasten.nvim",
		config = function()
			require("config.telekasten")
		end,
		keys = {
			{ "<leader>zf", ":lua require('telekasten').find_notes()<CR>", desc = "Find Notes" },
		},
	},
	{ "ray-x/go.nvim", ft = "go" },
	{ "ray-x/guihua.lua", ft = "go" },

	-- Rust
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

	{ "andymass/vim-matchup", event = "VimEnter" },
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
		"petertriho/nvim-scrollbar",
		config = function()
			require("scrollbar").setup()
		end,
		lazy = false,
	},
	{
		"rmagatti/auto-session",
		config = function()
			require("auto-session").setup({
				log_level = "error",
				-- auto_session_suppress_dirs = { "~/", "~/Downloads", "/", os.getenv("HOME")},
			})
		end,
	},
	{
		"ipod825/libp.nvim",
		config = function()
			require("libp").setup()
		end,
	},
	{
		"catppuccin/nvim",
		name = "catppuccin",
		lazy = false, -- make sure we load this during startup if it is your main colorscheme
		priority = 1000, -- make sure to load this before all the other start plugins
		config = function()
			require("config.catppuccin")
		end,
	},
	{
		"ojroques/nvim-osc52",
		config = function()
			require("config.oscyank")
		end,
	},
	{
		"squk/java-syntax.vim",
		lazy = false,
	},
	{
		"folke/which-key.nvim",
		config = function()
			require("config.whichkey")
		end,
	},
	{ "junegunn/fzf", build = ":call fzf#install()" },
	{ "udalov/kotlin-vim", ft = "kotin" },
	{
		"wesQ3/vim-windowswap",
		init = function()
			vim.g.windowswap_map_keys = 0
		end,
	},
	{ "vim-scripts/vcscommand.vim" },
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
