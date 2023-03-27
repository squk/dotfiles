local use_google = require("utils").use_google

require('telescope').setup {
    defaults =  {
        -- The vertical layout strategy is good to handle long paths like those in
        -- google3 repos because you have nearly the full screen to display a file path.
        -- The caveat is that the preview area is smaller.
        layout_strategy = 'vertical',
        -- Common paths in google3 repos are collapsed following the example of Cider
        -- It is nice to keep this as a user config rather than part of
        -- telescope-codesearch because it can be reused by other telescope pickers.
        path_display = function(opts, path)
            -- Do common substitutions
            path = path:gsub("^/google/src/cloud/[^/]+/[^/]+/google3/", "google3/", 1)
            path = path:gsub("^google3/java/com/google/", "g3/j/c/g/", 1)
            path = path:gsub("^google3/javatests/com/google/", "g3/jt/c/g/", 1)
            path = path:gsub("^google3/third_party/", "g3/3rdp/", 1)
            path = path:gsub("^google3/", "g3/", 1)

            -- Do truncation. This allows us to combine our custom display formatter
            -- with the built-in truncation.
            -- `truncate` handler in transform_path memoizes computed truncation length in opts.__length.
            -- Here we are manually propagating this value between new_opts and opts.
            -- We can make this cleaner and more complicated using metatables :)
            local new_opts = {
                path_display = {
                    truncate = true,
                },
                __length = opts.__length,
            }
            path = require('telescope.utils').transform_path(new_opts, path)
            opts.__length = new_opts.__length
            return path
        end,
    },
    extensions = { -- this block is optional, and if omitted, defaults will be used
    codesearch = {
        experimental = true           -- enable results from google3/experimental
    }
}
}

local map = require("utils").map

map('n', '<leader>tb', ":Telescope file_browser", { desc = '[T]elescope [B]rowse' })
map('n', '<leader>tf', [[:lua require('telescope.builtin').find_files{ find_command = {'rg', '--files', '--hidden', '-g', '!node_modules/**'} }<cr>]], { desc = '[T]elescope [F]iles' })
map('n', '<leader>th', require('telescope.builtin').help_tags, { desc = '[T]elescope [H]elp' })
map('n', '<leader>tw', require('telescope.builtin').grep_string, { desc = '[T]elescope current [W]ord' })
map('n', '<leader>tg', require('telescope.builtin').live_grep, { desc = '[T]elescope by [G]rep' })

if use_google() then
    -- These custom mappings let you open telescope-codesearch quickly:
    map('n', '<C-P>',
    [[<cmd>lua require('telescope').extensions.codesearch.find_files{}<CR>]],
    { noremap = true, silent=true }
    )

    -- Search using codesearch queries.
    map(
    "n",
    "<leader>cs",
    [[<cmd>lua require('telescope').extensions.codesearch.find_query{}<CR>]],
    { noremap = true, silent = true }
    )

    -- Search for the word under cursor.
    map(
    "n",
    "<leader>CS",
    [[<cmd>lua require('telescope').extensions.codesearch.find_query{default_text_expand='<cword>'}<CR>]],
    { noremap = true, silent = true }
    )

    -- Search for text selected in Visual mode.
    map(
    "v",
    "<leader>cs",
    [[<cmd>lua require('telescope').extensions.codesearch.find_query{}<CR>]],
    { noremap = true, silent = true }
    )
end
