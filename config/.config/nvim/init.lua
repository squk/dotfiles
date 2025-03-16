vim.cmd("source " .. vim.env.HOME .. "/.vimrc")

vim.g.maplocalleader = ","
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
local luahome = vim.env.HOME .. "/.vim/lua"
vim.opt.rtp:prepend(luahome)

package.path = package.path .. ";" .. vim.env.HOME .. "/.vim/lua/?.lua"

for _, file in ipairs(vim.fn.readdir(luahome .. "/config", [[v:val =~ '\.lua$']])) do
	require("config" .. "." .. file:gsub("%.lua$", ""))
end

require("lazy").setup({
	-- this entry tells lazy.nvim to load the list of of *.lua files from plugins/
	import = "plugins",
})

vim.opt.undodir = vim.fn.expand("$HOME") .. "/.undo/"
