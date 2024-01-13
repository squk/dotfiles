return {
	"PrestonKnopp/tree-sitter-gdscript",
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			require("nvim-treesitter.configs").setup({
				-- A list of parser names, or "all" (the five listed parsers should always be installed)
				ensure_installed = {
					"c",
					"lua",
					"vim",
					"vimdoc",
					"query",
					"java",
					"kotlin",
					"python",
					"gdscript",
					"rust",
					"bash",
					"go",
					"java",
					"json",
					"markdown",
				},

				-- Install parsers synchronously (only applied to `ensure_installed`)
				sync_install = false,

				-- Automatically install missing parsers when entering buffer
				-- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
				auto_install = true,

				-- List of parsers to ignore installing (or "all")
				-- ignore_install = { "smali" },
				highlight = {
					enable = true,

					-- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
					-- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
					-- the name of the parser)
					-- list of language that will be disabled
					-- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
					disable = function(lang, buf)
						--TODO write a custom Java treesitter parser for comments
						--@link
						--
						if lang == "gdrama" then
							return true
						end

						local max_filesize = 200 * 1024 -- 200 KB
						local fname = vim.api.nvim_buf_get_name(buf)
						local ok, stats = pcall(vim.loop.fs_stat, fname)
						if ok and stats and stats.size > max_filesize then
							vim.schedule(function()
								vim.notify(
									string.format(
										"Disabling treesitter. File %s exceeds maximum configured size.",
										fname
									)
								)
							end)
							return true
						end
					end,

					-- Setting this to true will run `:h syntax` and tree-sitter at the same time.
					-- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
					-- Using this option may slow down your editor, and you may see some duplicate highlights.
					-- Instead of true it can also be a list of languages
					additional_vim_regex_highlighting = { "java", "kotlin" },
				},
			})
		end,
	},
}
