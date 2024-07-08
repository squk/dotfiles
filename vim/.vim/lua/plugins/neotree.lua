local use_google = require("utils").use_google

return {
	{
		"cmdtree",
		dir = "~/cmdtree",
	},
	{
		"nvim-neo-tree/neo-tree.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
			"~/cmdtree",
		},
		cmd = {
			"Neotree",
		},
		config = function()
			require("neo-tree").setup({
				hijack_netrw_behavior = "open_default",
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
					"cmdtree",
					-- ...and any additional source
				},
				window = {
					mappings = {
						["O"] = "expand_all_nodes",
					},
				},
			})
		end,
		keys = {
			(function()
				if use_google() then
					return { "<C-n>", ":Neotree toggle left cmdtree<CR>", desc = "Open NeoTree CWD float" }
				end
				-- return { "<C-n>.", ":Neotree toggle reveal_force_cwd<CR>", desc = "Open NeoTree CWD float" }
				return { "<C-n>", ":Neotree toggle left git_status<CR>", desc = "Open NeoTree CWD float" }
			end)(),
			{ "<C-n>b", ":Neotree float buffers<CR>" },
			{ "<C-n>.", ":Neotree reveal toggle dir=%:p:h<cr>" },
			{ "<C-n>c", ":Neotree toggle reveal_force_cwd<CR>", desc = "Open NeoTree CWD float" },
		},
	},
}
