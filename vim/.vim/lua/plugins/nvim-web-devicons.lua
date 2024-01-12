return {
	"nvim-tree/nvim-web-devicons",
	lazy = false,
	config = function()
		require("nvim-web-devicons").set_icon({
			rs = {
				icon = "",
				color = "#dea584",
				cterm_color = "65",
				name = "Rust",
			},
		})
	end,
	-- {
	-- 	"ipod825/libp.nvim",
	-- 	config = function()
	-- 		require("libp").setup({
	-- 			integration = {
	-- 				web_devicon = {
	-- 					icons = {
	-- 						["rs"] = { icon = "", name = "Rust", hl = { fg = "#dea584", underline = true } },
	-- 					},
	-- 				},
	-- 			},
	-- 		})
	-- 	end,
	-- },
}
