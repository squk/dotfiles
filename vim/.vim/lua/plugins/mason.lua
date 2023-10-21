return {
	"williamboman/mason-lspconfig.nvim",
	dependencies = {
		"williamboman/mason.nvim",
	},
	config = function()
		local TableConcat = require("utils").TableConcat
		local use_google = require("utils").use_google

		local lsps = {
			"lus_la",
			"html",
			"rust_analyzer",
			"marksman",
			"pyright",
			"sqlls",
			"bashls",
			"dotls",
			"golangci_lint_ls",
		}

		if not use_google then
			TableConcat(lsps, {
				"tsserver",
				"gopls",
				"docker_compose_language_service",
				"dockerls",
				"graphql",
				"kotlin_language_server",
				"csharp_ls",
				"asm_lsp",
				"arduino_language_server",
				"clangd",
			})
		end

		require("mason").setup()
		require("mason-lspconfig").setup({
			automatic_installation = true,
			ensure_installed = lsps,
		})

		require("mason-lspconfig").setup_handlers({
			-- The first entry (without a key) will be the default handler
			-- and will be called for each installed server that doesn't have
			-- a dedicated handler.
			function(server_name) -- default handler (optional)
				require("lspconfig")[server_name].setup({})
			end,
			-- Next, you can provide a dedicated handler for specific servers.
			-- For example, a handler override for the `rust_analyzer`:
			["rust_analyzer"] = function()
				require("rust-tools").setup({})
			end,
		})
	end,
}
