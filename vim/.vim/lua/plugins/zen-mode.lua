return {
	"folke/zen-mode.nvim",
	opts = {
		window = {
			width = 140,
		},
		plugins = {
			tmux = { enabled = false },
		},
	},
	keys = { { "<C-z>", ":ZenMode<CR>" } },
}
