vim.g.catppuccin_flavour = "macchiato" -- latte, frappe, macchiato, mocha
local colors = require("catppuccin.palettes").get_palette()

require("catppuccin").setup({
    flavour = "macchiato",
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
	},
    custom_highlights = {
        Identifier = { fg = colors.lavender },
        Statement = { fg = colors.rosewater },
        -- Identifier = { fg = colors.sapphire },
        Function = { fg = colors.mauve },
    },
})

vim.api.nvim_command "colorscheme catppuccin"
