return {
	"lommix/bevy_inspector.nvim",
	dependencies = {
		"nvim-telescope/telescope.nvim",
		"nvim-lua/plenary.nvim",
	},
	config = function()
		require("bevy_inspector").setup({})
	end,
	cmd = { "BevyInspect", "BevyInspectNamed", "BevyInspectQuery" },
    -- stylua: ignore
		keys = {
			{  "<leader>bia", ":BevyInspect<Cr>", desc = "Lists all entities" },
			{  "<leader>bin", ":BevyInspectNamed<Cr>", desc = "List all named entities" },
			{  "<leader>biq", ":BevyInspectQuery<Cr>", desc = "Query a single component, continues to list all matching entities", },
		},
}
