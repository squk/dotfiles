local use_google = require("utils").use_google
local M = {}

function M.setup(capabilities)
	if use_google() then
		local lspconfig = require("lspconfig")
		local configs = require("lspconfig.configs")
		configs.ciderlsp = {
			default_config = {
				offset_encoding = "utf-16",
				cmd = {
					"/google/bin/releases/cider/ciderlsp/ciderlsp",
					"--tooltag=nvim-lsp",
					"--forward_sync_responses",
					-- "--debug_relay",
				},
				filetypes = {
					"c",
					"cpp",
					"java",
					"kotlin",
					"objc",
					"proto",
					"textproto",
					"go",
					"python",
					"bzl",
					"typescript",
				},
				root_dir = require("lspconfig").util.root_pattern(".citc"),
				settings = {},
			},
		}

		local my_on_attach = function(client, bufnr)
			require("lualine").refresh()
			vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
			if vim.lsp.formatexpr then -- Neovim v0.6.0+ only.
				vim.api.nvim_buf_set_option(bufnr, "formatexpr", "v:lua.vim.lsp.formatexpr")
			end
			if vim.lsp.tagfunc then
				vim.api.nvim_buf_set_option(bufnr, "tagfunc", "v:lua.vim.lsp.tagfunc")
			end

			local lsp_status = require("lsp-status")
			lsp_status.on_attach(client)
		end

		local cider_on_attach = function(client, bufnr)
			my_on_attach(client, bufnr)
			vim.b["is_cider_lsp_attached"] = "no"
		end

		local cider_lsp_handlers = {
			["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
				focusable = false,
			}),
		}

		cider_lsp_handlers["$/syncResponse"] = function(_, result, ctx)
			local first_fire = vim.b["is_cider_lsp_attached"] == "no"
			vim.b["is_cider_lsp_attached"] = "yes"
			if first_fire then
				vim.notify("CiderLSP attached")
				require("lualine").refresh()
			end
		end

		lspconfig.ciderlsp.setup({
			capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities()),
			on_attach = cider_on_attach,
			handlers = cider_lsp_handlers,
		})
	end
end

return M
