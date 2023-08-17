local use_google = require("utils").use_google
local TableConcat = require("utils").TableConcat
local keys = {
	{ "<leader>f", ":FloatermToggle<CR>" },
	{ "<leader>f", "<C-\\><C-n>:FloatermToggle<CR>", mode = "t" },
}

if use_google() then
	TableConcat(keys, {
		-- { "<leader>br", ":FloatermSend blaze run blaze#GetTargets()<CR>" },
	})
end

return {
	"voldikss/vim-floaterm",
	keys = keys,
}
