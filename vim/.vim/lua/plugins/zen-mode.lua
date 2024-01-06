return {
	"folke/zen-mode.nvim",
	opts = {
		plugins = {
			tmux = { enabled = false },
		},
	},
	keys = { { "<C-z>", ":ZenMode<CR>" } },
}
