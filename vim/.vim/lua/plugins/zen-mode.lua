return {
	"folke/zen-mode.nvim",
	opts = {
		window = {
			width = 0.8,
		},
		plugins = {
			tmux = { enabled = false },
		},
	},
	keys = { { "<C-z>", ":ZenMode<CR>" } },
}
