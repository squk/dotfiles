return {
	"folke/zen-mode.nvim",
	opts = {
		window = {
			width = 0.4,
		},
		plugins = {
			tmux = { enabled = true },
		},
	},
	keys = { { "<C-z>", ":ZenMode<CR>" } },
}
