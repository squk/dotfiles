local map = require("utils").map

if vim.fn.hostname() == "goblin" then
	vim.g.clipboard = {
		name = "wayland",
		copy = {
			["+"] = { "wl-copy" },
			["*"] = { "wl-copy" },
		},
		paste = {
			["+"] = { "wl-paste" },
			["*"] = { "wl-paste" },
		},
		cache_enabled = false,
	}
else
  if vim.env.SSH_TTY or vim.env.SSH_CLIENT or vim.env.SSH_CONNECTION then
	  vim.g.clipboard = {
		  name = "lemonade",
		  copy = {
			  ["+"] = { "lemonade", "copy" },
			  ["*"] = { "lemonade", "copy" },
		  },
		  paste = {
			  ["+"] = { "lemonade", "paste" },
			  ["*"] = { "lemonade", "paste" },
		  },
		  cache_enabled = false,
	  }
  end
end

map("v", "<leader>y", '"+y')
map("v", "<leader>Y", '"*y')
