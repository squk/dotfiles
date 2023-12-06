local use_google = require("utils").use_google

local function setup_mercurial(hg_cmd)
	local git_cmd = "git diff --no-color --no-ext-diff -U0 -- %f"
	local rcs_cmd = "rcsdiff -U0 %f 2>%n"
	local svn_cmd = "svn diff --diff-cmd %d -x -U0 -- %f"
	vim.cmd(string.format(
		[[
let g:signify_vcs_cmds = {
      \ 'git':      '%s',
      \ 'hg':       '%s',
      \ 'rcs':      '%s',
      \ 'svn':      '%s',
      \ }
  ]],
		git_cmd,
		hg_cmd,
		rcs_cmd,
		svn_cmd
	))
end

_G.signify_dtup = function()
	setup_mercurial('hg diff -r ".^" %f')
	vim.cmd([[:SignifyRefresh]])
end

_G.signify_dtp4 = function()
	setup_mercurial('hg diff -r "p4base" %f')
	vim.cmd([[:SignifyRefresh]])
end

_G.signify_dtex = function()
	setup_mercurial('hg diff -r "exported(.)" %f')
	vim.cmd([[:SignifyRefresh]])
end

return {
	"mhinz/vim-signify",
	event = "VimEnter",
	keys = {
		{ "]d", "<plug>(signify-next-hunk)" },
		{ "[d", "<plug>(signify-prev-hunk)" },
		{ "<leader>sd", ":SignifyDiff<CR>" },
		{ "<leader>sup", ":lua signify_dtup()<CR>" },
		{ "<leader>sex", ":lua signify_dtex()<CR>" },
		{ "<leader>sp4", ":lua signify_dtp4()<CR>" },
	},
	config = function()
		vim.g.signify_vcs_list = { "hg", "git" }
		-- vim.g.signify_sign_change = "*"
		vim.g.signify_sign_delete = "-"
	end,
}
