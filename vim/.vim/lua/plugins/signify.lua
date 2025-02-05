local use_google = require("utils").use_google

local function setup_mercurial(hg_revision)
  local git_cmd = "git diff --no-color --no-ext-diff -U0 -- %f"
  local rcs_cmd = "rcsdiff -U0 %f 2>%n"
  local svn_cmd = "svn diff --diff-cmd %d -x -U0 -- %f"
  local hg_diff = hg_revision .. " --color=never config aliases.diff= --nodates -U0 -- %f"
  local hg_cat = hg_revision .. " -- %f"

  vim.cmd(string.format(
    [[
let g:signify_vcs_cmds = {
      \ 'git':      '%s',
      \ 'rcs':      '%s',
      \ 'svn':      '%s',
      \ 'hg':       'chg diff %s',
      \ }
let g:signify_vcs_cmds_diffmode = {
      \ 'hg':       'chg cat %s',
      \ }
  ]],
    git_cmd,
    rcs_cmd,
    svn_cmd,
    hg_diff,
    hg_cat
  ))
end

_G.signify_dtup = function()
  setup_mercurial('-r ".^"')
  vim.cmd([[:SignifyEnable]])
  vim.cmd([[:SignifyRefresh]])
end

_G.signify_normal = function()
  setup_mercurial("-r .")
  vim.cmd([[:SignifyEnable]])
  vim.cmd([[:SignifyRefresh]])
end

_G.signify_dtp4 = function()
  setup_mercurial("-r p4head")
  vim.cmd([[:SignifyEnable]])
  vim.cmd([[:SignifyRefresh]])
end

_G.signify_dtex = function()
  setup_mercurial("-r exported(.)")
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
  },
  config = function()
    vim.g.signify_vcs_list = { "hg", "git" }
    vim.g.signify_disable_by_default = 0
    -- vim.g.signify_number_highlight = 1
    local s = "▕"
    vim.g.signify_sign_add = s
    vim.g.signify_sign_delete = s
    vim.g.signify_sign_change = s
    vim.api.nvim_set_hl(0, "SignifySignAdd", { fg = "#9cd9b8" })
    vim.api.nvim_set_hl(0, "SignifySignChange", { fg = "#849ee3" })

    local red = "#f896a0"
    vim.api.nvim_set_hl(0, "SignifySignChangeDelete", { fg = red })
    vim.api.nvim_set_hl(0, "SignifySignDelete", { fg = red })
    vim.api.nvim_set_hl(0, "SignifySignDeleteDeleteFirstLine", { fg = red })
  end,
}
