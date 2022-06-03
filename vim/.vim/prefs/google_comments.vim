lua << EOF
-- Here are all the options and their default values:
require('google.comments').setup {
  -- The command for fetching comments, refer to `get_comments.par --help` to
  -- see all the options.
  -- command = {'/google/bin/releases/editor-devtools/get_comments.par', '--full', '--noresolved', '--json', "-x=''"},
  command = {'/google/bin/releases/editor-devtools/get_comments.par', '--nofull', '-u', '--json', "-x=''"},
  -- Define your own icon by `vim.fn.sign_define('ICON_NAME', {text = ' '})`.
  -- See :help sign_define
  -- The sign property passed to setup should be the 'ICON_NAME' in the define
  -- example above.
  sign = 'COMMENT_ICON',
  -- Fetch the comments after calling `setup`.
  auto_fetch = true,
  display = {
    -- The width of the comment display window.
    width = 50,
    -- When showing file paths, use relative paths or not.
    relative_path = true,
  },
}
-- here are some mappings you might want:
vim.api.nvim_set_keymap('n', '<Leader>nc',
  [[<Cmd>lua require('google.comments').goto_next_comment()<CR>]],
  { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>pc',
  [[<Cmd>lua require('google.comments').goto_prev_comment()<CR>]],
  { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>lc',
  [[<Cmd>lua require('google.comments').toggle_line_comments()<CR>]],
  { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>ac',
  [[<Cmd>lua require('google.comments').toggle_all_comments()<CR>]],
  { noremap = true, silent = true })

vim.fn.sign_define('COMMENT_ICON', {text = ''})
EOF

autocmd InsertLeave * :lua require('google.comments').update_signs()
autocmd FileType * :lua require('google.comments').fetch_comments()
