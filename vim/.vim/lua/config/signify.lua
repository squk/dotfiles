local map = require("utils").map

-- vim.g.signify_vcs_cmds = {
--   hg = 'hg cat %f -r p4base',
-- }

map('n', ']d', '<plug>(signify-next-hunk)')
map('n', '[d', '<plug>(signify-prev-hunk)')
