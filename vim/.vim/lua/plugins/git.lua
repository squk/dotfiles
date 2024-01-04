return {
	-- Git
	-- {
	-- 	"lewis6991/gitsigns.nvim",
	-- 	dependencies = "nvim-lua/plenary.nvim",
	-- 	event = "VimEnter",
	-- 	config = function()
	-- 		require("gitsigns").setup()
	-- 	end,
	-- },
	{
		"akinsho/git-conflict.nvim",
		version = "*",
		config = function()
			require("git-conflict").setup()
		end,
	},
	{ "rhysd/conflict-marker.vim" },
}
