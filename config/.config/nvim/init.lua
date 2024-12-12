vim.cmd("source " .. vim.env.HOME .. "/.vimrc")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)
vim.opt.rtp:prepend(vim.env.HOME .. "/.vim")
vim.opt.rtp:prepend(vim.env.HOME .. "/.vim/lua")

package.path = package.path .. ";" .. vim.env.HOME .. "/.vim/lua/?.lua"

local plugins = {
  -- this entry tells lazy.nvim to load the list of of *.lua files from plugins/
  { import = "plugins" },
}
require("config.clipboard")
require("config.tmpl")
require("config.zip")

require("lazy").setup(plugins)

vim.opt.undodir = vim.fn.expand("$HOME") .. "/.undo/"
