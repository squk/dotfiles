local use_google = require("utils").use_google
local flags = require("utils").flags

return {
	{
		"saghen/blink.compat",
		-- use the latest release, via version = '*', if you also use the latest release for blink.cmp
		version = "*",
		-- lazy.nvim will automatically load the plugin when it's required by blink.cmp
		lazy = true,
		-- make sure to set opts so that lazy.nvim calls blink.compat's setup
		opts = {
			impersonate_nvim_cmp = use_google(), -- only cider needs this
		},
		cond = not use_google(),
	},
	{
		"saghen/blink.cmp",
		lazy = false, -- lazy loading handled internally
		cond = flags.blink,
		dependencies = {
			"Exafunction/codeium.nvim",
			"mikavilpas/blink-ripgrep.nvim",
			"chrisgrieser/cmp-nerdfont",
			"hrsh7th/cmp-emoji",
			"rafamadriz/friendly-snippets", -- optional: provides snippets for the snippet source
		},
		version = "v0.*", -- use a release tag to download pre-built binaries
		-- build = 'cargo build --release',

		---@module 'blink.cmp'
		---@type blink.cmp.Config
		opts = {
			keymap = {
				["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
				["<C-e>"] = { "hide", "fallback" },
				["<CR>"] = { "accept", "fallback" },

				["<Tab>"] = { "select_next", "snippet_forward", "accept", "fallback" },
				["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },

				["<Up>"] = { "select_prev", "fallback" },
				["<Down>"] = { "select_next", "fallback" },

				["<S-Up>"] = { "scroll_documentation_up", "fallback" },
				["<S-Down>"] = { "scroll_documentation_down", "fallback" },
			},
			sources = {
				default = function(ctx)
					local providerToEnable = {
						"lsp",
						"path",
						"snippets",
						"ripgrep",
						"emoji",
						"nerdfont",
						"buffer",
					}
					if use_google() then
						table.insert(providerToEnable, "nvim_ciderlsp")
						table.insert(providerToEnable, "buganizer")
					else
						table.insert(providerToEnable, "codeium")
					end
					return providerToEnable
				end,
				providers = {
					-- dont show LuaLS require statements when lazydev has items
					lazydev = { name = "LazyDev", module = "lazydev.integrations.blink", fallbacks = { "lsp" } },
					ripgrep = {
						module = "blink-ripgrep",
						name = "Ripgrep",
						-- the options below are optional, some default values are shown
						---@module "blink-ripgrep"
						---@type blink-ripgrep.Options
						opts = {
							prefix_min_len = 3,
							context_size = 5,
							max_filesize = "1M",
							additional_rg_options = {},
						},
					},
					nvim_ciderlsp = {
						name = "nvim_ciderlsp",
						module = "blink.compat.source",
					},
					buganizer = {
						name = "nvim_buganizer",
						module = "blink.compat.source",
					},
					codeium = {
						name = "codeium",
						module = "blink.compat.source",
					},
					emoji = {
						name = "emoji",
						module = "blink.compat.source",
					},
					nerdfont = {
						name = "nerdfont",
						module = "blink.compat.source",
					},
				},
			},
			-- experimental signature help support
			signature = { enabled = true },
			completion = {
				menu = {
					draw = {
						components = {
							kind_icon = {
								ellipsis = false,
								text = function(ctx)
									local kind_icon, _, _ = require("mini.icons").get("lsp", ctx.kind)
									return kind_icon
								end,
								-- Optionally, you may also use the highlights from mini.icons
								highlight = function(ctx)
									local _, hl, _ = require("mini.icons").get("lsp", ctx.kind)
									return hl
								end,
							},
						},
					},
				},
				list = {
					selection = {
						preselect = function(ctx)
							return ctx.mode ~= "cmdline"
						end,
						auto_insert = function(ctx)
							return ctx.mode ~= "cmdline"
						end,
					},
				},
				trigger = {
					show_on_x_blocked_trigger_characters = { "'", '"', "(", "{" },
				},
			},
		},

		-- allows extending the providers array elsewhere in your config
		-- without having to redefine it
		opts_extend = { "sources.default" },
	},
}
