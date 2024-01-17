return {
	"glacambre/firenvim",

	-- Lazy load firenvim
	-- Explanation: https://github.com/folke/lazy.nvim/discussions/463#discussioncomment-4819297
	config = function()
		vim.g.firenvim_config = {
			localSettings = {
				[ [[.*]] ] = {
					cmdline = "firenvim",
					priority = 0,
					selector = 'textarea:not([readonly]):not([class="handsontableInput"]), div[role="textbox"]',
					takeover = "always",
				},
				[ [[.*notion\.so.*]] ] = {
					priority = 9,
					takeover = "never",
				},
				[ [[.*docs\.google\.com.*]] ] = {
					priority = 9,
					takeover = "never",
				},
				[ [[google\.com.*]] ] = {
					priority = 9,
					takeover = "never",
				},
				[ [[twitch\.tv.*]] ] = {
					priority = 9,
					takeover = "never",
				},
			},
		}
	end,
	lazy = not vim.g.started_by_firenvim,
	build = function()
		vim.fn["firenvim#install"](0)
	end,
}
