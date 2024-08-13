return {
	"folke/paint.nvim",
	config = function()
		vim.api.nvim_set_hl(0, "NievesLightPurple", { fg = "#7f67c5" })
		vim.api.nvim_set_hl(0, "NievesViolet", { fg = "#4000f0", bold = true })

		require("paint").setup({
			highlights = {
				-- Highlight /** @something */
				{
					filter = { filetype = "java" },
					pattern = "%*.-(@[%w_]+)%s?",
					hl = "Constant",
				},
				-- Highlight /** @param something */
				{
					filter = { filetype = "java" },
					pattern = "%*.*@param%s+([%w_+]+)%s?",
					hl = "Identifier",
				},
				-- Highlight /** {@link} */
				-- {
				-- 	filter = { filetype = "java" },
				-- 	pattern = "%*.*{%s?(@link)%s+[%w_+]+%s?}",
				-- 	hl = "Red",
				-- },
				-- -- Highlight /** {@link something} */
				-- {
				-- 	filter = { filetype = "java" },
				-- 	pattern = "%*.*{%s?@link%s+([%w_+]+)%s?}",
				-- 	hl = "Yellow",
				-- },
				--
				-- WASM
				-- { pattern = "(W)ASM", hl = "LightRed", filter = {} },
				-- { pattern = "W(A)SM", hl = "LightBlue", filter = {} },
				-- { pattern = "WA(S)M", hl = "LightGreen", filter = {} },
				-- { pattern = "WAS(M)", hl = "LightYellow", filter = {} },

				-- Google
				-- { pattern = "Google", hl = "LightBlue", filter = {} },
				-- { pattern = "(G)oogle", hl = "LightBlue", filter = {} },
				-- { pattern = "G(o)ogle", hl = "LightRed", filter = {} },
				-- { pattern = "Go(o)gle", hl = "LightYellow", filter = {} },
				-- { pattern = "Goo(g)le", hl = "LightBlue", filter = {} },
				-- { pattern = "Goog(l)e", hl = "LightGreen", filter = {} },
				-- { pattern = "Googl(e)", hl = "LightRed", filter = {} },

				-- cnieves
				-- { pattern = "cnieves", hl = "LightPurple", filter = {} },
				-- { pattern = "Christian Nieves", hl = "LightPurple", filter = {} },
				{ pattern = "Christian Nieves", hl = "NievesViolet", filter = {} },
				{ pattern = "Christian Nieves", hl = "NievesLightPurple", filter = {} },
			},
		})
	end,
}
