vim.api.nvim_create_autocmd({ "BufReadCmd" }, {
	pattern = "*.srcjar",
	callback = function()
		vim.api.nvim_command("call zip#Browse(expand('<amatch>'))")
	end,
})
