require('nvim-treesitter.configs').setup {
    -- A list of parser names, or "all"
    -- ensure_installed = { "c", "lua", "vim", "java", "kotlin"},
    ensure_installed = "all",

    -- Install parsers synchronously (only applied to `ensure_installed`)
    sync_install = false,

    highlight = {
        -- `false` will disable the whole extension
        enable = true,

        -- rainbow markdown
        -- custom_captures = {
        --     ["h1"] = "h1",
        --     ["_h1"] = "_h1",
        --     ["h2"] = "h2",
        --     ["_h2"] = "_h2",
        --     ["h3"] = "h3",
        --     ["_h3"] = "_h3",
        --     ["h4"] = "h4",
        --     ["_h4"] = "_h4",
        --     ["h5"] = "h5",
        --     ["_h5"] = "_h5",
        -- },
        indent = {
            enable = true
        },
        -- disable = {"java"},
    },
}
