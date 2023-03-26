local M = {}
function M.config(use)
    use {
        'sso://googler@user/piloto/cmp-nvim-ciderlsp',
        'sso://googler@user/kdark/ciderlsp-nvim',
        "sso://googler@user/jackcogdill/nvim-figtree",
    }
    use {
        'sso://googler@user/vintharas/telescope-codesearch.nvim',
        after = { 'nvim-telescope/telescope.nvim' }
    }
    use {
        'sso://googler@user/aktau/telescope-citc.nvim',
        after = { 'nvim-telescope/telescope.nvim' }
    }
    use {
        'sso://googler@user/tylersaunders/telescope-fig.nvim',
        after = { 'nvim-telescope/telescope.nvim' }
    }

    use {
        'sso://googler@user/chmnchiang/google-comments',
        -- '/google/src/head/depot/google3/experimental/users/chmnchiang/neovim/google-comments',
        -- '/google/src/cloud/cnieves/google-comments/google3/experimental/users/chmnchiang/neovim/google-comments',
        requires = {'rcarriga/nvim-notify', 'nvim-lua/plenary.nvim'},
        config = [[ require("config.google-comments") ]]
    }

    use {
        '/google/src/cloud/cnieves/google-comments/google3/experimental/users/cnieves/neovim/critique',
        config = [[ require("critique").setup() ]]
    }
    use {
        "sso://googler@user/smwang/hg.nvim",
        requires =  { "ipod825/libp.nvim" },
        config = function()
            require("config.fig")
            require("hg").setup()
        end,
    }
end
return M
