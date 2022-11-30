-- Here are all the options and their default values:
require('google.comments').setup {
    -- The command for fetching comments, refer to `get_comments.par --help` to
    -- see all the options.
    -- command = {'/google/bin/releases/editor-devtools/get_comments.par', '--full', '--json', "-x=''"},
    stubby = true,
    --
    command = {'/google/bin/releases/editor-devtools/get_comments.par', '--json', '--full', '--noresolved', '--cl_comments', '--file_comments'},
    -- /google/bin/releases/editor-devtools/get_comments.par --json --full --noresolved --cl_comments --file_comments  -x "" --cl 487267122
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
    },
    --- Enable viewing comments through floating window
    floating = true,
    --- Options used when creating the floating window.
    floating_window_options = require('google.comments.options').default_floating_window_options,
}

local map = require("utils").map
-- here are some mappings you might want:
map('n', '<Leader>nc', [[<Cmd>lua require('google.comments').goto_next_comment()<CR>]])
map('n', '<Leader>pc', [[<Cmd>lua require('google.comments').goto_prev_comment()<CR>]])
map('n', '<Leader>lc', [[<Cmd>lua require('google.comments').toggle_line_comments()<CR>]])
map('n', '<Leader>ac', [[<Cmd>lua require('google.comments').toggle_all_comments()<CR>]])

vim.fn.sign_define('COMMENT_ICON', {text = ''})
