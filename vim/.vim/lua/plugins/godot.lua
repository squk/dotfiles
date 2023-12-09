local use_google = require("utils").use_google
return {
	{
		"habamax/vim-godot",
		cond = not use_google(),
	},
}
