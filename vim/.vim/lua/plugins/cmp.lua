local use_google = require("utils").use_google

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
		"hrsh7th/nvim-cmp",
		event = "VimEnter",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"lukas-reineke/cmp-under-comparator",
			"hrsh7th/cmp-cmdline",
			"f3fora/cmp-spell",
			"hrsh7th/cmp-nvim-lsp-document-symbol",
			"hrsh7th/cmp-nvim-lsp-signature-help",
			"hrsh7th/cmp-nvim-lua",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-vsnip",
			"ray-x/cmp-treesitter",
		},
		config = function()
			local cmp = require("cmp")

			local conditionalSources = cmp.config.sources({
				{ name = "buffer", max_item_count = 5, keyword_length = 5, group_index = 2 },
				{ name = "crates" },
				{ name = "nvim_lsp" },
				{ name = "nvim_lsp_signature_help", priority = 5 },
				{ name = "nvim_lua" },
				{ name = "path" },
				{ name = "treesitter" },
				{ name = "vim_vsnip" },
				{
					name = "spell",
					option = {
						keep_all_entries = false,
						enable_in_context = function()
							return true
						end,
					},
				},
			})

			if use_google() then
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
						elseif vim.fn["vsnip#available"](1) == 1 then
							feedkey("<Plug>(vsnip-expand-or-jump)", "")
						elseif has_words_before() then
							cmp.complete()
						else
							fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
						end
					end, { "i", "s" }),

					["<S-Tab>"] = cmp.mapping(function()
						if cmp.visible() then
							cmp.select_prev_item()
						elseif vim.fn["vsnip#jumpable"](-1) == 1 then
							feedkey("<Plug>(vsnip-jump-prev)", "")
						end
					end, { "i", "s" }),

					["<Up>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						elseif vim.fn["vsnip#available"](1) == 1 then
							feedkey("<Plug>(vsnip-jump-prev)", "")
						else
							fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
						end
					end),

					["<Down>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
						elseif vim.fn["vsnip#available"](1) == 1 then
							feedkey("<Plug>(vsnip-expand-or-jump)", "")
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
					},
				},

				snippet = {
					expand = function(args)
						vim.fn["vsnip#anonymous"](args.body)
					end,
				},

				formatting = {
					format = lspkind.cmp_format({
						with_text = true,
						maxwidth = 40, -- half max width
						menu = {
							nvim_ciderlsp = "",
							buffer = "",
							crates = "",
							nvim_lsp = "",
							nvim_lua = "",
							cmp_tabnine = "[TabNine]",
							path = "[path]",
							tmux = "[TMUX]",
							vim_vsnip = "[snip]",
						},
					}),
				},

				experimental = {
					ghost_text = false,
				},
			})

			vim.cmd(
				[[ augroup CmpZsh au! autocmd Filetype zsh lua require'cmp'.setup.buffer { sources = { { name = "zsh" }, } } augroup END ]]
			)
		end,
	},
}
