return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	init = function()
		vim.o.timeout = true
		vim.o.timeoutlen = 300
	end,
	config = function()
		require("which-key").setup({})
		local wk = require("which-key")
		wk.register({
			["%%"] = { '<C-R>=fnameescape(expand("%:p:h")."/")<CR>', "Current File Directory" },
			["%."] = { "<C-R>%", "Current File" },
		}, { mode = "c" })
		--
		-- wk.register({
		--     ["jk"] = { "<esc>" },
		--     ["J"] = { ":tabprevious<CR>" },
		--     ["K"] = { ":tabnext<CR>" },
		--     ["vv"] = { "<C-W>v" },
		--     ["ss"] = { "<C-W>s" },
		--     ["<space><space>"] = { ":w<CR>" },
		-- })
		--
		-- wk.register({
		--     t = {
		--         name = "+tab",
		--         t = { ":tabedit<Space>" },
		--         d = { ":tabclose<CR>" },
		--     },
		-- })
	end,
}
