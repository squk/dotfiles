local use_google = require("utils").use_google
local buf_too_large = require("utils").buf_too_large

return {
	{
		"shellRaining/hlchunk.nvim",
		event = { "BufReadPre", "BufNewFile" },
		opts = {
			line_num = { enable = true },
			chunk = {
				enable = true,
				priority = 15,
				style = {
					{ fg = "#403d4c" },
					{ fg = "#c21f30" },
				},
				chars = {
					horizontal_line = "─",
					-- vertical_line = "│",
					vertical_line = "┊",
					left_top = "╭",
					left_bottom = "╰",
					right_arrow = ">",
				},
				use_treesitter = true,
				textobject = "",
				max_file_size = 1024 * 1024,
				error_sign = true,
				-- animation related
				duration = 0,
				delay = 0,
			},
		},
	},
	{
		"Bekaboo/dropbar.nvim",
		-- optional, but required for fuzzy finder support
		dependencies = {
			"nvim-telescope/telescope-fzf-native.nvim",
		},
		config = function()
			vim.ui.select = require("dropbar.utils.menu").select
		end,
	},
	{
		"RRethy/vim-illuminate",
		config = function()
			local aug = vim.api.nvim_create_augroup("buf_large", { clear = true })
			vim.api.nvim_create_autocmd({ "BufReadPre" }, {
				callback = function()
					if buf_too_large() then
						vim.b.large_buf = true
						vim.cmd("syntax off")
						vim.cmd("IlluminatePauseBuf") -- disable vim-illuminate
						vim.opt_local.foldmethod = "manual"
						vim.opt_local.spell = false
					else
						vim.b.large_buf = false
					end
				end,
				group = aug,
				pattern = "*",
			})
		end,
	},
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
		opts = {},
		keys = {
			{ "<leader>ss", [[<cmd>lua require("persistence").save()<cr>]] },
			{ "<leader>sl", [[<cmd>lua require("persistence").load()<cr>]] },
		},
	},
	{
		"rmagatti/auto-session",
		dependencies = {
			"nvim-telescope/telescope.nvim", -- Only needed if you want to use session lens
		},
		config = function()
			require("auto-session").setup({
				auto_session_suppress_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
			})
		end,
	},
	"tpope/vim-abolish",
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
