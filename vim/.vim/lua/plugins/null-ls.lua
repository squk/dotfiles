return {
	"jose-elias-alvarez/null-ls.nvim",
	event = "VimEnter",
	config = function()
		local null_ls = require("null-ls")

		local sources = {
			-- Catch insensitive, inconsiderate writing.
			null_ls.builtins.diagnostics.alex,

			-- buildifier is a tool for formatting and linting bazel BUILD, WORKSPACE, and .bzl files.
			null_ls.builtins.diagnostics.buildifier,

			-- Codespell finds common misspellings in text files.
			-- null_ls.builtins.diagnostics.codespell,
			-- null_ls.builtins.diagnostics.cspell, null_ls.builtins.code_actions.cspell,

			-- An English prose linter. Can fix some issues via code actions.
			null_ls.builtins.code_actions.proselint,

			-- Reformats Java source code according to Google Java Style.
			null_ls.builtins.formatting.google_java_format,
		}

		null_ls.setup({
			sources = sources,
		})
	end,
}
