local use_google = require("utils").use_google
-- local tprint = require("utils").tprint
-- local dump = require("utils").dump
local log = require("utils").log
local notify = require 'notify'

local lsp_status = require('lsp-status')
lsp_status.register_progress()

require("mason").setup()
require("mason-lspconfig").setup({
    ensure_installed = { "sumneko_lua", "rust_analyzer" }
})

local lspconfig = require("lspconfig")
local configs = require("lspconfig.configs")
if use_google() then
    configs.ciderlsp = {
        default_config = {
            cmd = { "/google/bin/releases/cider/ciderlsp/ciderlsp", "--tooltag=nvim-cmp", "--forward_sync_responses" },
            filetypes = { "c", "cpp", "java", "kotlin", "objc", "proto", "textproto", "go", "python", "bzl", "typescript"},
            -- root_dir = lspconfig.util.root_pattern("BUILD"),
            root_dir = function(fname)
                return string.match(fname, '(/google/src/cloud/[%w_-]+/[%w_-]+/google3/).+$')
            end;
            settings = {},
        },
    }

    configs.analysislsp = {
        default_config = {
            cmd = { '/google/bin/users/lerm/glint-ale/analysis_lsp/server', '--lint_on_save=false', '--max_qps=10' },
            filetypes = { "c", "cpp", "java", "kotlin", "objc", "proto", "textproto", "go", "python", "bzl", "markdown","typescript", "javascript"},
            -- root_dir = lspconfig.util.root_pattern('BUILD'),
            root_dir = function(fname)
                return string.match(fname, '(/google/src/cloud/[%w_-]+/[%w_-]+/google3/).+$')
            end;
            settings = {},
        },
    }
end

local cider_lsp_handlers = {
    ["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, {
        underline = true,
    })
}

cider_lsp_handlers["$/syncResponse"] = function(_, result, ctx)
    -- is_cider_lsp_attached has been setup via on_init, but hasn't received
    -- sync response yet.
    local first_fire = vim.b['is_cider_lsp_attached'] == 'no'
    vim.b['is_cider_lsp_attached'] = 'yes'
    if first_fire then
        notify('CiderLSP attached', 'info', {timeout=500})
        require('lualine').refresh()
    end
end

cider_lsp_handlers["workspace/diagnostic/refresh"] = function(_, result, ctx)
    notify('result:'..result, 'info', {timeout=900})
    notify('ctx:'..ctx, 'info', {timeout=900})
end

cider_lsp_handlers['window/showMessage'] = function(_, result, ctx)
    local client = vim.lsp.get_client_by_id(ctx.client_id)
    local lvl = ({
        'ERROR',
        'WARN',
        'INFO',
        'DEBUG',
    })[result.type]
    notify({ result.message }, lvl, {
        title = 'LSP | ' .. client.name,
        timeout = 1000,
        keep = function()
            return lvl == 'ERROR' or lvl == 'WARN'
        end,
    })
end

-- 3. Set up CiderLSP
local on_attach = function(client, bufnr)
    vim.b['is_cider_lsp_attached'] = 'no'
    require('lualine').refresh()

    vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
    if vim.lsp.formatexpr then -- Neovim v0.6.0+ only.
        vim.api.nvim_buf_set_option(bufnr, "formatexpr", "v:lua.vim.lsp.formatexpr")
    end
    if vim.lsp.tagfunc then
        vim.api.nvim_buf_set_option(bufnr, "tagfunc", "v:lua.vim.lsp.tagfunc")
    end

    if client.server_capabilities.document_highlight then
        vim.api.nvim_command("autocmd CursorHold  <buffer> lua vim.lsp.buf.document_highlight()")
        vim.api.nvim_command("autocmd CursorHoldI <buffer> lua vim.lsp.buf.document_highlight()")
        vim.api.nvim_command("autocmd CursorMoved <buffer> lua vim.lsp.util.buf_clear_references()")
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
    vim.api.nvim_set_keymap("n", "grf", "<cmd>lua vim.lsp.buf.references()<CR>", opts)  -- diagnostics controls references
    vim.api.nvim_set_keymap("n", "<C-g>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
    vim.api.nvim_set_keymap("i", "<C-g>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)

    vim.api.nvim_set_keymap("n", "gt", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
end


local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
capabilities['codeLens'] = {dynamicRegistration=false}
capabilities.textDocument.publishDiagnostics={
    relatedInformation=true,
    versionSupport=false,
    tagSupport={
        valueSet={
            1,
            2
        }
    },
    codeDescriptionSupport=true,
    dataSupport=true,
    layeredDiagnostics=true
}

capabilities = vim.tbl_extend('keep', capabilities or {}, lsp_status.capabilities)

local runtime_path = vim.split(package.path, ";")
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

lspconfig.sumneko_lua.setup({
    capabilities = capabilities,
    on_attach = on_attach,
    settings = {
        Lua = {
            runtime = {
                -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                version = "LuaJIT",
                -- Setup your lua path
                path = runtime_path,
            },
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = { "vim" },
            },
            workspace = {
                -- Make the server aware of Neovim runtime files
                library = vim.api.nvim_get_runtime_file("", true),
            },
            -- Do not send telemetry data containing a randomized but unique identifier
            telemetry = {
                enable = false,
            },
        },
    },
})


if use_google() then
    capabilities = require('cmp_nvim_ciderlsp').update_capabilities(capabilities)
    capabilities.workspace.codeLens = {refreshSupport=true}
    capabilities.workspace.diagnostics = {refreshSupport=true}
    lspconfig.ciderlsp.setup({
        capabilities = capabilities,
        on_attach = on_attach,
        handlers = cider_lsp_handlers,
    })
    lspconfig.analysislsp.setup({
        capabilities = capabilities,
        on_attach = on_attach,
    })
end

local lspkind = require("lspkind")
lspkind.init()
local cmp = require("cmp")

local has_words_before = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local feedkey = function(key, mode)
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
end

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
        { name = 'buffer' }
    }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
        { name = 'nvim_lsp_document_symbol' }
    },{
        { name = 'path' }
    }, {
        { name = 'cmdline' }
    })
})

