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

-- These custom mappings let you open telescope-codesearch quickly:
vim.api.nvim_set_keymap('n', '<C-P>',
  [[<cmd>lua require('telescope').extensions.codesearch.find_files{}<CR>]],
  { noremap = true, silent=true }
)

-- Search using codesearch queries.
vim.api.nvim_set_keymap(
  "n",
  "<leader>cs",
  [[<cmd>lua require('telescope').extensions.codesearch.find_query{}<CR>]],
  { noremap = true, silent = true }
)
--
-- Search for files using codesearch queries.
vim.api.nvim_set_keymap(
  "n",
  "<leader>cf",
  [[<cmd>lua require('telescope').extensions.codesearch.find_files{}<CR>]],
  { noremap = true, silent = true }
)

-- Search for the word under cursor.
vim.api.nvim_set_keymap(
  "n",
  "<leader>CS",
  [[<cmd>lua require('telescope').extensions.codesearch.find_query{default_text_expand='<cword>'}<CR>]],
  { noremap = true, silent = true }
)

-- Search for a file having word under cursor in its name.
vim.api.nvim_set_keymap(
  "n",
  "<leader>CF",
  [[<cmd>lua require('telescope').extensions.codesearch.find_files{default_text_expand='<cword>'}<CR>]],
  { noremap = true, silent = true }
)

-- Search for text selected in Visual mode.
vim.api.nvim_set_keymap(
  "v",
  "<leader>cs",
  [[<cmd>lua require('telescope').extensions.codesearch.find_query{}<CR>]],
  { noremap = true, silent = true }
)

-- Search for file having text selected in Visual mode.
vim.api.nvim_set_keymap(
  "v",
  "<leader>cf",
  [[<cmd>lua require('telescope').extensions.codesearch.find_files{}<CR>]],
  { noremap = true, silent = true }
)
