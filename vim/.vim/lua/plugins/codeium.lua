local use_google = require("utils").use_google
return {
	{
		"Exafunction/codeium.nvim",
		-- commit = "b1ff0d6c993e3d87a4362d2ccd6c660f7444599f",
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