local conditionalSources = {
    { name = "nvim_lua" },
    { name = "nvim_lsp" },
    { name = "path" },
    { name = "treesitter" },
    { name = "crates" },
    { name = "vim_vsnip" },
    { name = 'nvim_lsp_signature_help' },
    { name = "buffer", keyword_length = 5 },
    {
        name = 'spell',
        option = {
            keep_all_entries = false,
            enable_in_context = function()
                return true
            end,
        },
    },
}

if use_google() then
    table.insert(conditionalSources, { name = 'nvim_ciderlsp', priority = 9 })
    table.insert(conditionalSources, { name = 'analysislsp', priority = 9 })
else
    table.insert(conditionalSources, {name = 'cmp_tabnine'})

end

local i = 0

function cmp_format(opts)
    if opts == nil then
        opts = {}
    end
    if opts.preset or opts.symbol_map then
        lspkind.init(opts)
    end

    return function(entry, vim_item)
        if opts.before then
            vim_item = opts.before(entry, vim_item)
        end

        vim_item.kind = lspkind.symbolic(vim_item.kind, opts)
        if i == 0 then
            if entry.source.name == "nvim_lsp" then
                log(vim.json.encode(entry.source))
                i = i + 1
            end
        end

        if opts.menu ~= nil then
            vim_item.menu = opts.menu[entry.source.name]
            -- if entry.source.client ~= nil then
            --     if entry.source.client.name ~= nil then
            --         log(entry.source.client.name)
            --     end
            -- end
            -- vim_item.menu = opts.menu[entry.source.name+":"+entry.source.client.name]
        end

        if opts.maxwidth ~= nil then
            if opts.ellipsis_char == nil then
                vim_item.abbr = string.sub(vim_item.abbr, 1, opts.maxwidth)
            else
                local label = vim_item.abbr
                local truncated_label = vim.fn.strcharpart(label, 0, opts.maxwidth)
                if truncated_label ~= label then
                    vim_item.abbr = truncated_label .. opts.ellipsis_char
                end
            end
        end
        return vim_item
    end
end

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
            require "cmp-under-comparator".under,
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
        -- format = cmp_format({
        format = lspkind.cmp_format({
            with_text = true,
            maxwidth = 40, -- half max width
            menu = {
                nvim_ciderlsp = "",
                buffer = "",
                crates = "📦",
                nvim_lsp = "[CiderLSP]",
                cmp_tabnine = "[TabNine]",
                nvim_lua = "[API]",
                path = "[path]",
                tmux = "[TMUX]",
                vim_vsnip = "[snip]",
            },
        }),
    },

    experimental = {
        native_menu = false,
        ghost_text = true,
    },
})

local lsp = require('lsp-zero')
-- lsp.preset('lsp-compe')
lsp.set_preferences({
  suggest_lsp_servers = true,
  setup_servers_on_start = true,
  set_lsp_keymaps = false,
  configure_diagnostics = true,
  cmp_capabilities = true,
  manage_nvim_cmp = true,
  call_servers = 'local',
  sign_icons = {
    error = '✘',
    warn = '▲',
    hint = '⚑',
    info = ''
  }
})

lsp.nvim_workspace()
lsp.on_attach(on_attach)
lsp.setup()

-- Initialize rust_analyzer with rust-tools
local rust_lsp = lsp.build_options('rust_analyzer', {})
require('rust-tools').setup({ server = rust_lsp, })


vim.cmd([[
augroup CmpZsh
au!
autocmd Filetype zsh lua require'cmp'.setup.buffer { sources = { { name = "zsh" }, } }
augroup END
]])

