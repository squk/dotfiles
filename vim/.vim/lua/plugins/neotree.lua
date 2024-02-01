return {
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v2.x",
		-- cmd = {
		-- 	"NeoTreeFocusToggle",
		-- 	"NeoTreeFloatToggle",
		-- 	"NeoTreeRevealToggle",
		-- 	"NeoTreeShowToggle",
		-- },
		config = function()
			require("neo-tree").setup({
				filesystem = {
					filtered_items = {
						hide_dotfiles = false,
					},
					bind_to_cwd = false,
				},
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
			{ "<C-n>", ":Neotree filesystem reveal toggle dir=%:p:h<cr>", desc = "Open NeoTree" },
		},
	},
}
