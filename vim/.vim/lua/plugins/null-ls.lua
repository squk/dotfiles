return {
	"jose-elias-alvarez/null-ls.nvim",
	event = "VimEnter",
	config = function()
		local null_ls = require("null-ls")
		local use_google = require("utils").use_google
		local TableConcat = require("utils").TableConcat

		local sources = {
			-- Catch insensitive, inconsiderate writing.
			null_ls.builtins.diagnostics.alex,

			-- buildifier is a tool for formatting and linting bazel BUILD, WORKSPACE, and .bzl files.
			null_ls.builtins.diagnostics.buildifier,

			-- Codespell finds common misspellings in text files.
			null_ls.builtins.diagnostics.codespell,
			-- null_ls.builtins.diagnostics.cspell, null_ls.builtins.code_actions.cspell,

			-- An English prose linter. Can fix some issues via code actions.
			null_ls.builtins.code_actions.proselint,

			-- Reformats Java source code according to Google Java Style.
			null_ls.builtins.formatting.google_java_format,
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

		null_ls.setup({
			sources = sources,
		})
	end,
}
