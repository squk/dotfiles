local use_google = require("utils").use_google
return {
	{
		"Exafunction/codeium.nvim",
		event = "VeryLazy",
		-- event = "InsertEnter",
		cond = not use_google(),
		dependencies = {
			"nvim-lua/plenary.nvim",
			"hrsh7th/nvim-cmp",
		},
		config = function()
			require("codeium").setup({})
		end,
	},
}
