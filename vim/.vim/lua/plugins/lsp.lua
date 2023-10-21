local use_google = require("utils").use_google

local deps = {
	"hrsh7th/nvim-cmp",
	"nvim-lua/lsp-status.nvim",
	"VonHeikemen/lsp-zero.nvim",
	"rcarriga/nvim-notify",
	"ray-x/go.nvim",
	"ray-x/guihua.lua",
}

if not use_google() then
	table.insert(deps, "Exafunction/codeium.nvim")
end

return {
	{
		"neovim/nvim-lspconfig",
		dependencies = deps,
		keys = {
			{ "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>" },
			{ "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>" },
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
			capabilities["codeLens"] = { dynamicRegistration = false }
			capabilities.textDocument.publishDiagnostics = {
				relatedInformation = true,
				versionSupport = false,
				tagSupport = {
					valueSet = {
						1,
						2,
					},
				},
				codeDescriptionSupport = true,
				dataSupport = true,
				-- layeredDiagnostics = true,
			}

			capabilities = vim.tbl_extend("keep", capabilities or {}, lsp_status.capabilities)

			require("config.lsp-google").setup(capabilities)

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
