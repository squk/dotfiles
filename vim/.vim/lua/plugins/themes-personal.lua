local use_google = require("utils").use_google

return {
	{
		"bluz71/vim-moonfly-colors",
		name = "moonfly",
		cond = not use_google(),
		lazy = false,
		priority = 1000,
		config = function()
			local custom_highlight = vim.api.nvim_create_augroup("CustomHighlight", {})
			vim.api.nvim_create_autocmd("colorscheme", {
				pattern = "moonfly",
				callback = function()
					local p = require("moonfly").palette
					local unused = p.test
					local highlights = { "", "VirtualText", "Underline", "Sign", "Floating" }
					for _, h in ipairs(highlights) do
						vim.api.nvim_set_hl(0, "Diagnostic" .. h .. "Error", { fg = p.crimson, bold = true })
						vim.api.nvim_set_hl(0, "Diagnostic" .. h .. "Warn", { fg = p.yellow, bold = true })
						vim.api.nvim_set_hl(0, "Diagnostic" .. h .. "Info", { fg = p.sky, bold = true })
						vim.api.nvim_set_hl(0, "Diagnostic" .. h .. "Hint", { fg = p.turqoise, bold = true })
						vim.api.nvim_set_hl(0, "Diagnostic" .. h .. "Ok", { fg = p.emerald, bold = true })
					end
				end,
				group = custom_highlight,
			})

			vim.g.moonflyCursorColor = true
			vim.g.moonflyItalics = true
			vim.g.moonflyUnderlineMatchParen = true
			vim.g.moonflyVirtualTextColor = true

			vim.cmd("colorscheme moonfly")
		end,
	},
	-- {
	-- 	"EdenEast/nightfox.nvim",
	-- 	lazy = use_google(), -- make sure we load this during startup if it is your main colorscheme
	-- 	priority = 1000, -- make sure to load this before all the other start plugins
	-- 	cond = not use_google(),
	-- 	config = function()
	-- 		-- vim.cmd("colorscheme nightfox")
	-- 		-- vim.cmd("colorscheme carbonfox")
	-- 		-- vim.cmd("colorscheme terafox")
	-- 		vim.cmd("colorscheme duskfox")
	-- 		-- vim.cmd("colorscheme nordfox")
	-- 		-- vim.cmd("colorscheme dayfox")
	-- 		-- vim.cmd("colorscheme dawnfox")
	-- 	end,
	-- },
}
