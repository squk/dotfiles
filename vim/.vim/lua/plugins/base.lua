local use_google = require("utils").use_google

return {
	"RRethy/vim-illuminate",
	"kdheepak/lazygit.nvim",
	"flwyd/vim-conjoin",
	"rafcamlet/nvim-luapad",
	"vim-scripts/vcscommand.vim",
	"AndrewRadev/tagalong.vim",
	"AndrewRadev/yankwin.vim",
	{ "squk/gdrama-syntax.vim", ft = "gdrama" },
	{ "nvim-lua/plenary.nvim", lazy = false },
	{ "squk/java-syntax.vim", ft = "java" },
	{ "udalov/kotlin-vim", event = "VeryLazy", ft = "kotlin" },
	{ "andymass/vim-matchup", event = "VimEnter" },
	{ "jghauser/mkdir.nvim", event = "BufWritePre" },
	-- Session management
	{
		"folke/persistence.nvim",
		event = "BufReadPre", -- this will only start session saving when an actual file was opened
		opts = {
			-- add any custom options here
		},
	},
	{
		"johmsalas/text-case.nvim",
		dependencies = { "nvim-telescope/telescope.nvim" },
		config = function()
			require("textcase").setup({})
			require("telescope").load_extension("textcase")
		end,
		cmd = {
			"Subs",
		},
		keys = {
			{ "<leader>tc", "<cmd>TextCaseOpenTelescope<CR>", mode = { "n", "v" }, desc = "Telescope" },
		},
	},
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
		keys = { { "<leader>ut", ":UndotreeToggle<CR>" } },
	},
	{
		"stevearc/aerial.nvim",
		opts = {},
		cmd = { "AerialToggle", "AerialOn" },
		keys = { { "<leader>so", ":AerialToggle<CR>", desc = "[S]symbols [O]utline" } },
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
