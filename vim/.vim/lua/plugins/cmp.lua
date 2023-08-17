local use_google = require("utils").use_google
local tprint = require("utils").tprint
local dump = require("utils").dump
local log = require("utils").log

local has_words_before = function()
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

return {
	{
		"tzachar/cmp-tabnine",
		build = "./install.sh",
		event = "InsertEnter",
		cond = not use_google(),
		dependencies = {
			"onsails/lspkind.nvim",
			"hrsh7th/nvim-cmp",
		},
	},
	{
		"hrsh7th/nvim-cmp",
		event = "VimEnter",
		dependencies = {
			"f3fora/cmp-spell",
			"hrsh7th/cmp-buffer",
			"amarakon/nvim-cmp-buffer-lines",
			"hrsh7th/cmp-calc",
			"onsails/lspkind.nvim",
			"hrsh7th/cmp-cmdline",
			"hrsh7th/cmp-emoji",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-nvim-lsp-document-symbol",
			"hrsh7th/cmp-nvim-lsp-signature-help",
			"hrsh7th/cmp-nvim-lua",
			"FelipeLema/cmp-async-path",
			"lukas-reineke/cmp-under-comparator",
			"ray-x/cmp-treesitter",
		},
		config = function()
			vim.opt.shortmess:append("c")
			vim.opt.completeopt = { "menu", "menuone", "noselect" }

			local cmp = require("cmp")

			local conditionalSources = cmp.config.sources({
				{ name = "nvim_lsp", priority = 8 },
				{ name = "treesitter", priority = 7 },
				{ name = "nvim_lsp_signature_help" },
				{ name = "luasnip" },
				{ name = "calc" },
				{ name = "crates" },
				{ name = "nvim_lua" },
				{ name = "emoji" },
				{ name = "async_path" },
				{ name = "spell" },
				{ name = "buffer", option = { keyword_pattern = [[\k\+]] }, priority = 1 },
				-- { name = "buffer-lines" },
			})

			if use_google() then
				require("cmp_nvim_ciderlsp").setup()
				table.insert(conditionalSources, { name = "analysislsp", priority = 5 })
				table.insert(conditionalSources, { name = "nvim_ciderlsp", priority = 9 })
			else
				table.insert(conditionalSources, { name = "cmp_tabnine", priority = 9 })
			end

			local lspkind = require("lspkind")
			lspkind.init()

			-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
			cmp.setup.cmdline({ "/", "?" }, {
				mapping = cmp.mapping.preset.cmdline(),
				sources = cmp.config.sources({
					{ name = "nvim_lsp_document_symbol", priority = 3 },
					{ name = "treesitter", priority = 2 },
					{ name = "buffer", option = { keyword_pattern = [[\k\+]] }, priority = 1 },
				}),
			})

			-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
			cmp.setup.cmdline(":", {
				mapping = cmp.mapping.preset.cmdline(),
				sources = cmp.config.sources({
					{ name = "async_path", priority = 9 },
					-- { name = "treesitter", priority = 7 },
					{ name = "cmdline", priority = 8 },
				}),
			})

			cmp.setup({
				mapping = {
					["<C-d>"] = cmp.mapping.scroll_docs(-4),
					["<C-u>"] = cmp.mapping.scroll_docs(4),
					["<C-e>"] = cmp.mapping.close(),
					["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
					["<CR>"] = cmp.mapping.confirm({ select = true }),
					["<Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
						elseif has_words_before() then
							cmp.complete()
						else
							fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
						end
					end, { "i", "s" }),

					["<S-Tab>"] = cmp.mapping(function()
						if cmp.visible() then
							cmp.select_prev_item()
						end
					end, { "i", "s" }),

					["<Up>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						else
							fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
						end
					end),

					["<Down>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
						else
							fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
						end
					end),
				},

				preselect = cmp.PreselectMode.None,
				sources = conditionalSources,

				sorting = {
					comparators = {
						cmp.config.compare.priority,
						cmp.config.compare.offset,
						cmp.config.compare.exact,
						cmp.config.compare.score,
						require("cmp-under-comparator").under,
						cmp.config.compare.kind,
						cmp.config.compare.sort_text,
						cmp.config.compare.length,
						cmp.config.compare.order,
					},
				},

				snippet = {
					expand = function(args)
						require("luasnip").lsp_expand(args.body)
					end,
				},

				formatting = {
					format = lspkind.cmp_format({
						-- mode = "symbol_text",
						-- maxwidth = 50, -- half max width
						menu = {
							nvim_ciderlsp = "",
							buffer = "",
							crates = "",
							nvim_lsp = "[LSP]",
							nvim_lua = "",
							luasnip = "[LuaSnip]",
							cmp_tabnine = "[TabNine]",
							async_path = "[async_path]",
							tmux = "[TMUX]",
						},
					}),
				},
				experimental = {
					native_menu = false,
					ghost_text = true,
				},
			})
		end,
	},
}
