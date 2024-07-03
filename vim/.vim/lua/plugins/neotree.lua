return {
	{
		"nvim-neo-tree/neo-tree.nvim",
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
				source_selector = {
					winbar = false, -- toggle to show selector on winbar
					statusline = false, -- toggle to show selector on statusline
					show_scrolled_off_parent_node = false, -- boolean
					sources = { -- table
						{
							source = "filesystem", -- string
							display_name = "  Files ", -- string | nil
						},
						{
							source = "buffers", -- string
							display_name = "  Buffers ", -- string | nil
						},
						{
							source = "git_status", -- string
							display_name = "  Git ", -- string | nil
						},
					},
					content_layout = "start", -- string
					tabs_layout = "equal", -- string
					truncation_character = "…", -- string
					tabs_min_width = nil, -- int | nil
					tabs_max_width = nil, -- int | nil
					padding = 0, -- int | { left: int, right: int }
					separator = { left = "▏", right = "▕" }, -- string | { left: string, right: string, override: string | nil }
					separator_active = nil, -- string | { left: string, right: string, override: string | nil } | nil
					show_separator_on_edge = false, -- boolean
					highlight_tab = "NeoTreeTabInactive", -- string
					highlight_tab_active = "NeoTreeTabActive", -- string
					highlight_background = "NeoTreeTabInactive", -- string
					highlight_separator = "NeoTreeTabSeparatorInactive", -- string
					highlight_separator_active = "NeoTreeTabSeparatorActive", -- string
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
			-- { "<C-n>", ":Neotree filesystem reveal toggle dir=%:p:h<cr>", desc = "Open NeoTree" },
			{ "<C-N>", ":Neotree reveal_force_cwd<CR>", desc = "Open NeoTree CWD" },
			{ "<C-n>", ":Neotree float reveal_force_cwd<CR>", desc = "Open NeoTree CWD float" },
		},
	},
}
