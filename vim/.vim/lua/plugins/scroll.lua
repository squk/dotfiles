return {
	{
		"petertriho/nvim-scrollbar",
		config = function()
			require("scrollbar").setup({
				show_in_active_only = true,
				excluded_filetypes = {
					"cmp_docs",
					"cmp_menu",
					"noice",
					"prompt",
					"TelescopePrompt",
					"neo-tree",
				},
			})
		end,
		lazy = false,
	},
}
