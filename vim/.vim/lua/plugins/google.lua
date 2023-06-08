local use_google = require("utils").use_google

return {
    {
        name = "ai.nvim",
        url = 'sso://googler@user/vvvv/ai.nvim',
    },
    {
        name = "cmp_nvim_ciderlsp",
        url = 'sso://googler@user/piloto/cmp-nvim-ciderlsp',
        lazy = false;
        dependencies = {
            'hrsh7th/nvim-cmp',
        }
    },
    {
        name = "ciderlsp_nvim",
        url = 'sso://googler@user/kdark/ciderlsp-nvim',
        lazy = false;
        dependencies = {
            'hrsh7th/nvim-cmp',
        }
    },
    {
        name = "nvim_figtree",
        url = "sso://googler@user/jackcogdill/nvim-figtree",
    },
    {
        name = "telescope_codesearch",
        url = 'sso://googler@user/vintharas/telescope-codesearch.nvim',
        dependencies = { 'nvim-telescope/telescope.nvim' },
    },
    {
        name = "telescope_citc",
        url = 'sso://googler@user/aktau/telescope-citc.nvim',
        dependencies = { 'nvim-telescope/telescope.nvim' }
    },
    {
        name = "telescope_fig",
        url = 'sso://googler@user/tylersaunders/telescope-fig.nvim',
        dependencies = { 'nvim-telescope/telescope.nvim' }
    },
    {
        name = "google_comments",
        url = 'sso://googler@user/chmnchiang/google-comments',
        -- '/google/src/head/depot/google3/experimental/users/chmnchiang/neovim/google-comments',
        -- '/google/src/cloud/cnieves/google-comments/google3/experimental/users/chmnchiang/neovim/google-comments',
        dependencies = {'rcarriga/nvim-notify', 'nvim-lua/plenary.nvim'},
        config = function()
            require("config.google-comments")
        end,
    },

    -- {
    --     '/google/src/cloud/cnieves/google-comments/google3/experimental/users/cnieves/neovim/critique',
    --     config = [[ require("critique").setup() ]]
    -- },

    {
        name = "hg",
        url = "sso://googler@user/smwang/hg.nvim",
        dependencies =  { "ipod825/libp.nvim" },
        config = function()
            require("config.fig")
            require("hg").setup()
        end,
    }
}
    -- {
    --     'google/vim-glaive',
    --     after  =  {
    --         'google/vim-maktaba',
    --     }
    --     -- disable = use_google(),
    --     -- cond = not use_google(),
    -- }
    -- {
    --     'google/vim-maktaba',
    --     -- disable = use_google(),
    --     -- cond = not use_google(),
    -- }
    -- {
    --     'flwyd/vim-imp',
    --     disable = use_google(),
    --     -- cond = not use_google(),
    --     after  =  {
    --         'google/vim-maktaba',
    --         'google/vim-glaive',
    --     }
    -- }
