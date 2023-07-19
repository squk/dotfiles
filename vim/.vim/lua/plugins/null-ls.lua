return {
	"jose-elias-alvarez/null-ls.nvim",
	event = "VimEnter",
	config = function()
		local null_ls = require("null-ls")
		local use_google = require("utils").use_google
		local TableConcat = require("utils").TableConcat

		local sources = {
			-- *
			null_ls.builtins.formatting.trim_whitespace,
			-- Catch insensitive, inconsiderate writing.
			null_ls.builtins.diagnostics.alex,

			-- buildifier is a tool for formatting and linting bazel BUILD, WORKSPACE, and .bzl files.
			null_ls.builtins.diagnostics.buildifier,
			null_ls.builtins.formatting.buildifier,

			-- Codespell finds common misspellings in text files.
			null_ls.builtins.diagnostics.codespell,
			-- null_ls.builtins.diagnostics.cspell, null_ls.builtins.code_actions.cspell,

			-- An English prose linter. Can fix some issues via code actions.
			null_ls.builtins.code_actions.proselint,

			-- Reformats Java source code according to Google Java Style.
			null_ls.builtins.formatting.google_java_format,

			-- XML
			-- null_ls.builtins.diagnostics.tidy,
			-- null_ls.builtins.formatting.xmlformat,
			-- null_ls.builtins.formatting.xq,
			-- null_ls.builtins.formatting.xmllint.with({ extra_args = { "--pretty", "2" } }),
			null_ls.builtins.formatting.tidy.with({
				filetypes = { "xml" },
				args = {
					"-xml",
					"-quiet",
					"-wrap",
					"--tidy-mark",
					"no",
					"--indent",
					"yes",
					"--indent-spaces",
					"2",
					"--indent-attributes",
					"yes",
					"--sort-attributes",
					"alpha",
					"--wrap-attributes",
					"yes",
					"--vertical-space",
					"yes",
					"-",
				},
			}),
			null_ls.builtins.formatting.stylua,
		}

		if not use_google then
			TableConcat(sources, {
				-- Bazel
				null_ls.builtins.diagnostics.buildifier,
				null_ls.builtins.formatting.buildifier,
				-- Golang
				null_ls.builtins.diagnostics.golangci_lint,
				null_ls.builtins.formatting.gofmt,
				null_ls.builtins.formatting.goimports_reviser,
				-- Misc
				null_ls.builtins.formatting.htmlbeautifier,
				null_ls.builtins.formatting.jq,
				null_ls.builtins.formatting.mdformat,
			})
		end

		local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
		null_ls.setup({
			on_init = function(new_client, _)
				new_client.offset_encoding = "utf-8"
			end,
			sources = sources,
			-- you can reuse a shared lspconfig on_attach callback here
			on_attach = function(client, bufnr)
				if client.supports_method("textDocument/formatting") then
					vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
					vim.api.nvim_create_autocmd("BufWritePre", {
						group = augroup,
						buffer = bufnr,
						callback = function()
							vim.lsp.buf.format({ async = false })
						end,
					})
				end
			end,
		})
	end,
}
