return {
	{
		"neovim/nvim-lspconfig",
		-- event = "VimEnter",
		dependencies = {
			"hrsh7th/nvim-cmp",
			"nvim-lua/lsp-status.nvim",
			"VonHeikemen/lsp-zero.nvim",
			"rcarriga/nvim-notify",
		},
		config = function()
			local use_google = require("utils").use_google
			local notify = require("notify")

			local lspconfig = require("lspconfig")
			local configs = require("lspconfig.configs")
			local lsp_status = require("lsp-status")
			lsp_status.register_progress()

			-- CiderLSP
			vim.opt.completeopt = { "menu", "menuone", "noselect" }
			-- Don't show the dumb matching stuff
			vim.opt.shortmess:append("c")

			vim.opt.spell = true
			vim.opt.spelllang = { "en_us" }
			vim.lsp.handlers["window/showMessage"] = function(_, result, ctx)
				local client = vim.lsp.get_client_by_id(ctx.client_id)
				local lvl = ({
					"ERROR",
					"WARN",
					"INFO",
					"DEBUG",
				})[result.type]
				notify({ result.message }, lvl, {
					title = "LSP | " .. client.name,
					timeout = 1000,
					keep = function()
						return lvl == "ERROR" or lvl == "WARN"
					end,
				})
			end

			configs.ast_grep = {
				default_config = {
					cmd = { "sg", "lsp" },
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
					single_file_support = true,
					root_dir = lspconfig.util.root_pattern("BUILD", ".git", "sgconfig.yml"),
				},
			}

			if use_google() then
				configs.ciderlsp = {
					default_config = {
						cmd = {
							"/google/bin/releases/cider/ciderlsp/ciderlsp",
							"--tooltag=nvim-cmp",
							"--forward_sync_responses",
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
						-- required for proto generated files jump
						root_dir = function(fname)
							return string.match(fname, "(/google/src/cloud/[%w_-]+/[%w_-]+/google3/).+$")
						end,
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
							"markdown",
							"typescript",
							"javascript",
						},
						root_dir = function(fname)
							return string.match(fname, "(/google/src/cloud/[%w_-]+/[%w_-]+/google3/).+$")
						end,
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
				layeredDiagnostics = true,
			}

			capabilities = vim.tbl_extend("keep", capabilities or {}, lsp_status.capabilities)

			local my_on_attach = function(client, bufnr)
				require("lualine").refresh()

				vim.api.nvim_command("autocmd CursorHold  <buffer> lua vim.lsp.buf.document_highlight()")
				vim.api.nvim_command("autocmd CursorHoldI <buffer> lua vim.lsp.buf.document_highlight()")
				vim.api.nvim_command("autocmd CursorMoved <buffer> lua vim.lsp.util.buf_clear_references()")

				vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
				if vim.lsp.formatexpr then -- Neovim v0.6.0+ only.
					vim.api.nvim_buf_set_option(bufnr, "formatexpr", "v:lua.vim.lsp.formatexpr")
				end
				if vim.lsp.tagfunc then
					vim.api.nvim_buf_set_option(bufnr, "tagfunc", "v:lua.vim.lsp.tagfunc")
				end

				lsp_status.on_attach(client)

				local opts = { noremap = true, silent = true }
				vim.api.nvim_set_keymap("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
				vim.api.nvim_set_keymap("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
				vim.api.nvim_set_keymap("n", "L", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
				vim.api.nvim_set_keymap("n", "g0", "<cmd>lua vim.lsp.buf.document_symbol()<CR>", opts)
				vim.api.nvim_set_keymap("n", "gW", "<cmd>lua vim.lsp.buf.workspace_symbol()<CR>", opts)
				vim.api.nvim_set_keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
				vim.api.nvim_set_keymap("n", "gD", "<cmd>tab split | lua vim.lsp.buf.definition()<CR>", opts)
				-- vim.api.nvim_buf_set_keymap(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
				vim.api.nvim_set_keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
				vim.api.nvim_set_keymap("n", "gI", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
				vim.api.nvim_set_keymap("n", "gR", "<cmd>lua vim.lsp.buf.references()<CR>", opts) -- diagnostics controls references
				vim.api.nvim_set_keymap("n", "<C-g>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
				vim.api.nvim_set_keymap("i", "<C-g>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)

				vim.api.nvim_set_keymap("n", "gt", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
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

				capabilities = require("cmp_nvim_ciderlsp").update_capabilities(capabilities)
				capabilities.workspace.codeLens = { refreshSupport = true }
				capabilities.workspace.diagnostics = { refreshSupport = true }
				lspconfig.analysislsp.setup({
					capabilities = capabilities,
				})
				lspconfig.ciderlsp.setup({
					capabilities = capabilities,
					on_attach = cider_on_attach,
					handlers = cider_lsp_handlers,
				})
			end
		end,
	},
}
