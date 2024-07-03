return {
	"nvimdev/dashboard-nvim",
	event = "VimEnter",
	config = function()
		require("dashboard").setup({
			theme = "hyper",
			config = {
				week_header = {
					enable = true,
				},
				shortcut = {
					{ desc = "󰊳 Update", group = "@property", action = "Lazy update", key = "u" },
					{
						desc = "󰦛  cwd session",
						group = "Number",
						action = function()
							require("persistence").load()
						end,
						key = ".",
					},
					{
						icon = " ",
						icon_hl = "@variable",
						desc = "Files",
						group = "Label",
						action = "Telescope find_files",
						key = "f",
					},
					{
						desc = " dotfiles",
						group = "Number",
						action = "lua find_dotfiles()",
						key = "d",
					},
					{
						desc = " sessions",
						group = "Number",
						action = "Telescope persisted",
						key = "s",
					},
				},
			},
		})
	end,
	keys = { { "<C-Space>", ":Dashboard<CR>" } },
	dependencies = { { "nvim-tree/nvim-web-devicons" } },
}
