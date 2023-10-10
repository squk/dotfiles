return {
	"smartpde/neoscopes",
	config = function()
		require("neoscopes").setup({
			scopes = {
				{
					name = "earlycheckin",
					dirs = {
						"java/com/google/android/gmscore/tools/earlycheckin/",
						"javatests/com/google/android/gmscore/tools/earlycheckin/",
					},
				},
				{ name = "experimental", dirs = { "experimental/users/cnieves" } },
			},
			-- add_dirs_to_all_scopes = {
			--     "~/dotfiles",
			-- },
		})

		local scopes = require("neoscopes")
		scopes.add_startup_scope()
	end,
}
