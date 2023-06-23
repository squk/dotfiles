require("nvim-treesitter.configs").setup({
	-- A list of parser names, or "all"
	-- ensure_installed = { "c", "lua", "vim", "java", "kotlin"},
	ensure_installed = "all",

	-- Install parsers synchronously (only applied to `ensure_installed`)
	sync_install = false,

	highlight = {
		-- `false` will disable the whole extension
		enable = true,
		indent = {
			enable = true,
		},
		-- disable = {"java"},
		--
		-- Setting this to true will run `:h syntax` and tree-sitter at the same time.
		-- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
		-- Using this option may slow down your editor, and you may see some duplicate highlights.
		-- Instead of true it can also be a list of languages
		-- additional_vim_regex_highlighting = true,
		additional_vim_regex_highlighting = { "java" },
	},
	-- rainbow = {
	--     enable = true,
	--     extended_mode = true,
	-- }
})
