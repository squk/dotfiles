local use_google = require("utils").use_google

if not use_google() then
	return {}
end

vim.opt.rtp:append("/google/src/head/depot/google3/experimental/users/fentanes/nvgoog")

-- local glug = require("nvgoog.google.util.glug").glug
-- local glugOpts = require("nvgoog.google.util.glug").glugOpts
local glug = require("glug").glug
local glugOpts = require("glug").glugOpts
local veryLazy = require("nvgoog.util").veryLazy

return {
	{ url = "sso://user/fentanes/nvgoog" },
	-- Prevent long sessions from losing cwd
	-- Load google paths like //google/* with `gf`
	{ import = "nvgoog.google.misc" },
	-- maktaba is required by all google plugins
	glug("maktaba", {
		lazy = true,
		dependencies = {},
		config = function() -- init?
			vim.cmd("source /usr/share/vim/google/glug/bootstrap.vim")
		end,
	}),
	glug("core"),
	glug("glaive"),
	glug("alert"),
	glug("csearch"),
	glug("languages"),
	-- glug("googlestyle"),
	glug("googlespell"),
	-- Enable logmsgs ASAP to avoid maktaba's log message queue filling up
	glug("logmsgs", {
		event = "VeryLazy",
	}),
	glug("googler", {
		event = "VeryLazy",
	}),
	-- Add support for google filetypes
	glug("google-filetypes", {
		event = "BufReadPre",
	}),
	-- Set up syntax, indent, and core settings for various filetypes
	veryLazy(glug("ft-cel")),
	veryLazy(glug("ft-clif")),
	veryLazy(glug("ft-cpp")),
	veryLazy(glug("ft-gin")),
	veryLazy(glug("ft-go")),
	veryLazy(glug("ft-java")),
	veryLazy(glug("ft-javascript")),
	veryLazy(glug("ft-kotlin")),
	veryLazy(glug("ft-proto")),
	veryLazy(glug("ft-python")),
	veryLazy(glug("ft-soy")),
	-- Configures nvim to respect Google's coding style
	veryLazy(glug("googlestyle")),
	-- Autogens boilerplate when creating new files
	glug("autogen", {
		event = "BufNewFile",
	}),
	-- Adds G4 support to the vcscommand plugin
	glug("googlepaths"),
	glug("ft-soy"),
	glug("ft-gss"),
	glug("ft-proto"),
	glug("g4"),
	glug("outline-window"),
	glug("fzf-query"),
	-- Open current file in chrome
	glug("corpweb", {
		dependencies = {
			glug("launchbrowser"),
		},
		cmd = {
			-- Launches {query} under codesearch in a web browser
			"CorpWebCs",
			-- Launches the current file under codesearch in a web browser
			"CorpWebCsFile",
			-- Launches the current file doc view (i.e., Cantata, G3Docs, or godoc)
			"CorpWebDocFindFile",
			-- Launches the current CL in Critique
			"CorpWebCritiqueCl",
			-- Launches the current CL in Cider
			"CorpWebCider",
			-- Launches {query} under cs.chromium.org in a web browser
			"CorpWebChromeCs",
		},
	}),
	glug("relatedfiles", {
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
	}),
	{ "junegunn/fzf", dir = "~/.fzf", build = "./install --all" },
	{ "junegunn/fzf.vim", dependencies = { "junegunn/fzf" } },
	-- Format google code
	glug("codefmt-google", {
		dependencies = {
			glug("codefmt", {
				-- TODO: remove prettier when http://cl/549024543 is submitted and deployed
				--    - remove prettier from the plugin options
				--    - set js/ts to use prettier instead of clang-format
				--      autocmd FileType javascript,typescript,javascriptreact,typescriptreact,css,scss,html,json AutoFormatBuffer prettier
				opts = {
					clang_format_executable = "/usr/bin/clang-format",
					clang_format_style = "function('codefmtgoogle#GetClangFormatStyle')",
					gofmt_executable = "/usr/lib/google-golang/bin/gofmt",
					prettier_executable = "/google/data/ro/teams/prettier/prettier",
					ktfmt_executable = { "/google/bin/releases/kotlin-google-eng/ktfmt/ktfmt", "--google-style" },
					auto_format = {
						["borg"] = "gclfmt",
						["gcl"] = "gclfmt",
						["patchpanel"] = "gclfmt",
						["bzl"] = "buildifier",
						["c"] = "clang-format",
						["cpp"] = "clang-format",
						["javascript"] = "clang-format",
						["typescript"] = "clang-format",
						["dart"] = "dartfmt",
						["go"] = "gofmt",
						["java"] = "google-java-format",
						["kotlin"] = "ktfmt",
						["jslayout"] = "jslfmt",
						["markdown"] = "mdformat",
						["ncl"] = "nclfmt",
						["python,piccolo"] = "pyformat",
						["soy"] = "soyfmt",
						["textpb"] = "text-proto-format",
						["proto"] = "protofmt",
						["sql"] = "format_sql",
					},
				},
			}),
		},
		cmd = { "FormatLines", "FormatCode", "AutoFormatBuffer" },
		event = "BufWritePre",
		-- Setting up autocmds in init allows deferring loading the plugin until
		-- the `BufWritePre` event. One caveat is we must call `codefmt#FormatBuffer()`
		-- manually the first time since the plugin relies on the `BufWritePre` command to call it,
		-- but by the time it's first loaded it has already happened.
		-- TODO: check if that is fixed when the following issue is fixed
		-- https://github.com/folke/lazy.nvim/issues/858
		-- if so, remove the call to `FormatBuffer`
		init = function(plugin)
			local group = vim.api.nvim_create_augroup("autoformat_settings", {})
			local function autocmd(filetypes, formatter)
				vim.api.nvim_create_autocmd("FileType", {
					pattern = filetypes,
					group = group,
					callback = function(event)
						vim.api.nvim_create_autocmd("BufWritePre", {
							buffer = event.buf,
							group = group,
							once = true,
							command = "call codefmt#FormatBuffer() | AutoFormatBuffer " .. formatter,
						})
					end,
				})
			end
			-- Build opts from possible parent specs since lazy.nvim doesn't provide it in `init`
			local plugin_opts = {}
			local curr_plugin = plugin
			while curr_plugin do
				if type(curr_plugin.opts) == "table" then
					plugin_opts = require("lazy.core.util").merge(curr_plugin.opts, plugin_opts)
				elseif type(curr_plugin.opts) == "function" then
					plugin_opts = curr_plugin.opts(plugin, plugin_opts)
				end
				curr_plugin = curr_plugin._ and curr_plugin._.super or nil
			end
			for filetypes, formatter in pairs(plugin_opts.auto_format or {}) do
				autocmd(filetypes, formatter)
			end
		end,
	}),

	-- Run blaze commands
	glug("blaze", {
		dependencies = {
			glug("blazedeps"),
		},
		cmd = {
			"Blaze",
			"BlazeGoToSponge",
			"BlazeViewCommandLog",
			"BlazeLoadErrors",
			"BlazeDebugCurrentFileTest",
			"BlazeDebugCurrentTestMethod",
			"BlazeDebugAddBreakpoint",
			"BlazeDebugClearBreakpoint",
			"BlazeDebugFinish",
			"BlazeDepsUpdate",
		},
		config = function()
			require("config.blaze")
		end,
		keys = function()
			local function runCmd(cmd)
				return function()
					vim.g._calling_blaze_cmd = 1
					vim.cmd(cmd)
					-- Clear the "blaze: SUCCESS" that blaze.vim will print
					if vim.g._call_blaze_query then
						print("")
					end
					vim.g._calling_blaze_cmd = 0
				end
			end
			return {
				{ "<leader>b", desc = "Blaze" },
				{ "<leader>bt", ":call BlazeTest()<CR>", desc = "Blaze Test" },
				{ "<leader>bb", ":call BlazeBuild()<CR>", desc = "Blaze Build" },
				{ "<leader>br", ":call BlazeRun()<CR>", desc = "Blaze Run" },
				{
					"<leader>yb",
					":let t = join(blaze#GetTargets(), ' ') | echo t | let @+ = t <CR>",
					desc = "Yank Blaze Target",
				},
				{ "<leader>bf", runCmd("call blaze#TestCurrentFile()"), desc = "Blaze test current file" },
				{ "<leader>bm", runCmd("call blaze#TestCurrentMethod()"), desc = "Blaze test current method" },
				{ "<leader>bd", desc = "Blaze debug" },
				{ "<leader>bdf", runCmd("BlazeDebugCurrentFileTest"), desc = "Blaze debug current file" },
				{ "<leader>bdm", runCmd("BlazeDebugCurrentTestMethod"), desc = "Blaze debug current method" },
				{ "<leader>bda", runCmd("BlazeDebugAddBreakpoint"), desc = "Blaze debug add breakpoint" },
				{ "<leader>bdc", runCmd("BlazeDebugClearBreakpoint"), desc = "Blaze debug clear breakpoint" },
				{ "<leader>bdf", runCmd("BlazeDebugFinish"), desc = "Blaze debug finish" },
				{ "<leader>bu", runCmd("BlazeDepsUpdate"), desc = "Blaze update dependencies" },
			}
		end,
	}),
	-- Imports
	glug("imp-google", {
		dependencies = {
			glugOpts("vim-imp", {
				"flwyd/vim-imp",
				opts = {
					["Suggest[default]"] = { "buffer", "csearch", "ripgrep", "prompt" },
					["Report[default]"] = "popupnotify",
					["Location[default]"] = "packageroot",
					-- ["Location[gcl]"] = "parent",
					["Pick[default]"] = "fzf",
				},
			}),
		},
		cmd = { "ImpSuggest", "ImpFirst" },
		keys = {
			{ "<leader>i", ":ImpSuggest <C-r><C-w><cr>" },
		},
	}),
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
	-- {
	--     name = "nvim_figtree",
	--     url = "sso://googler@user/jackcogdill/nvim-figtree",
	-- },
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
			"runiq/neovim-throttle-debounce",
		},
		config = function()
			-- Here are all the options and their default values:
			require("critique.comments").setup({
				-- Fetch the comments after calling `setup`.
				auto_fetch = true,
				display = {
					render_resolved_threads = true,
				},
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
