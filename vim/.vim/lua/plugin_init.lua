local fn = vim.fn
local use_google = require("utils").use_google

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

package.path = package.path .. ';' .. vim.env.HOME .. "/.vim/lua/?.lua"

require("lazy").setup("plugins")

-- CiderLSP
vim.opt.completeopt = { "menu", "menuone", "noselect" }
-- Don't show the dumb matching stuff
vim.opt.shortmess:append("c")

vim.opt.spell = true
vim.opt.spelllang = { 'en_us' }
