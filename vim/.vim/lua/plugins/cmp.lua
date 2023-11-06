local use_google = require("utils").use_google
local tprint = require("utils").tprint
local dump = require("utils").dump
local log = require("utils").log

local function compare_by_ciderlsp_score(entry1, entry2)
	if entry1.completion_item.score ~= nil and entry2.completion_item.score ~= nil then
		return entry1.completion_item.score > entry2.completion_item.score
	end
end

local has_words_before = function()
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

return {
	{
		"Exafunction/codeium.vim",
		event = "InsertEnter",
		cond = not use_google(),
		dependencies = {
			"onsails/lspkind.nvim",
			"hrsh7th/nvim-cmp",
		},
		config = function()
			require("codeium").setup({})
		end,
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
			"dmitmel/cmp-cmdline-history",
			"hrsh7th/cmp-nvim-lua",
			"FelipeLema/cmp-async-path",
			"lukas-reineke/cmp-under-comparator",
			"ray-x/cmp-treesitter",
		},
		config = function()
			vim.opt.shortmess:append("c")
			vim.opt.completeopt = { "menu", "menuone", "noselect" }

			local cmp = require("cmp")

			local conditionalSources = {
				{ name = "nvim_lsp", max_item_count = 5, priority = 8 },
				{ name = "treesitter", max_item_count = 5, priority = 7 },
				{ name = "luasnip", max_item_count = 5, priority = 6 },
				{ name = "calc" },
				{ name = "async_path" },
				{ name = "crates" },
				{ name = "spell", max_item_count = 5 },
				{ name = "emoji", max_item_count = 10 },
			}

			if use_google() then
				table.insert(conditionalSources, { name = "nvim_ciderlsp", priority = 9 })
				table.insert(conditionalSources, { name = "analysislsp" })
			else
				table.insert(conditionalSources, { name = "codeium", priority = 9 })
			end

			local lspkind = require("lspkind")
			lspkind.init()

			-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
			cmp.setup.cmdline({ "/", "?" }, {
				mapping = cmp.mapping.preset.cmdline(),
				sources = cmp.config.sources({
					-- { name = "cmdline_history" },
					{ name = "nvim_lsp_document_symbol" },
					{ name = "treesitter", max_item_count = 10 },
					{ name = "buffer", option = { keyword_pattern = [[\k\+]] }, priority = 1, max_item_count = 5 },
				}),
			})

			-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
			cmp.setup.cmdline(":", {
				mapping = cmp.mapping.preset.cmdline(),
				sources = cmp.config.sources({
					{ name = "async_path" },
					-- { name = "cmdline_history" },
					-- { name = "treesitter", priority = 7 },
					{ name = "cmdline", option = { ignore_cmds = { "edit", "write" } } },
				}),
			})

			cmp.setup({
				mapping = {
					["<S-Up>"] = cmp.mapping.scroll_docs(-4),
					["<S-Down>"] = cmp.mapping.scroll_docs(4),
					["<C-e>"] = cmp.mapping.close(),
					["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
					["<CR>"] = cmp.mapping.confirm({ select = true }),
					["<Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
						-- elseif has_words_before() then
						--     cmp.complete()
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
				sources = cmp.config.sources(conditionalSources),

				sorting = {
					priority_weight = 2,
					comparators = {
						cmp.config.compare.priority,
						cmp.config.compare.score,
						compare_by_ciderlsp_score,
						cmp.config.compare.recently_used,
						cmp.config.compare.locality,
						cmp.config.compare.exact,
						require("cmp-under-comparator").under,
						cmp.config.compare.kind,
						cmp.config.compare.sort_text,
						-- cmp.config.compare.offset,
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
						menu = {
							nvim_ciderlsp = "󰧑 Cider",
							codiuem = "󰧑  Codeium",
							buffer = " Buf",
							crates = "",
							nvim_lsp = " LSP",
							nvim_lua = "",
							luasnip = " snip",
							async_path = " path",
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
