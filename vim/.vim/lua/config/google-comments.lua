-- Here are all the options and their default values:
require('google.comments').setup {
    -- command = {'/google/bin/releases/editor-devtools/get_comments.par', '--full', '--json', "-x=''"},
    -- stubby = true,
    command = {'/google/bin/releases/editor-devtools/get_comments.par', '--json', '--full', '--noresolved', '--cl_comments', '--file_comments'},
    -- command = {'stubby --output_json call blade:codereview-rpc CodereviewRpcService.GetComments "changelist_number: $(/google/data/ro/teams/fig/bin/vcstool pending-change-number)"'},
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
        --- Enable viewing comments through floating window
        floating = true,
        --- Options used when creating the floating window.
        floating_window_options = floating_window_options
    },
}

function floating_window_options(parent_win_id)
  local parent_width = vim.api.nvim_win_get_width(parent_win_id)
  local parent_height = vim.api.nvim_win_get_height(parent_win_id)

  return {
    relative = 'win',
    anchor = 'NW',
    width = math.floor(parent_width * 0.5),
    height = math.floor(parent_height * 0.3),
    row = vim.api.nvim_win_get_cursor(parent_win_id)[1],
    col = math.floor(parent_width * 0.25),
    border = 'rounded',
  }
end


local map = require("utils").map
-- here are some mappings you might want:
map('n', '[c', [[<Cmd>GoogleCommentsGotoNextComment<CR>]])
map('n', ']c', [[<Cmd>GoogleCommentsGotoPrevComment<CR>]])

map('n', '<Leader>nc', [[<Cmd>GoogleCommentsGotoNextComment<CR>]])
map('n', '<Leader>pc', [[<Cmd>GoogleCommentsGotoPrevComment<CR>]])
map('n', '<Leader>lc', [[<Cmd>GoogleCommentsToggleLineComments<CR>]])
map('n', '<Leader>ac', [[<Cmd>GoogleCommentsToggleAllComments<CR>]])
map('n', '<Leader>fc', [[<Cmd>GoogleCommentsFetchComments<CR>]])

vim.fn.sign_define('COMMENT_ICON', {text = ''})
