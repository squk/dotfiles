local split = function (inputstr, sep)
    local t={}
    for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
        table.insert(t, str)
    end
    return t
end
local function getWords()
    return tostring(vim.fn.wordcount().words)
end
local function getCitc()
    local fname = vim.api.nvim_buf_get_name(0)
    if string.find(fname, '/google/src/cloud/', 1, true) then
        local parts = split(fname, '/')
        return parts[5]
    end
end
function isCiderLspAttached()
    if vim.b['is_cider_lsp_attached'] then
        if vim.b['is_cider_lsp_attached'] == 'yes' then
            return '✓'
        else
            return 'CiderLSP loading..'
        end
    else
        return ''
    end
end
local function getLightbulb()
    return require('nvim-lightbulb').get_status_text()
end

require('lualine').setup {
    options = {
        theme = 'auto',
        globalstatus = false,
        refresh = {
            statusline = 1000,
            tabline = 1000,
            winbar = 1000,
        }
    },
    sections = {
        lualine_a = {'mode'},
        lualine_b = {'branch', 'diff', getCitc, isCiderLspAttached},
        lualine_c = {'filename', {"aerial", depth=-1}, getLightbulb},
        lualine_x = {
            { 'diagnostics', sources = {"nvim_lsp"}, symbols = {error = ' ', warn = ' ', info = ' ', hint = ' '} },
            'encoding',
            'filetype'
        },
        lualine_y = {'searchcount'},
        lualine_z = {'location'}
    },
    tabline = {
        lualine_a = {{'tabs', mode = 1}},
        -- lualine_b = {'branch'},
        -- lualine_c = {'filename'},
        lualine_x = {
            { 'diagnostics', sources = {"nvim_lsp", "nvim_workspace_diagnostic"}, symbols = {error = ' ', warn = ' ', info = ' ', hint = ' '} },
        }
    },
    -- default
    -- sections = {
        --   lualine_a = {'mode'},
        --   lualine_b = {'branch', 'diff', 'diagnostics'},
        --   lualine_c = {'filename'},
        --   lualine_x = {'encoding', 'fileformat', 'filetype'},
        --   lualine_y = {'progress'},
        --   lualine_z = {'location'}
        -- },
        inactive_sections = {
            lualine_a = {},
            lualine_b = {},
            -- lualine_c = {'filename'},
            lualine_x = {'location'},
            lualine_y = {},
            lualine_z = {}
        },
        -- tabline = {},
        -- winbar = {},
        -- inactive_winbar = {},
        -- extensions = {}
    }
