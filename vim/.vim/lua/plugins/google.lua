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
	goog("ft-soy"),
	goog("ft-gss"),
	goog("ft-javascript"),
	goog("ft-kotlin"),
	goog("ft-proto"),
	goog("google-logo"),
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
			{ "<leader>i", ":ImpSuggest <C-r><C-w><cr>" },
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
		name = "critique_nvim",
		dir = "/google/src/cloud/cnieves/google-comments/google3/experimental/users/cnieves/neovim/critique-nvim/",
		dependencies = {
			"rktjmp/time-ago.vim",
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope.nvim",
		},
		config = function()
			-- Here are all the options and their default values:
			require("critique.comments").setup({
				-- Fetch the comments after calling `setup`.
				auto_fetch = true,
				render_resolved_threads = true,
			})
			local map = require("utils").map
			-- here are some mappings you might want:
			map("n", "]c", [[<Cmd>CritiqueGotoNextComment<CR>]])
			map("n", "[c", [[<Cmd>CritiqueGotoPrevComment<CR>]])

			map("n", "<Leader>lc", [[<Cmd>CritiqueToggleLineComments<CR>]])
			map("n", "<Leader>ac", [[<Cmd>CritiqueToggleAllComments<CR>]])
			map("n", "<Leader>fc", [[<Cmd>CritiqueFetchComments<CR>]])
			map("n", "<Leader>tc", [[<Cmd>CritiqueCommentsTelescope<CR>]])
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
