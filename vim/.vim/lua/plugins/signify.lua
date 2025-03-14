local use_google = require("utils").use_google

local function change_diffbase(hg_revision, git_revision)
  vim.g.signify_vcs_cmds = {
    git = "git diff --no-color --diff-algorithm=histogram --no-ext-diff -U0 " .. git_revision .. " -- %f",
    yadm = 'yadm diff --no-color --no-ext-diff -U0 -- %f',
    hg = 'chg --config alias.diff=diff diff --color=never --nodates -U0 -- %f',
    svn = 'svn diff --diff-cmd %d -x -U0 -- %f',
    bzr = 'bzr diff --using %d --diff-options=-U0 -- %f',
    darcs = 'darcs diff --no-pause-for-gui --no-unified --diff-opts=-U0 -- %f',
    fossil = 'fossil diff --unified -c 0 -- %f',
    cvs = 'cvs diff -U0 -- %f',
    rcs = 'rcsdiff -U0 %f 2>%n',
    accurev = 'accurev diff %f -- -U0',
    tfs = 'tf diff -version=W -noprompt -format=Unified %f'
  }
  vim.g.signify_vcs_cmds_diffmode = {
    git = "git show " .. git_revision .. ":./%f",
    hg = "chg cat " .. hg_revision .. " -- %f",
    yadm = 'yadm show HEAD:./%f',
    svn = 'svn cat %f',
    bzr = 'bzr cat %f',
    darcs = 'darcs show contents -- %f',
    fossil = 'fossil cat %f',
    cvs = 'cvs up -p -- %f 2>%n',
    rcs = 'co -q -p %f',
    accurev = 'accurev cat %f',
    perforce = 'p4 print %f',
    tfs = 'tf view -version:W -noprompt %f',
  }
end

_G.signify_dtup = function()
  change_diffbase('-r ".^"', 'HEAD^')
  vim.cmd([[:SignifyEnable]])
  vim.cmd([[:SignifyRefresh]])
end

_G.signify_normal = function()
  change_diffbase("-r .", "")
  vim.cmd([[:SignifyEnable]])
  vim.cmd([[:SignifyRefresh]])
end

_G.signify_dtp4 = function()
  change_diffbase("-r p4head", "main")
  vim.cmd([[:SignifyEnable]])
  vim.cmd([[:SignifyRefresh]])
end

_G.signify_dtex = function()
  change_diffbase("-r exported(.)", "origin/main")
  vim.cmd([[:SignifyEnable]])
  vim.cmd([[:SignifyRefresh]])
end
return {
  "mhinz/vim-signify",
  event = "VimEnter",
  -- stylua: ignore
  keys = {
    { "]d",          "<plug>(signify-next-hunk)" },
    { "[d",          "<plug>(signify-prev-hunk)" },
    { "<leader>sd",  ":SignifyDiff<CR>" },
    { "<leader>sn",  ":lua signify_normal()<CR>" },
    { "<leader>sup", ":lua signify_dtup()<CR>" },
    { "<leader>sex", ":lua signify_dtex()<CR>" },
    { "<leader>sp4", ":lua signify_dtp4()<CR>" },
    { "<leader>sb",  ":lua signify_dtp4()<CR>" },
  },
  config = function()
    vim.g.signify_vcs_list = { "hg", "git" }
    vim.g.signify_disable_by_default = 0
    -- vim.g.signify_number_highlight = 1
    vim.g.signify_sign_show_count = 0
    local s = "▕"
    vim.g.signify_sign_add = s
    vim.g.signify_sign_delete = s
    vim.g.signify_sign_change = s
    vim.api.nvim_set_hl(0, "SignifySignAdd", { fg = "#9cd9b8" })
    vim.api.nvim_set_hl(0, "SignifySignChange", { fg = "#849ee3" })

    local myred = "#f296a0"
    vim.api.nvim_set_hl(0, "SignifySignChangeDelete", { fg = myred })
    vim.api.nvim_set_hl(0, "SignifySignDelete", { fg = myred })
    vim.api.nvim_set_hl(0, "SignifyLineDelete", { fg = myred })
    vim.api.nvim_set_hl(0, "SignifySignDeleteDeleteFirstLine", { fg = myred })
  end,
}
