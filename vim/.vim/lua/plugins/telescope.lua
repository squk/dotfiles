local use_google = require("utils").use_google
local TableConcat = require("utils").TableConcat
local scopes = require("neoscopes")

-- Helper functions to fetch the current scope and set `search_dirs`
_G.find_files = function()
	require("telescope.builtin").find_files({
		search_dirs = scopes.get_current_dirs(),
	})
end

_G.search_cwd = function()
	local builtin = require("telescope.builtin")
	local utils = require("telescope.utils")
	builtin.find_files({ cwd = utils.buffer_dir() })
end

_G.live_grep = function()
	require("telescope.builtin").live_grep({
		search_dirs = scopes.get_current_dirs(),
	})
end

local function get_visual_selection()
	-- Yank current visual selection into the 'v' register
	--
	-- Note that this makes no effort to preserve this register
	vim.cmd('noau normal! "vy"')

	return vim.fn.getreg("v")
end

local keys = {
	{ "<leader>ts", "<cmd>lua live_grep()<CR>", desc = "Search in CWD" },
	{ "<C-P>", "<cmd>lua find_files()<CR>", desc = "Find Files in CWD" },
	{ "<leader>tf", "<cmd>lua find_files()<CR>", desc = "Find Files in CWD" },
	{ "<leader>tf.", "<cmd>lua vim.error('use <leader>e')<CR>", desc = "Find Files in Buffer Directory" },
	{ "<leader>e", "<cmd>lua search_cwd()<CR>", desc = "Find Files in Buffer Directory" },
	{ "<leader>tg", ":Telescope git_files<CR>", desc = "Git Files" },
	{ "<leader>tl", ":Telescope resume<CR>", desc = "Last Query" },
	{ "<leader>tr", ":Telescope oldfiles<CR>", desc = "Recent Files" },
	{ "<leader>th", "<cmd>lua require('telescope.builtin').help_tags{}<CR>", desc = "[T]elescope [H]elp" },
	{ "<leader>tns", [[<cmd>lua require("neoscopes").select()<CR>]], desc = "NeoScopes" },
}

if use_google() then
	TableConcat(keys, {
		{ "<C-P>", [[<cmd>lua require('telescope').extensions.codesearch.find_files{}<CR>]], "n" },
		{ "<C-Space>", [[<cmd>lua require('telescope').extensions.codesearch.find_query{}<CR>]] },
		{ "<leader>cs", [[<cmd>lua require('telescope').extensions.codesearch.find_query{}<CR>]] },
		{ "<leader>cs", [[<cmd>lua require('telescope').extensions.codesearch.find_query{}<CR>]], mode = "v" },
		{
			"<leader>CS",
			[[<cmd>lua require('telescope').extensions.codesearch.find_query{default_text_expand='<cword>'}<CR>]],
		},
	})
end

return {
	"nvim-telescope/telescope.nvim",
	dependencies = {
		-- "nvim-telescope/telescope-smart-history.nvim",
		-- "kkharji/sqlite.lua",
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
					path = path:gsub("^google3/java/com/google/", "//j/c/g/", 1)
					path = path:gsub("^google3/javatests/com/google/", "//jt/c/g/", 1)
					path = path:gsub("^google3/third_party/", "//3p/", 1)
					path = path:gsub("^google3/", "//", 1)

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
				mappings = {
					i = {
						["<S-Down>"] = function()
							require("telescope.actions").cycle_history_next()
						end,
						["<S-Up>"] = function()
							require("telescope.actions").cycle_history_prev()
						end,
					},
				},
				-- history = {
				--     path = "~/.local/share/nvim/databases/telescope_history.sqlite3",
				--     limit = 200,
				-- },
			},
			extensions = {
				codesearch = {
					experimental = true, -- enable results from google3/experimental
				},
			},
		})

		-- require("telescope").load_extension("smart_history")
	end,
	keys = keys,
}
