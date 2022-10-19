vim.g.catppuccin_flavour = "macchiato" -- latte, frappe, macchiato, mocha

local colors = require("catppuccin.palettes").get_palette()

require("catppuccin").setup({
	compile_path = vim.fn.stdpath("cache") .. "/catppuccin",
	transparent_background = false,
	term_colors = false,
	dim_inactive = {
		enabled = true,
		shade = "dark",
		percentage = 0.15,
	},
	styles = {
		comments = { "italic" },
		conditionals = { "italic" },
		loops = {},
		functions = {},
		keywords = {},
		strings = {},
		variables = {},
		numbers = {},
		booleans = {},
		properties = {},
		types = {},
		operators = {},
	},
	integrations = {
		cmp = true,
		-- coc_nvim = false,
		dashboard = true,
		-- fern = false,
		fidget = true,
		gitgutter = true,
		gitsigns = true,
		-- hop = false,
		-- illuminate = false,
		-- leap = false,
		-- lightspeed = false,
		-- lsp_saga = false,
		lsp_trouble = true,
		-- mason = true,
		-- markdown = true,
		-- neogit = false,
		-- neotest = false,
		-- neotree = false,
		notify = true,
		-- nvimtree = true,
		-- overseer = false,
		-- pounce = false,
		symbols_outline = true,
		telescope = true,
		treesitter = true,
		-- treesitter_context = false,
		-- ts_rainbow = false,
		-- vim_sneak = false,
		-- vimwiki = false,
		-- which_key = false,

		-- Special integrations, see https://github.com/catppuccin/nvim#special-integrations
		dap = {
			enabled = false,
			enable_ui = false,
		},
		indent_blankline = {
			enabled = true,
			colored_indent_levels = false,
		},
		native_lsp = {
			enabled = true,
			virtual_text = {
				errors = { "italic" },
				hints = { "italic" },
				warnings = { "italic" },
				information = { "italic" },
			},
			underlines = {
				errors = { "underline" },
				hints = { "underline" },
				warnings = { "underline" },
				information = { "underline" },
			},
		},
		navic = {
			enabled = false,
			custom_bg = "NONE",
		},
	},
	color_overrides = {},
    custom_highlights = {
        Identifier = { fg = colors.lavender },
        -- Identifier = { fg = colors.sapphire },
        Function = { fg = colors.mauve },
    },
})

require('catppuccin').compile()

vim.api.nvim_command "colorscheme catppuccin"
