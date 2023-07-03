local use_google = require("utils").use_google
local tprint = require("utils").tprint
local dump = require("utils").dump
local log = require("utils").log

local has_words_before = function()
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local feedkey = function(key, mode)
	vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
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
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = function()
			local autopairs = require("nvim-autopairs")

			autopairs.setup({
				check_ts = true, -- treesitter integration
				disable_filetype = { "TelescopePrompt" },
			})

			local cmp_autopairs = require("nvim-autopairs.completion.cmp")
			local cmp_status_ok, cmp = pcall(require, "cmp")
			if not cmp_status_ok then
				return
			end
			cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done({}))
		end,
	},
	{
		"hrsh7th/nvim-cmp",
		event = "VimEnter",
		dependencies = {
			"f3fora/cmp-spell",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-calc",
			"hrsh7th/cmp-cmdline",
			"hrsh7th/cmp-emoji",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-nvim-lsp-document-symbol",
			"hrsh7th/cmp-nvim-lsp-signature-help",
			"hrsh7th/cmp-nvim-lua",
			"hrsh7th/cmp-path",
			"lukas-reineke/cmp-under-comparator",
			"ray-x/cmp-treesitter",
		},
		config = function()
			local cmp = require("cmp")

			local conditionalSources = cmp.config.sources({
				{ name = "nvim_lsp", priority = 6 },
				{ name = "nvim_lsp_signature_help", priority = 7 },
				{ name = "luasnip", priority = 8 },
				{ name = "calc" },
				{ name = "crates" },
				{ name = "nvim_lua" },
				{ name = "emoji" },
				{ name = "path" },
				{ name = "treesitter" },
				{
					name = "spell",
					option = {
						keep_all_entries = false,
						enable_in_context = function()
							return true
						end,
					},
				},
				{ name = "buffer", max_item_count = 5, keyword_length = 5 },
			})

			if use_google() then
				require("cmp_nvim_ciderlsp").setup()
				table.insert(conditionalSources, { name = "analysislsp" })
				table.insert(conditionalSources, { name = "nvim_ciderlsp", priority = 9 })
			else
				table.insert(conditionalSources, { name = "cmp_tabnine" })
			end

			local lspkind = require("lspkind")
			lspkind.init()

			-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
			cmp.setup.cmdline({ "/", "?" }, {
				mapping = cmp.mapping.preset.cmdline(),
				sources = cmp.config.sources({
					{ name = "nvim_lsp_document_symbol" },
					{ name = "buffer", max_item_count = 5 },
				}),
			})

			-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
			cmp.setup.cmdline(":", {
				mapping = cmp.mapping.preset.cmdline(),
				sources = cmp.config.sources({
					{ name = "nvim_lsp_document_symbol" },
					{ name = "path" },
					{ name = "cmdline" },
				}),
			})

			cmp.setup({
				mapping = {
					["<C-d>"] = cmp.mapping.scroll_docs(-4),
					["<C-u>"] = cmp.mapping.scroll_docs(4),
					["<C-e>"] = cmp.mapping.close(),
					["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
					["<C-m>"] = cmp.mapping.confirm({ select = true }),
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

				sources = conditionalSources,

				sorting = {
					comparators = {
						cmp.config.compare.offset,
						cmp.config.compare.exact,
						cmp.config.compare.score,
						require("cmp-under-comparator").under,
						cmp.config.compare.kind,
						cmp.config.compare.sort_text,
						cmp.config.compare.length,
						cmp.config.compare.order,
						cmp.config.compare.priority,
					},
				},

				snippet = {
					expand = function(args)
						require("luasnip").lsp_expand(args.body)
					end,
				},

				formatting = {
					format = lspkind.cmp_format({
						mode = "symbol_text",
						-- before = function(entry, vim_item)
						--     if entry.source.name == "nvim_ciderlsp" then
						--         if entry.completion_item.is_multiline then
						--             -- multi-line specific formatting here
						--             vim_item.menu = "  "
						--         else
						--             vim_item.menu = ""
						--         end
						--     end
						--     return vim_item
						-- end,
						maxwidth = 40, -- half max width
						menu = {
							nvim_ciderlsp = "",
							buffer = "",
							crates = "",
							nvim_lsp = "[LSP]",
							nvim_lua = "",
							luasnip = "[LuaSnip]",
							cmp_tabnine = "[TabNine]",
							path = "[path]",
							tmux = "[TMUX]",
						},
					}),
				},

				experimental = {
					ghost_text = true,
				},
			})
		end,
	},
}