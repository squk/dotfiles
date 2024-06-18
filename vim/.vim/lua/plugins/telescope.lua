local use_google = require("utils").use_google
local exec = require("utils").exec
local TableConcat = require("utils").TableConcat
local scopes = require("neoscopes")

_G.find_files = function(search_dirs)
	require("telescope.builtin").find_files({
		search_dirs = search_dirs,
	})
end
-- Helper functions to fetch the current scope and set `search_dirs`
_G.find_dotfiles = function()
	require("telescope.builtin").git_files({
		cwd = vim.fn.expand("$HOME/dotfiles"),
	})
end

_G.search_cwd = function()
	local builtin = require("telescope.builtin")
	local utils = require("telescope.utils")
	builtin.find_files({ cwd = utils.buffer_dir() })
end

_G.live_grep = function(search_dirs)
	require("telescope.builtin").live_grep({
		search_dirs = search_dirs,
		-- search_dirs = ,
	})
end

local function exe(cmd)
	return vim.split(vim.fn.system(cmd), "\n")
end

local function get_visual_selection()
	-- Yank current visual selection into the 'v' register
	--
	-- Note that this makes no effort to preserve this register
	vim.cmd('noau normal! "vy"')

	return vim.fn.getreg("v")
end

function fig_modified()
	return exe("hg pstatus -ma -n --no-status --template= | sort")
end
function fig_all_modified()
	return exe("hg status -ma -n --rev p4base --no-status --template= | sort")
end

local keys = {
	{ "<C-P>", ":lua find_files(scopes.get_current_dirs())<CR>", desc = "Find Files in CWD" },
	{ "<leader>e", ":lua search_cwd()<CR>", desc = "Find Files in Buffer Directory" },
	{ "<leader>tc", ":Telescope textcase<CR>", desc = "Text case" },
	{ "<leader>t.", ":lua find_dotfiles()<CR>", desc = "Find Dotfiles" },
	{ "<leader>tdc", ":Telescope dap commands" },
	{ "<leader>tdc", ":Telescope dap configurations" },
	{ "<leader>td", ":lua find_dotfiles()<CR>", desc = "Find Dotfiles" },
	{ "<leader>tg", ":Telescope git_files<CR>", desc = "Git Files" },
	{ "<leader>th", ":lua require('telescope.builtin').help_tags{}<CR>", desc = "[T]elescope [H]elp" },
	{ "<leader>tk", ":Telescope keymaps<CR>", desc = "Keymaps" },
	{ "<leader>tk", ":Telescope Keymaps<CR>", desc = "Search Keymaps" },
	{ "<leader>tn", ":Telescope notify<CR>", desc = "Notifications" },
	{ "<leader>to", ":Telescope oldfiles<CR>", desc = "Recent(oldfiles) Files" },
	{ "<leader>tr", ":Telescope resume<CR>", desc = "Telescope Resume" },
	{ "<leader>ts", ":lua live_grep(scopes.get_current_dirs())<CR>", desc = "Search in CWD" },
}

if use_google() then
	TableConcat(keys, {
		{ "<leader>tm", ":lua find_files(fig_modified())<CR>" },
		{ "<leader>tM", ":lua find_files(fig_all_modified())<CR>" },
		{ "<leader>tF", ":lua live_grep(fig_all_modified())<CR>", desc = "Search in *all* modified Fig files." },
		{ "<leader>tf", ":lua live_grep(fig_modified())<CR>", desc = "Search in modified Fig files." },
		{ "<C-P>", [[<cmd>lua require('telescope').extensions.codesearch.find_files{}<CR>]], "n" },
		{ "<leader>cs", [[<cmd>lua require('telescope').extensions.codesearch.find_query{}<CR>]] },
		{ "<leader>cs", [[<cmd>lua require('telescope').extensions.codesearch.find_query{}<CR>]], mode = "v" },
		{
			"<leader>CS",
			[[<cmd>lua require('telescope').extensions.codesearch.find_query{default_text_expand='<cword>'}<CR>]],
		},
	})
end

return {
	{
		"aznhe21/actions-preview.nvim",
		config = function()
			require("actions-preview").setup({
				telescope = {
					sorting_strategy = "ascending",
					layout_strategy = "vertical",
					layout_config = {
						width = 0.8,
						height = 0.9,
						prompt_position = "top",
						preview_cutoff = 20,
						preview_height = function(_, _, max_lines)
							return max_lines - 15
						end,
					},
				},
			})
		end,
		keys = {
			{ "?", "<cmd>lua require('actions-preview').code_actions()<cr>" },
		},
	},
	{
		"piersolenski/telescope-import.nvim",
		dependencies = "nvim-telescope/telescope.nvim",
		config = function()
			require("telescope").load_extension("import")
		end,
		keys = function()
			if not use_google() then
				return {
					{ "<leader>i", ":Telescope import<CR>" },
				}
			end
		end,
	},
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"mfussenegger/nvim-dap",
			"rcarriga/nvim-dap-ui",
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
				},
				extensions = {
					codesearch = {
						experimental = true, -- enable results from google3/experimental
					},
					persisted = {},
					import = {
						-- Add imports to the top of the file keeping the cursor in place
						insert_at_top = true,
					},
				},
			})
		end,
		keys = keys,
	},
}
