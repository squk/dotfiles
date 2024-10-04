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
	glug("logmsgs", {
		event = "VeryLazy",
	}),
	glug("googler", {
		event = "VeryLazy",
	}),
	glug("core"),
	glug("glaive"),
	glug("alert"),
	glug("csearch"),
	glug("languages"),
	glug("googlespell"),
	-- Enable logmsgs ASAP to avoid maktaba's log message queue filling up
	glug("google-logo"),
	-- Add support for google filetypes
	glug("google-filetypes", { event = { "BufReadPre", "BufNewFile" }, dependencies = {} }),

	-- Other filetype detection
	veryLazy(glug("ft-cel", { event = "BufRead,BufNewFile *.cel,*jvp" })),
	veryLazy(glug("ft-clif", { event = "BufRead,BufNewFile *.clif" })),
	veryLazy(glug("ft-gin", { event = "BufRead,BufNewFile *.gin" })),
	veryLazy(glug("ft-gss", { event = "BufRead,BufNewFile *.gss" })),
	veryLazy(glug("ft-proto", { event = "BufRead,BufNewFile *.proto,*.protodevel,*.rosy,*.textproto" })),
	veryLazy(glug("ft-soy", { event = "BufRead,BufNewFile *.soy" })),
	-- Set up syntax, indent, and core settings for various filetypes
	veryLazy(glug("ft-cpp", { event = "BufRead,BufNewFile *.[ch],*.cc,*.cpp" })),
	veryLazy(glug("ft-go", { event = "BufRead,BufNewFile *.go" })),
	veryLazy(glug("ft-java", { event = "BufRead,BufNewFile *.java" })),
	veryLazy(glug("ft-javascript", { event = "BufRead,BufNewFile *.js,*.jsx" })),
	veryLazy(glug("ft-kotlin", { event = "BufRead,BufNewFile *.kt,*.kts" })),
	veryLazy(glug("ft-python", { event = "BufRead,BufNewFile *.py" })),

	-- Configures nvim to respect Google's coding style
	-- glug("googlestyle", { event = { "BufRead", "BufNewFile" } }),

	veryLazy(glug("add_usings")),
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
  -- stylua: ignore
		keys = {
			{ "<leader>rb", ":exec relatedfiles#selector#JumpToBuild()<CR>" },
			{ "<leader>rt", ":exec relatedfiles#selector#JumpToTestFile()<CR>" },
			{ "<leader>rh", ":exec relatedfiles#selector#JumpToHeader()<CR>" },
			{ "<leader>rc", ":exec relatedfiles#selector#JumpToCodeFile()<CR>" },
		},
	}),
	{ "junegunn/fzf", dir = "~/.fzf", build = "./install --all" },
	{ "junegunn/fzf.vim", dependencies = { "junegunn/fzf" } },
	-- Format google code
	glug("codefmt-google", {
		dependencies = {
			glug("codefmt", {
				opts = {
					clang_format_executable = "/usr/bin/clang-format",
					clang_format_style = "function('codefmtgoogle#GetClangFormatStyle')",
					gofmt_executable = "/usr/lib/google-golang/bin/gofmt",
					prettier_executable = "/google/data/ro/teams/prettier/prettier",
					ktfmt_executable = { "/google/bin/releases/kotlin-google-eng/ktfmt/ktfmt", "--google-style" },
				},
			}),
		},
		opts = {
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
		cmd = { "FormatLines", "FormatCode", "AutoFormatBuffer" },
		event = "VimEnter",

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
			local plugin_opts = require("lazy.core.plugin").values(plugin, "opts", false)
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
			local function runCommandWithTarget(cmd)
				return function()
					local targets = table.concat(vim.fn["blaze#GetTargets"](), " ")
					local command = "VimuxRunCommand('" .. cmd .. " " .. targets .. "')"
					print(vim.inspect(command))
					vim.cmd(command)
				end
			end
			return {
				{ "<leader>b", desc = "Blaze" },
				{ "<leader>bb", runCommandWithTarget("blaze build"), desc = "Blaze Build" },
				{ "<leader>br", runCommandWithTarget("blaze run"), desc = "Blaze Run" },
				{ "<leader>bt", runCommandWithTarget("blaze test"), desc = "Blaze Test" },
				{ "<leader>bc", runCommandWithTarget("build_cleaner"), desc = "Blaze Run" },
				{
					"<leader>yb",
					":let t = join(blaze#GetTargets(), ' ') | echo t | let @+ = t | let @\" = t<CR>",
					desc = "Yank Blaze Target",
				},
				{
					"<leader>bq",
					function()
						local targets = vim.fn["blaze#GetTargets"]()
						for _, t in ipairs(targets) do
							print(vim.inspect(t))
							vim.cmd("VimuxRunCommand('blaze query " .. t:gsub(":.+", "") .. ":\\*" .. "')")
						end
					end,
					desc = "Blaze query the current package",
				},
			}
		end,
	}),
	-- Imports
	veryLazy(glug("imp-google", {
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
	})),
	{
		url = "sso://user/fentanes/googlepaths.nvim",
		event = { "VeryLazy", "BufReadCmd //*" },
		opts = {},
	},
	{
		name = "ai.nvim",
		url = "sso://googler@user/vvvv/ai.nvim",
	},
	{
		name = "cmp-nvim-ciderlsp",
		url = "sso://googler@user/sakal/cmp-nvim-ciderlsp",
		-- url = "sso://googler@user/piloto/cmp-nvim-ciderlsp",
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
		name = "critique-nvim",
		dir = "~/critique-nvim/",
		lazy = false,
		dependencies = {
			"rktjmp/time-ago.vim",
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope.nvim",
			"runiq/neovim-throttle-debounce",
		},
		-- here are some mappings you might want:
		keys = {
			{ "]c", ":CritiqueGotoNextComment<CR>" },
			{ "[c", ":CritiqueGotoPrevComment<CR>" },
			{ "<Leader>lc", ":CritiqueToggleLineComment<CR>" },
			{ "<Leader>uc", ":CritiqueToggleUnresolvedComments<CR>" },
			{ "<Leader>ac", ":CritiqueToggleAllComments<CR>" },
			{ "<Leader>fc", ":CritiqueFetchComments<CR>" },
			-- { "<Leader>tc", ":CritiqueCommentsTelescope<CR>" },
			-- { "<Leader>tc", ":CritiqueCommentsTelescope<CR>" },
		},
		config = function()
			-- Here are all the options and their default values:
			require("critique.comments").setup({
				-- debug = 1, -- default = 0
				-- Fetch the comments after calling `setup`.
				auto_fetch = true, -- default = true
				auto_render = true, -- default = true
				-- Allow checking for comments on BufEnter events. This is throttled to once every 10 seconds.
				frequent_fetch = true, -- default = false
				verbose_notifications = true,
			})
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
	{
		{
			"sakal/neoblaze.nvim",
			url = "sso://user/sakal/neoblaze.nvim",
			lazy = false, -- Can be disabled if you only use keybinds.
			keys = {
				{
					"<leader>B",
					desc = "Blaze",
				},
				{
					"<leader>Bb",
					function()
						require("neoblaze").build()
					end,
					desc = "Build",
				},
				{
					"<leader>Bt",
					function()
						require("neoblaze").test()
					end,
					desc = "Test",
				},
				{
					"<leader>Br",
					function()
						require("neoblaze").run()
					end,
					desc = "Run",
				},
				{
					"<leader>Bs",
					function()
						require("neoblaze").update_goldens()
					end,
					desc = "Update goldens",
				},
				{
					"<leader>BB",
					function()
						require("neoblaze").build({ blaze_exe = "iblaze" })
					end,
					desc = "Build (iblaze)",
				},
				{
					"<leader>BT",
					function()
						require("neoblaze").test({ blaze_exe = "iblaze" })
					end,
					desc = "Test (iblaze)",
				},
				{
					"<leader>BR",
					function()
						require("neoblaze").run({ blaze_exe = "iblaze" })
					end,
					desc = "Run (iblaze)",
				},
				{
					"<leader>Be",
					function()
						require("neoblaze").retry()
					end,
					desc = "Retry",
				},
				{
					"<leader>By",
					function()
						require("neoblaze").yank()
					end,
					desc = "Yank target to system clipboard",
				},
			},
		},
	},
}
