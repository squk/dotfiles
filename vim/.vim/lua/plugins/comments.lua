return {
	"numToStr/Comment.nvim",
	keys = {
		{ "<leader>c<space>", mode = "n", desc = "Comment toggle current line" },
		{ "gc", mode = { "n", "o" }, desc = "Comment toggle linewise" },
		{ "gc", mode = "x", desc = "Comment toggle linewise (visual)" },
		{ "gbc", mode = "n", desc = "Comment toggle current block" },
		{ "gb", mode = { "n", "o" }, desc = "Comment toggle blockwise" },
		{ "gb", mode = "x", desc = "Comment toggle blockwise (visual)" },
	},
	config = function()
		local ft = require("Comment.ft")
		ft.gd = "# %s"
		ft.gdscript = "# %s"
		ft.gsl = "// %s"

		require("Comment").setup({
			---Add a space b/w comment and the line
			padding = true,
			---Whether the cursor should stay at its position
			sticky = true,
			---Lines to be ignored while (un)comment
			ignore = nil,
			---LHS of toggle mappings in NORMAL mode
			toggler = {
				---Line-comment toggle keymap
				line = "<leader>c<Space>",
				---Block-comment toggle keymap
				block = "<leader>cb",
			},
			---LHS of operator-pending mappings in NORMAL and VISUAL mode
			opleader = {
				---Line-comment keymap
				line = "gc",
				---Block-comment keymap
				block = "gb",
			},
			---LHS of extra mappings
			extra = {
				---Add comment on the line above
				above = "gcO",
				---Add comment on the line below
				below = "gco",
				---Add comment at the end of line
				eol = "gcA",
			},
			---Enable keybindings
			---NOTE: If given `false` then the plugin won't create any mappings
			mappings = {
				---Operator-pending mapping; `gcc` `gbc` `gc[count]{motion}` `gb[count]{motion}`
				basic = true,
				---Extra mapping; `gco`, `gcO`, `gcA`
				extra = true,
			},
			---Function to call before (un)comment
			pre_hook = nil,
			---Function to call after (un)comment
			post_hook = nil,
		})
	end,
}
