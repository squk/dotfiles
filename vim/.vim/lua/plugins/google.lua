local use_google = require("utils").use_google

local function goog(plugin, config)
	return {
		name = plugin,
		dir = "/usr/share/vim/google/" .. plugin,
		dependencies = { "maktaba" },
		config = config,
	}
end

if not use_google() then
	return {}
end
return {
	{
		name = "maktaba",
		dir = "/usr/share/vim/google/maktaba",
		init = function()
			vim.cmd("source /usr/share/vim/google/glug/bootstrap.vim")
		end,
	},
	goog("core"),
	goog("glaive"),
	goog("alert"),
	goog("csearch"),
	goog("codefmt-google"),
	goog("languages"),
	goog("googlestyle"),
	goog("googlespell"),
	goog("googlepaths"),
	goog("google-filetypes"),
	goog("ft-java"),
	goog("ft-kotlin"),
	goog("ft-proto"),
	goog("critique"),
	goog("piper"),
	goog("gtimporter"),
	goog("blaze"),
	goog("buganizer"),
	goog("g4"),
	goog("outline-window"),
	goog("fzf-query"),
	{
		name = "relatedfiles",
		dir = "/usr/share/vim/google/relatedfiles",
		dependencies = { "glaive" },
		config = function()
			vim.cmd([[Glaive relatedfiles]])
		end,

		keys = {
			{
				"<leader>rb",
				":exec relatedfiles#selector#JumpToBuild()<CR>",
			},
			{
				"<leader>rt",
				":exec relatedfiles#selector#JumpToTestFile()<CR>",
			},
			{
				"<leader>rc",
				":exec relatedfiles#selector#JumpToCodeFile()<CR>",
			},
		},
	},
	{
		name = "codefmt",
		dir = "/usr/share/vim/google/codefmt",
		dependencies = { "glaive" },
		config = function()
			vim.cmd(
				[[Glaive codefmt ktfmt_executable=`["/google/bin/releases/kotlin-google-eng/ktfmt/ktfmt_deploy.jar", "--google-style"]`]]
			)
		end,
	},
	{
		name = "imp-google",
		dir = "/usr/share/vim/google/imp-google",
		dependencies = { "vim-imp", "glaive" },
		config = function()
			require("config.imp-google")
		end,
	},
	{
		"flwyd/vim-imp",
		dependencies = { "imp-google" },
		keys = {
			{ "<leader>ii", ":ImpSuggest <C-r><C-w><cr>" },
		},
	},
	{
		name = "ai.nvim",
		url = "sso://googler@user/vvvv/ai.nvim",
	},
	{
		name = "cmp-nvim-ciderlsp",
		url = "sso://googler@user/piloto/cmp-nvim-ciderlsp",
		event = "VimEnter",
		dependencies = {
			"hrsh7th/nvim-cmp",
		},
	},
	{
		name = "ciderlsp-nvim",
		url = "sso://googler@user/kdark/ciderlsp-nvim",
		event = "VimEnter",
		dependencies = {
			"hrsh7th/nvim-cmp",
		},
	},
	{
		name = "nvim_figtree",
		url = "sso://googler@user/jackcogdill/nvim-figtree",
	},
	{
		name = "telescope_codesearch",
		url = "sso://googler@user/vintharas/telescope-codesearch.nvim",
		dependencies = { "nvim-telescope/telescope.nvim" },
	},
	{
		name = "telescope_citc",
		url = "sso://googler@user/aktau/telescope-citc.nvim",
		dependencies = { "nvim-telescope/telescope.nvim" },
	},
	{
		name = "telescope_fig",
		url = "sso://googler@user/tylersaunders/telescope-fig.nvim",
		dependencies = { "nvim-telescope/telescope.nvim" },
	},
	{
		name = "google_comments",
		-- url = "sso://googler@user/chmnchiang/google-comments",
		dir = "/google/src/cloud/cnieves/google-comments/google3/experimental/users/chmnchiang/neovim/google-comments/",
		dependencies = { "rcarriga/nvim-notify", "nvim-lua/plenary.nvim" },
		config = function()
			-- Here are all the options and their default values:
			require("google.comments").setup({
				-- command = {'/google/bin/releases/editor-devtools/get_comments.par', '--full', '--json', "-x=''"},
				stubby = true,
				-- command = {
				--     "/google/bin/releases/editor-devtools/get_comments.par",
				--     "--json",
				--     "--full",
				--     "--noresolved",
				--     "--cl_comments",
				--     "--file_comments",
				-- },
				command = {
					'stubby --output_json call blade:codereview-rpc CodereviewRpcService.GetComments "changelist_number: $(/google/data/ro/teams/fig/bin/vcstool pending-change-number)"',
				},
				-- Define your own icon by `vim.fn.sign_define('ICON_NAME', {text = ' '})`.
				-- See :help sign_define
				-- The sign property passed to setup should be the 'ICON_NAME' in the define
				-- example above.
				sign = "COMMENT_ICON",
				-- Fetch the comments after calling `setup`.
				auto_fetch = true,
				display = {
					-- CTN
					virtual_text = true,
					-- The width of the comment display window.
					width = 50,
					-- When showing file paths, use relative paths or not.
					relative_path = true,
					--- Enable viewing comments through floating window
					floating = true,
					--- Options used when creating the floating window.
					floating_window_options = floating_window_options,
				},
			})

			function floating_window_options(parent_win_id)
				local parent_width = vim.api.nvim_win_get_width(parent_win_id)
				local parent_height = vim.api.nvim_win_get_height(parent_win_id)

				return {
					relative = "win",
					anchor = "NW",
					width = math.floor(parent_width * 0.5),
					height = math.floor(parent_height * 0.3),
					row = vim.api.nvim_win_get_cursor(parent_win_id)[1],
					col = math.floor(parent_width * 0.25),
					border = "rounded",
				}
			end

			local map = require("utils").map
			-- here are some mappings you might want:
			map("n", "]c", [[<Cmd>GoogleCommentsGotoNextComment<CR>]])
			map("n", "[c", [[<Cmd>GoogleCommentsGotoPrevComment<CR>]])

			map("n", "<Leader>nc", [[<Cmd>GoogleCommentsGotoNextComment<CR>]])
			map("n", "<Leader>pc", [[<Cmd>GoogleCommentsGotoPrevComment<CR>]])
			map("n", "<Leader>lc", [[<Cmd>GoogleCommentsToggleLineComments<CR>]])
			map("n", "<Leader>ac", [[<Cmd>GoogleCommentsToggleAllComments<CR>]])
			map("n", "<Leader>fc", [[<Cmd>GoogleCommentsFetchComments<CR>]])

			vim.fn.sign_define("COMMENT_ICON", { text = "" })
		end,
	},
	{
		url = "sso://googler@user/mccloskeybr/luasnip-google.nvim",
		config = function()
			require("luasnip-google").load_snippets()
		end,
	},
	{
		name = "hg",
		url = "sso://googler@user/smwang/hg.nvim",
		dependencies = { "ipod825/libp.nvim" },
		config = function()
			require("config.fig")
			require("hg").setup()
		end,
	},
}
