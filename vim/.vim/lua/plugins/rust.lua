return {
	{
		"mrcjkb/rustaceanvim",
		version = "^3", -- Recommended
		ft = { "rust" },
		keys = {
			{ "<leader>rd", ":RustLsp renderDiagnostic<CR>" },
			{ "<leader>ree", ":RustLsp explainError<CR>" },
			{ "<leader>rem", ":RustLsp expandMacro<CR>" },
		},
	},
	{
		"saecki/crates.nvim",
		ft = "rust",
		version = "v0.3.0",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("crates").setup()
		end,
	},
}
