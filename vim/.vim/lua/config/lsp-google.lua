local use_google = require("utils").use_google
local M = {}

function M.setup(capabilities)
	if use_google() then
		local lspconfig = require("lspconfig")
		local configs = require("lspconfig.configs")
		configs.ciderlsp = {
			default_config = {
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
				root_dir = lspconfig.util.root_pattern("BUILD"),
				settings = {},
			},
		}

		configs.analysislsp = {
			default_config = {
				cmd = {
					"/google/bin/users/lerm/glint-ale/analysis_lsp/server",
					"--lint_on_save=false",
					"--max_qps=10",
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
					-- "markdown",
					"typescript",
					"javascript",
				},
				root_dir = function(fname)
					return string.match(fname, "(/google/src/cloud/[%w_-]+/[%w_-]+/google3/).+$")
				end,
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
				vim.notify("CiderLSP attached", "info")
				require("lualine").refresh()
			end
		end

		lspconfig.ciderlsp.setup({
			gapabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities()),
			on_attach = cider_on_attach,
			handlers = cider_lsp_handlers,
		})
		lspconfig.analysislsp.setup({
			capabilities = capabilities,
		})
	end
end

return M
