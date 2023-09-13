return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v2.x",
	config = function()
		require("neo-tree").setup({
			hijack_netrw_behavior = "open_current",
			window = {
				mappings = {
					["O"] = "expand_all_nodes",
				},
			},
		})
	end,
	dependencies = {
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
	},
	lazy = false,
	keys = {
		{ "<C-n>", ":Neotree filesystem reveal toggle reveal_force_cwd<cr>", desc = "Open NeoTree" },
	},
}
