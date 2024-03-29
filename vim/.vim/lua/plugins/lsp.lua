local use_google = require("utils").use_google

local deps = {
	"hrsh7th/nvim-cmp",
	"nvim-lua/lsp-status.nvim",
	"VonHeikemen/lsp-zero.nvim",
	"ray-x/go.nvim",
	"ray-x/guihua.lua",
}

return {
	{
		"luozhiya/lsp-virtual-improved.nvim",
		event = { "LspAttach" },
		config = function()
			require("lsp-virtual-improved").setup()
		end,
	},
	{
		"kosayoda/nvim-lightbulb",
		opts = {
			autocmd = { enabled = true },
			virtual_text = {
				enabled = true,
				text = " 󱐋",
				hl = "DiagnosticWarn",
			},
			sign = { enabled = false },
		},
	},
	{
		"L3MON4D3/LuaSnip",
		build = "make install_jsregexp",
		config = function()
			require("luasnip.loaders.from_vscode").lazy_load()
		end,
		dependencies = { "rafamadriz/friendly-snippets" },
	},
	{
		"hinell/lsp-timeout.nvim",
		dependencies = { "neovim/nvim-lspconfig" },
		cond = not use_google(),
		config = function()
			vim.g.lspTimeoutConfig = {
				filetypes = {
					ignore = { -- filetypes to ignore; empty by default
						"gdscript",
						"rust",
					}, -- for these filetypes
				},
			}
		end,
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = deps,
		keys = {
			{ "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>" },
			-- { "?", "<cmd>lua vim.lsp.buf.code_action()<CR>" },
			{ "L", "<cmd>lua vim.lsp.buf.hover()<CR>" },
			{ "g0", "<cmd>lua vim.lsp.buf.document_symbol()<CR>" },
			{ "gr", "<Cmd>Telescope lsp_references<CR>" },
			{ "gW", "<cmd>lua vim.lsp.buf.workspace_symbol()<CR>" },
			{ "gd", "<cmd>lua vim.lsp.buf.definition()<CR>" },
			{ "gD", "<cmd>tab split | lua vim.lsp.buf.definition()<CR>" },
			{ "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>" },
			{ "gI", "<cmd>lua vim.lsp.buf.implementation()<CR>" },
			{ "gR", "<cmd>lua vim.lsp.buf.references()<CR>" },
			{ "<C-g>", "<cmd>lua vim.lsp.buf.signature_help()<CR>" },
			{ "gt", "<cmd>lua vim.lsp.buf.type_definition()<CR>" },
			{ "<C-g>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", mode = "i" },
			{ "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", mode = "v" },
		},
		config = function()
			local lsp_status = require("lsp-status")
			lsp_status.register_progress()

			vim.opt.spell = true
			vim.opt.spelllang = { "en_us" }

			local capabilities =
				require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
			capabilities = vim.tbl_extend("keep", capabilities or {}, lsp_status.capabilities)

			local lspconfig = require("lspconfig")
			local configs = require("lspconfig.configs")
			require("config.lsp-google").setup(capabilities)

			-- Godot
			lspconfig.gdscript.setup({
				-- flags = {
				-- 	debounce_text_changes = 2000, -- Wait 5 seconds before sending didChange
				-- },
			})
			vim.cmd([[autocmd FileType gdscript setlocal commentstring=#\ %s]])
			vim.cmd([[autocmd FileType gdscript setlocal autoindent noexpandtab tabstop=4 shiftwidth=4]])

			-- Golang
			require("go").setup({
				lsp_cfg = {
					capabilities = capabilities,
				},
			})
			local format_sync_grp = vim.api.nvim_create_augroup("GoFormat", {})
			vim.api.nvim_create_autocmd("BufWritePre", {
				pattern = "*.go",
				callback = function()
					require("go.format").goimport()
				end,
				group = format_sync_grp,
			})
		end,
	},
}
