local use_google = require("utils").use_google

local function setup_mercurial(hg_args)
	local git_cmd = "git diff --no-color --no-ext-diff -U0 -- %f"
	local rcs_cmd = "rcsdiff -U0 %f 2>%n"
	local svn_cmd = "svn diff --diff-cmd %d -x -U0 -- %f"
	vim.cmd(string.format(
		[[
let g:signify_vcs_cmds = {
      \ 'git':      '%s',
      \ 'rcs':      '%s',
      \ 'svn':      '%s',
      \ 'hg':       'hg diff %s',
      \ }
let g:signify_vcs_cmds_diffmode = {
      \ 'hg':       'hg cat %s',
      \ }
  ]],
		git_cmd,
		rcs_cmd,
		svn_cmd,
		hg_args,
		hg_args
	))
end

_G.signify_dtup = function()
	setup_mercurial('-r ".^" %f')
	vim.cmd([[:SignifyRefresh]])
end

_G.signify_normal = function()
	setup_mercurial("--color=never config aliases.diff= --nodates -U0 -- %f")
	vim.cmd([[:SignifyRefresh]])
end

_G.signify_dtp4 = function()
	setup_mercurial('-r "p4base" %f')
	vim.cmd([[:SignifyRefresh]])
end

_G.signify_dtex = function()
	setup_mercurial('-r "exported(.)" %f')
	vim.cmd([[:SignifyRefresh]])
end

return {
	"mhinz/vim-signify",
	event = "VimEnter",
	keys = {
		{ "]d", "<plug>(signify-next-hunk)" },
		{ "[d", "<plug>(signify-prev-hunk)" },
		{ "<leader>sd", ":SignifyDiff<CR>" },
		{ "<leader>sn", ":lua signify_normal()<CR>" },
		{ "<leader>sup", ":lua signify_dtup()<CR>" },
		{ "<leader>sex", ":lua signify_dtex()<CR>" },
		{ "<leader>sp4", ":lua signify_dtp4()<CR>" },
	},
	config = function()
		vim.g.signify_vcs_list = { "hg", "git" }
		-- vim.g.signify_sign_change = "*"
		-- vim.g.signify_sign_delete = "-"
		-- vim.g.signify_line_highlight = 0
		vim.g.signify_sign_add = "┃"
		vim.g.signify_sign_delete = "┃"
		vim.g.signify_sign_change = "┃"
		vim.api.nvim_set_hl(0, "SignifySignAdd", { ctermfg = "green", fg = "#79b7a5" })
		vim.api.nvim_set_hl(0, "SignifySignChange", { ctermfg = "yellow", fg = "#ffffcc" })
		vim.api.nvim_set_hl(0, "SignifySignChangeDelete", { ctermfg = "red", fg = "#ff7b72" })
		vim.api.nvim_set_hl(0, "SignifySignDelete", { ctermfg = "red", fg = "#ff7b72" })
		vim.api.nvim_set_hl(0, "SignifySignDeleteDeleteFirstLine", { ctermfg = "red", fg = "#ff7b72" })
		-- vim.cmd("highlight SignColumn ctermbg=NONE cterm=NONE guibg=NONE gui=NONE")
	end,
}
