return {
	"williamboman/mason-lspconfig.nvim",
	dependencies = {
		"williamboman/mason.nvim",
	},
	config = function()
		local TableConcat = require("utils").TableConcat
		local use_google = require("utils").use_google

		local lsps = {
			-- "lua_ls",
			"html",
			"rust_analyzer",
			"marksman",
			"pyright",
			"sqlls",
			"bashls",
			"dotls",
			"golangci_lint_ls",
		}

		if not use_google() then
			TableConcat(lsps, {
				"omnisharp_mono",
				"tsserver",
				"gopls",
				"docker_compose_language_service",
				"dockerls",
				"graphql",
				"kotlin_language_server",
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
			["omnisharp_mono"] = function()
				require("lspconfig").omnisharp.setup({
					-- cmd = { "dotnet", "/path/to/omnisharp/OmniSharp.dll" },

					-- Enables support for reading code style, naming convention and analyzer
					-- settings from .editorconfig.
					enable_editorconfig_support = true,

					-- If true, MSBuild project system will only load projects for files that
					-- were opened in the editor. This setting is useful for big C# codebases
					-- and allows for faster initialization of code navigation features only
					-- for projects that are relevant to code that is being edited. With this
					-- setting enabled OmniSharp may load fewer projects and may thus display
					-- incomplete reference lists for symbols.
					enable_ms_build_load_projects_on_demand = false, -- default false

					-- Enables support for roslyn analyzers, code fixes and rulesets.
					enable_roslyn_analyzers = true, -- default false

					-- Specifies whether 'using' directives should be grouped and sorted during
					-- document formatting.
					organize_imports_on_format = true, -- default false

					-- Enables support for showing unimported types and unimported extension
					-- methods in completion lists. When committed, the appropriate using
					-- directive will be added at the top of the current file. This option can
					-- have a negative impact on initial completion responsiveness,
					-- particularly for the first few completion sessions after opening a
					-- solution.
					enable_import_completion = true, -- default false

					-- Specifies whether to include preview versions of the .NET SDK when
					-- determining which version to use for project loading.
					sdk_include_prereleases = true,

					-- Only run analyzers against open files when 'enableRoslynAnalyzers' is
					-- true
					analyze_open_documents_only = true, -- default false
				})
			end,
			["lua_ls"] = function()
				require("lspconfig").lua_ls.setup({
					settings = {
						Lua = {
							runtime = {
								-- Tell the language server which version of Lua you're using
								-- (most likely LuaJIT in the case of Neovim)
								version = "LuaJIT",
							},
							diagnostics = {
								-- Get the language server to recognize the `vim` global
								globals = {
									"vim",
									"require",
								},
							},
							workspace = {
								checkThirdParty = false, -- stop a annoying dialog on startup
								-- Make the server aware of Neovim runtime files
								-- library = vim.api.nvim_get_runtime_file("", true),
								library = {
									[vim.fn.expand("$VIMRUNTIME/lua")] = true,
									[vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
								},
							},
							-- Do not send telemetry data containing a randomized but unique identifier
							telemetry = {
								enable = false,
							},
						},
					},
				})
			end,
		})
	end,
}
