return {
	"preservim/nerdcommenter",
	init = function()
		require("config.nerdcommenter")
	end,
	keys = {
		{ "<leader>c<Space>", ":call nerdcommenter#Comment(0, 'toggle')<CR>" },
		{ "<leader>c<Space>", ":call nerdcommenter#Comment(0, 'toggle')<CR>", mode = "v" },

		{ "<leader>cS", ":call nerdcommenter#Comment(0, 'sexy')<CR>" },
		{ "<leader>cS", ":call nerdcommenter#Comment(0, 'sexy')<CR>", mode = "v" },

		{ "<leader>c$", ":call nerdcommenter#Comment(0, 'ToEOL')<CR>" },
		{ "<leader>c$", ":call nerdcommenter#Comment(0, 'ToEOL')<CR>", mode = "v" },
	},
}
