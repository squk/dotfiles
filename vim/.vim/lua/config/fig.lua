local map = require("utils").map
local use_google = require("utils").use_google

if use_google() then
	map("n", "<leader>tm", ":Telescope citc modified<CR>")
	map("n", "<leader>tb", ":Telescope file_browser<CR>")

	-- [F]ig [S]tatus
	map("n", "<leader>fs", [[<cmd>lua require('telescope').extensions.fig.status{}<CR>]])

	-- [F]ig [X]l
	map("n", "<leader>fx", [[<cmd>lua require('telescope').extensions.fig.xl{}<CR>]])

	-- [F]ig [W]hatsout
	map("n", "<leader>fw", [[<cmd>lua require('telescope').extensions.fig.status{whatsout=true}<CR>]])

	-- [F]ig [A]mend
	map("n", "<leader>fa", [[<cmd>Hg amend<CR>]])

	-- [F]ig [A]mend
	map("n", "<leader>fe", [[<cmd>Hg evolve<CR>]])

	-- [F]ig [N]ext
	map("n", "<leader>fn", [[<cmd>Hg next<CR>]])
	--
	-- [F]ig [P]rev
	map("n", "<leader>fp", [[<cmd>Hg prev<CR>]])
	--
	-- [F]ig [U]pload
	map("n", "<leader>fu", [[<cmd>Hg upload tree<CR>]])

	-- map('n', '<Leader>f', ':Figtree<CR>', { silent = true })
end
