local use_google = require("utils").use_google
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

package.path = package.path .. ";" .. vim.env.HOME .. "/.vim/lua/?.lua"

local plugins = {
	-- this entry tells lazy.nvim to load the list of of *.lua files from plugins/
	{ import = "plugins" },
}
require("lazy").setup(plugins)
require("config.clipboard")
require("config.zip")
