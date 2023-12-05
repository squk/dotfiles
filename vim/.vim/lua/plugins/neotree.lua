return {
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v2.x",
		config = function()
			require("neo-tree").setup({
				sources = {
					"filesystem",
					"buffers",
					"git_status",
					"diagnostics",
					-- ...and any additional source
				},
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
		keys = {
			{ "<C-n>", ":Neotree filesystem reveal toggle reveal_force_cwd<cr>", desc = "Open NeoTree" },
		},
	},
}
