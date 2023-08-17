return {
	"smartpde/neoscopes",
	config = function()
		require("neoscopes").setup({
			scopes = {
				{
					name = "apkdiff",
					dirs = {
						"java/com/google/android/gmscore/tools/earlycheckin/apkdiff",
						"javatests/com/google/android/gmscore/tools/earlycheckin/apkdiff",
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
