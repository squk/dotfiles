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
				},
				offset_encoding = "utf-8",
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
				root_dir = lspconfig.util.root_pattern("google3/*BUILD"),
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
				offset_encoding = "utf-8",
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
					"markdown",
					"typescript",
					"javascript",
				},
				root_dir = lspconfig.util.root_pattern("google3/*BUILD"),
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

			lsp_status.on_attach(client)
		end

		local cider_on_attach = function(client, bufnr)
			my_on_attach(client, bufnr)
			vim.b["is_cider_lsp_attached"] = "no"
		end

		local cider_lsp_handlers = {
			["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
				underline = true,
			}),
		}

		local notify = require("notify")
		cider_lsp_handlers["$/syncResponse"] = function(_, result, ctx)
			-- is_cider_lsp_attached has been setup via on_init, but hasn't received
			-- sync response yet.
			local first_fire = vim.b["is_cider_lsp_attached"] == "no"
			vim.b["is_cider_lsp_attached"] = "yes"
			if first_fire then
				notify("CiderLSP attached", "info", { timeout = 500 })
				require("lualine").refresh()
			end
		end
		cider_lsp_handlers["window/showMessage"] = function(_, result, ctx)
			local client = vim.lsp.get_client_by_id(ctx.client_id)
			local lvl = ({ "ERROR", "WARN", "INFO", "DEBUG" })[result.type]
			notify({ result.message }, lvl, {
				title = "LSP | " .. client.name,
				timeout = 1000,
				keep = function()
					return lvl == "ERROR" or lvl == "WARN"
				end,
			})
		end

		capabilities = require("cmp_nvim_ciderlsp").update_capabilities(capabilities)
		capabilities.workspace.codeLens = { refreshSupport = true }
		capabilities.workspace.diagnostics = { refreshSupport = true }

		lspconfig.ciderlsp.setup({
			capabilities = capabilities,
			on_attach = cider_on_attach,
			handlers = cider_lsp_handlers,
		})
		lspconfig.analysislsp.setup({
			capabilities = capabilities,
		})
	end
end

return M
