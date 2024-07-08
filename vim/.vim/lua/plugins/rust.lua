return {
	{
		"vxpm/ferris.nvim",
		ft = "rust",
		config = function()
			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities.offsetEncoding = { "utf-16" }
			require("lspconfig").rust_analyzer.setup({
				-- offset_encoding = "utf-8",
				-- capabilities,
				settings = { ["rust-analyzer"] = {} },
			})
		end,
	},
	{
		"saecki/crates.nvim",
		ft = "rust",
		version = "v0.3.0",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("crates").setup()
		end,
	},
}
