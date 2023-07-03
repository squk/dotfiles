return {
	"williamboman/mason-lspconfig.nvim",
	dependencies = {
		"williamboman/mason.nvim",
	},
	config = function()
		local TableConcat = require("utils").TableConcat
		local use_google = require("utils").use_google

		local lsps = {
			"lua_ls",
			"rust_analyzer",
		}

		if not use_google then
			TableConcat(lsps, {
				"gopls",
				"graphql",
			})
		end

		require("mason").setup()
		require("mason-lspconfig").setup({
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
