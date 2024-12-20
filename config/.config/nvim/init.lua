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

require("config.clipboard")
require("config.tmpl")
require("config.zip")

require("lazy").setup({
  -- this entry tells lazy.nvim to load the list of of *.lua files from plugins/
   import = "plugins" ,
  -- Dev configuration
  dev = {
    -- Directory where you store your local plugin projects
    path = "~/neovim-plugins/squk/",
    -- @type string[] plugins that match these patterns will use your local versions instead of being fetched from GitHub
    patterns = { "squk" },
    fallback = false, -- Fallback to git when local plugin doesn't exist
  },
})

vim.opt.undodir = vim.fn.expand("$HOME") .. "/.undo/"
