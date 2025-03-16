vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
	pattern = "*.wgsl",
	callback = function()
		local lspconfig = require("lspconfig")
		lspconfig.wgsl_analyzer.setup({})

		vim.bo.filetype = "wgsl"
	end,
})
