return {
	"VidocqH/lsp-lens.nvim",
	event = "BufEnter",
	config = function()
		vim.cmd([[autocmd BufEnter,CursorHold,InsertLeave <buffer> lua vim.lsp.codelens.refresh()]])

		require("lsp-lens").setup({
			enable = true,
			include_declaration = false, -- Reference include declaration
			sections = { -- Enable / Disable specific request
				definition = false,
				references = true,
				implementation = true,
			},
			ignore_filetype = {
				"prisma",
			},
		})
	end,
}