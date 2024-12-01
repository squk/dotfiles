return {
	{
		"mrcjkb/rustaceanvim",
		version = "^5", -- Recommended
		lazy = false, -- This plugin is already lazy
	},
	{
		"saecki/crates.nvim",
		-- event = { "BufRead Cargo.toml" },
		-- ft = "rust",
		-- dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("crates").setup({

				completion = {
					cmp = {
						enabled = true,
					},
				},
			})
		end,
	},
}
