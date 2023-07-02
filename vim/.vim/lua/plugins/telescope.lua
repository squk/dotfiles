return {
	"nvim-telescope/telescope-file-browser.nvim",
	dependencies = {
		"nvim-telescope/telescope.nvim",
	},
}, {
	"nvim-telescope/telescope.nvim",
	branch = "0.1.x",
	config = function()
		require("telescope").setup({
			defaults = {
				-- The vertical layout strategy is good to handle long paths like those in
				-- google3 repos because you have nearly the full screen to display a file path.
				-- The caveat is that the preview area is smaller.
				layout_strategy = "vertical",
				-- Common paths in google3 repos are collapsed following the example of Cider
				-- It is nice to keep this as a user config rather than part of
				-- telescope-codesearch because it can be reused by other telescope pickers.
				path_display = function(opts, path)
					-- Do common substitutions
					path = path:gsub("^/google/src/cloud/[^/]+/[^/]+/google3/", "google3/", 1)
					path = path:gsub("^google3/java/com/google/", "g3/j/c/g/", 1)
					path = path:gsub("^google3/javatests/com/google/", "g3/jt/c/g/", 1)
					path = path:gsub("^google3/third_party/", "g3/3rdp/", 1)
					path = path:gsub("^google3/", "g3/", 1)

					-- Do truncation. This allows us to combine our custom display formatter
					-- with the built-in truncation.
					-- `truncate` handler in transform_path memoizes computed truncation length in opts.__length.
					-- Here we are manually propagating this value between new_opts and opts.
					-- We can make this cleaner and more complicated using metatables :)
					local new_opts = {
						path_display = {
							truncate = true,
						},
						__length = opts.__length,
					}
					path = require("telescope.utils").transform_path(new_opts, path)
					opts.__length = new_opts.__length
					return path
				end,
			},
			extensions = { -- this block is optional, and if omitted, defaults will be used
				file_browser = {
					-- disables netrw and use telescope-file-browser in its place
					hijack_netrw = false,
				},
				codesearch = {
					experimental = true, -- enable results from google3/experimental
				},
			},
		})
		require("telescope").load_extension("file_browser")
	end,
	keys = {
		{
			"<leader>fb",
			":Telescope file_browser path=%:p:h select_buffer=true<CR>",
			{ noremap = true },
			desc = "[F]ile [B]rowser",
		},
		{
			"<leader>tf",
			":Telescope file_browser",
			{ noremap = true },
			desc = "[T]elescope [F]ilebrowser",
		},
		{ "<leader>tb", ":Telescope file_buffers", desc = "[T]elescope [B]uffers" },
		{ "<leader>th", [[:lua require('telescope.builtin').help_tags<cr>]], desc = "[T]elescope [H]elp" },
		{ "<leader>tw", [[:lua require('telescope.builtin').grep_string<cr>]], desc = "[T]elescope current [W]ord" },
		{ "<leader>tg", [[:lua require('telescope.builtin').live_grep<cr>]], desc = "[T]elescope by [G]rep" },

		-- Google mappings
		{
			"<C-P>",
			[[:lua require('telescope').extensions.codesearch.find_files{}<CR>]],
			"n",
			{ noremap = true, silent = true },
		},
		{
			"<C-Space>",
			[[:lua require('telescope').extensions.codesearch.find_query{}<CR>]],
			{ noremap = true, silent = true },
		},
		{
			"<leader>cs",
			[[:lua require('telescope').extensions.codesearch.find_query{}<CR>]],
			{ noremap = true, silent = true },
		},
		{
			"<leader>cs",
			[[:lua require('telescope').extensions.codesearch.find_query{}<CR>]],
			mode = "v",
			{ noremap = true, silent = true },
		},
		{
			"<leader>CS",
			[[:lua require('telescope').extensions.codesearch.find_query{default_text_expand='<cword>'}<CR>]],
			{ noremap = true, silent = true },
		},
	},
}
