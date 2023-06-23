local use_google = require("utils").use_google

return {
	-- Pretty symbols
	"kyazdani42/nvim-web-devicons",

	"jghauser/mkdir.nvim",
	"will133/vim-dirdiff",
	"renerocksai/calendar-vim",
	"google/vim-searchindex",
	-- 'apalmer1377/factorus',
	"hrsh7th/vim-vsnip",
	"kosayoda/nvim-lightbulb",
	"tpope/vim-surround",
	"ntpeters/vim-better-whitespace",
	"junegunn/fzf.vim",
	"nathanaelkane/vim-indent-guides",
	"tversteeg/registers.nvim",
	"jremmen/vim-ripgrep",
	"nvim-lua/plenary.nvim",

	{
		"preservim/nerdcommenter",
		init = function()
			require("config.nerdcommenter")
		end,
		keys = {
			{ "<leader>c<Space>", ":call nerdcommenter#Comment(0, 'toggle')<CR>" },
			{ "<leader>c<Space>", ":call nerdcommenter#Comment(0, 'toggle')<CR>", mode = "v" },

			{ "<leader>cS", ":call nerdcommenter#Comment(0, 'sexy')<CR>" },
			{ "<leader>cS", ":call nerdcommenter#Comment(0, 'sexy')<CR>", mode = "v" },

			{ "<leader>c$", ":call nerdcommenter#Comment(0, 'ToEOL')<CR>" },
			{ "<leader>c$", ":call nerdcommenter#Comment(0, 'ToEOL')<CR>", mode = "v" },
		},
	},
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			require("config.nvim-treesitter")
		end,
		lazy = false,
	},

	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v2.x",
		config = function()
			require("config.neotree")
		end,
		dependencies = {
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
		},
		keys = {
			{ "<C-n>", ":Neotree filesystem reveal toggle reveal_force_cwd<cr>", desc = "Open NeoTree" },
		},
	},

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

	"williamboman/mason.nvim",
	"williamboman/mason-lspconfig.nvim",
	"nvim-lua/lsp-status.nvim",
	"VonHeikemen/lsp-zero.nvim",

	-- Completion and linting
	{
		"hrsh7th/nvim-cmp",
		event = "VimEnter",

		dependencies = {
			"onsails/lspkind.nvim",
			"neovim/nvim-lspconfig",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"lukas-reineke/cmp-under-comparator",
			"hrsh7th/cmp-cmdline",
			"f3fora/cmp-spell",
			"hrsh7th/cmp-nvim-lsp-document-symbol",
			"hrsh7th/cmp-nvim-lsp-signature-help",
			"hrsh7th/cmp-nvim-lua",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-vsnip",
			"ray-x/cmp-treesitter",
		},
		config = function()
			require("config.lsp")
		end,
	},
	{
		"tzachar/cmp-tabnine",
		build = "./install.sh",
		event = "InsertEnter",
		cond = not use_google(),
	},
	{
		"ErichDonGubler/lsp_lines.nvim",
		event = "VimEnter",
		keys = {
			{
				"<leader>l",
				function()
					require("lsp_lines").toggle()
				end,
				desc = "Toggle LSP Lines",
			},
		},
	},
	{
		"jose-elias-alvarez/null-ls.nvim",
		event = "VimEnter",
		config = function()
			require("config.null-ls")
		end,
	},

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

	{
		"folke/trouble.nvim",
		event = "VimEnter",
		config = function()
			require("config.trouble")
		end,
	},

	{
		"ThePrimeagen/refactoring.nvim",
		dependencies = {
			{ "nvim-lua/plenary.nvim" },
			{ "nvim-treesitter/nvim-treesitter" },
		},
		config = function()
			require("config.refactoring")
		end,
		keys = {
			-- remap to open the Telescope refactoring menu in visual mode
			{
				"<leader>rr",
				"<Esc><cmd>lua require('telescope').extensions.refactoring.refactors()<CR>",
				{ noremap = true },
			},

			-- Remaps for the refactoring operations currently offered by the plugin
			{
				"<leader>rx",
				[[ <Esc><Cmd>lua require('refactoring').refactor('Extract Function')<CR>]],
				mode = "v",
				{ noremap = true, silent = true, expr = false },
			},
			{
				"<leader>rxf",
				[[ <Esc><Cmd>lua require('refactoring').refactor('Extract Function To File')<CR>]],
				mode = "v",
				{ noremap = true, silent = true, expr = false },
			},
			{
				"<leader>rxv",
				[[ <Esc><Cmd>lua require('refactoring').refactor('Extract Variable')<CR>]],
				mode = "v",
				{ noremap = true, silent = true, expr = false },
			},
			{
				"<leader>ri",
				[[ <Esc><Cmd>lua require('refactoring').refactor('Inline Variable')<CR>]],
				mode = "v",
				{ noremap = true, silent = true, expr = false },
			},

			-- Extract block doesn't need visual mode
			{
				"<leader>rxb",
				[[ <Cmd>lua require('refactoring').refactor('Extract Block')<CR>]],
				{ noremap = true, silent = true, expr = false },
			},
			{
				"<leader>rxbf",
				[[ <Cmd>lua require('refactoring').refactor('Extract Block To File')<CR>]],
				{ noremap = true, silent = true, expr = false },
			},

			-- Inline variable can also pick up the identifier currently under the cursor without visual mode
			{
				"<leader>ri",
				[[ <Cmd>lua require('refactoring').refactor('Inline Variable')<CR>]],
				{ noremap = true, silent = true, expr = false },
			},
			{
				"<leader>rx",
				[[ <Cmd>lua require('refactoring').refactor('Extract Variable')<CR>]],
				{ noremap = true, silent = true, expr = false },
			},
		},
	},
	{ "andymass/vim-matchup", event = "VimEnter" },

	{
		"simrat39/symbols-outline.nvim",
		config = function()
			require("config.symbols-outline")
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
		"nvim-lualine/lualine.nvim",
		lazy = false,
		config = function()
			require("config.lualine")
		end,
	},
	{
		"rcarriga/nvim-notify",
		config = function()
			require("config.notify")
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

	-- mine
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
