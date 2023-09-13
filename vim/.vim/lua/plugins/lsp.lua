return {
	{
		"neovim/nvim-lspconfig",
		-- event = "VimEnter",
		dependencies = {
			"hrsh7th/nvim-cmp",
			"nvim-lua/lsp-status.nvim",
			"VonHeikemen/lsp-zero.nvim",
			"rcarriga/nvim-notify",
			"ldelossa/litee.nvim",
			"ldelossa/litee-calltree.nvim",
		},
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
			local use_google = require("utils").use_google
			local notify = require("notify")

			local lspconfig = require("lspconfig")
			local configs = require("lspconfig.configs")
			local lsp_status = require("lsp-status")
			lsp_status.register_progress()

			require("litee.lib").setup({})
			require("litee.calltree").setup({})

			vim.opt.spell = true
			vim.opt.spelllang = { "en_us" }

			if use_google() then
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
			end

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

			local my_on_attach = function(client, bufnr)
				require("lualine").refresh()

				-- vim.api.nvim_command("augroup LSP")
				-- vim.api.nvim_command("autocmd!")
				-- if client.server_capabilities.documentFormattingProvider then
				--     vim.api.nvim_command("autocmd CursorHold  <buffer> lua vim.lsp.buf.document_highlight()")
				--     vim.api.nvim_command("autocmd CursorHoldI <buffer> lua vim.lsp.buf.document_highlight()")
				--     vim.api.nvim_command("autocmd CursorMoved <buffer> lua vim.lsp.util.buf_clear_references()")
				-- end
				-- vim.api.nvim_command("augroup END")

				vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
				if vim.lsp.formatexpr then -- Neovim v0.6.0+ only.
					vim.api.nvim_buf_set_option(bufnr, "formatexpr", "v:lua.vim.lsp.formatexpr")
				end
				if vim.lsp.tagfunc then
					vim.api.nvim_buf_set_option(bufnr, "tagfunc", "v:lua.vim.lsp.tagfunc")
				end

				lsp_status.on_attach(client)
			end

			if use_google() then
				local cider_on_attach = function(client, bufnr)
					my_on_attach(client, bufnr)
					vim.b["is_cider_lsp_attached"] = "no"
				end

				local cider_lsp_handlers = {
					["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
						underline = true,
					}),
				}

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
		end,
	},
}
