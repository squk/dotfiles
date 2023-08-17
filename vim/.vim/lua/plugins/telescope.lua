local use_google = require("utils").use_google
local TableConcat = require("utils").TableConcat
local scopes = require("neoscopes")

scopes.add_startup_scope()

-- Helper functions to fetch the current scope and set `search_dirs`
_G.find_files = function()
	require("telescope.builtin").find_files({
		search_dirs = scopes.get_current_dirs(),
	})
end
_G.live_grep = function()
	require("telescope.builtin").live_grep({
		search_dirs = scopes.get_current_dirs(),
	})
end

local keys = {
	{ "<leader>ts", [[<cmd>lua require("neoscopes").select()<CR>]], desc = "NeoScopes" },
	{ "<leader>tb", ":Telescope file_buffers<CR>", desc = "[T]elescope [B]uffers" },
	{ "<leader>tf", ":lua find_files()<CR>", desc = "[T]elescope [F]ind Files" },
	{ "<leader>tl", ":lua live_grep()<CR>", desc = "[T]elescope [L]ive Grep" },
	{ "<leader>tg", ":Telescope git_files<CR>", desc = "[T]elescope [G]it Files" },
	{ "<leader>t*", ":lua require('telescope.builtin').grep_string{}<CR>", desc = "[T]elescope current [W]ord" },
	{ "<leader>th", ":lua require('telescope.builtin').help_tags{}<CR>", desc = "[T]elescope [H]elp" },
}

if use_google() then
	TableConcat(keys, {
		{ "<C-P>", [[:lua require('telescope').extensions.codesearch.find_files{}<CR>]], "n" },
		{ "<C-Space>", [[:lua require('telescope').extensions.codesearch.find_query{}<CR>]] },
		{ "<leader>cs", [[:lua require('telescope').extensions.codesearch.find_query{}<CR>]] },
		{ "<leader>cs", [[:lua require('telescope').extensions.codesearch.find_query{}<CR>]], mode = "v" },
		{
			"<leader>CS",
			[[:lua require('telescope').extensions.codesearch.find_query{default_text_expand='<cword>'}<CR>]],
		},
	})
end

return {
	"nvim-telescope/telescope.nvim",
	dependencies = {
		"nvim-telescope/telescope-file-browser.nvim",
	},
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
			extensions = {
				-- this block is optional, and if omitted, defaults will be used
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
	keys = keys,
}
