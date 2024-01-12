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
				event_handlers = {
					{
						event = "neo_tree_buffer_enter",
						handler = function(arg)
							vim.opt.mouse = "a"
						end,
					},
					{
						event = "neo_tree_window_after_open",
						handler = function(args)
							vim.opt.mouse = "a"
						end,
					},
					{
						event = "neo_tree_buffer_leave",
						handler = function(arg)
							vim.opt.mouse = ""
						end,
					},
					{
						event = "neo_tree_window_after_close",
						handler = function(arg)
							vim.opt.mouse = ""
						end,
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
