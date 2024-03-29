local use_google = require("utils").use_google

local function compare_by_ciderlsp_score(entry1, entry2)
	if entry1.completion_item.score ~= nil and entry2.completion_item.score ~= nil then
		print("LSP score " .. entry1.completion_item.score)
		print("LSP score " .. entry2.completion_item.score)
		return entry1.completion_item.score > entry2.completion_item.score
	end
end

local has_words_before = function()
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

return {
	{
		"hrsh7th/nvim-cmp",
		event = { "InsertEnter", "CmdlineEnter" },
		dependencies = {
			"Exafunction/codeium.nvim",
			"FelipeLema/cmp-async-path",
			"amarakon/nvim-cmp-buffer-lines",
			"chrisgrieser/cmp-nerdfont",
			"dmitmel/cmp-cmdline-history",
			"f3fora/cmp-spell",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-calc",
			"hrsh7th/cmp-cmdline",
			"hrsh7th/cmp-emoji",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-nvim-lsp-document-symbol",
			"hrsh7th/cmp-nvim-lsp-signature-help",
			"hrsh7th/cmp-nvim-lua",
			"lukas-reineke/cmp-under-comparator",
			"onsails/lspkind.nvim",
			"ray-x/cmp-treesitter",
		},
		config = function()
			vim.opt.shortmess:append("c")
			vim.opt.completeopt = { "menu", "menuone", "noselect" }

			local cmp = require("cmp")
			local compare = cmp.config.compare

			local conditionalSources = {}

			if use_google() then
				table.insert(conditionalSources, { name = "nvim_ciderlsp", priority = 8 })
				table.insert(conditionalSources, { name = "analysislsp" })
				table.insert(conditionalSources, { name = "buganizer", option = { notifications_enabled = true } })
			else
				table.insert(conditionalSources, { name = "codeium", priority = 8 })
			end

			local lspkind = require("lspkind")
			lspkind.init()

			-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
			cmp.setup.cmdline({ "/", "?" }, {
				mapping = cmp.mapping.preset.cmdline(),
				sources = cmp.config.sources({
					{ name = "treesitter" },
				}),
			})

			-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
			cmp.setup.cmdline(":", {
				mapping = cmp.mapping.preset.cmdline(),
				sources = cmp.config.sources({
					{ name = "nvim_lsp_signature_help", priority = 9 },
					{ name = "async_path" },
					{ name = "cmdline", option = { ignore_cmds = { "edit", "write", "tabedit" } } },
				}),
			})

			cmp.setup({
				preselect = cmp.PreselectMode.None,
				sources = cmp.config.sources(
					require("utils").TableConcat(conditionalSources, {
						{ name = "nvim_lsp_signature_help", priority = 9 },
						-- Conditional sources injected here.
						{ name = "luasnip", priority = 7 },
						{ name = "nvim_lsp", priority = 6 },
						{ name = "async_path" },
						{ name = "crates" },
						{ name = "calc" },
					}),
					{ -- symbols/icons group
						{ name = "nerdfont" },
						{ name = "emoji" },
					},
					{ -- fallback A
						{ name = "treesitter" },
					},
					{ -- fallback B
						{ name = "buffer" },
					}
				),

				sorting = {
					comparators = {
						-- compare.score_offset, -- not good at all
						compare.score, -- based on :  score = score + ((#sources - (source_index - 1)) * sorting.priority_weight)
						compare.locality,
						compare.recently_used,
						compare.offset,
						compare.order,
						-- compare.scopes, -- what?
						-- compare.sort_text,
						-- compare.exact,
						compare.kind,
						-- compare.length, -- useless
					},
				},
				formatting = {
					format = lspkind.cmp_format({
						menu = {
							async_path = " path",
							buffer = " Buf",
							cmdline = " cmd",
							codeium = "󰚩 Codeium",
							crates = " rust",
							luasnip = " snip",
							buganizer = " Buganizer",
							nerdfont = "󰊪 nerdfont",
							nvim_ciderlsp = "󰚩 Cider",
							analysislsp = "󰟌 analysislsp",
							nvim_lsp_signature_help = "󰊕",
							nvim_lsp = " LSP",
							nvim_lua = " lua",
							treesitter = "󰙅 ts",
						},
					}),
				},

				snippet = {
					expand = function(args)
						require("luasnip").lsp_expand(args.body)
					end,
				},

				experimental = {
					native_menu = false,
					ghost_text = true,
				},
				mapping = {
					["<S-Up>"] = cmp.mapping.scroll_docs(-4),
					["<S-Down>"] = cmp.mapping.scroll_docs(4),
					["<C-e>"] = cmp.mapping.close(),
					["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
					["<CR>"] = cmp.mapping.confirm({ select = true }),
					["<Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							if #cmp.get_entries() == 1 then
								cmp.confirm({ select = true })
							else
								cmp.select_next_item()
							end
						elseif has_words_before() then
							cmp.complete()
							if #cmp.get_entries() == 1 then
								cmp.confirm({ select = true })
							end
						else
							fallback()
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
			})
		end,
	},
}
