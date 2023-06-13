local use_google = require("utils").use_google

local function goog(plugin, config)
    return {
        name = plugin,
        dir = "/usr/share/vim/google/" .. plugin,
        dependencies = { "maktaba" },
        config = config,
    }
end

if use_google() then
    return {
        {
            name = "maktaba",
            dir = "/usr/share/vim/google/maktaba",
            init = function ()
                vim.cmd("source /usr/share/vim/google/glug/bootstrap.vim")
            end,
        },
        goog("core"),
        goog("glaive"),
        goog("alert"),
        goog("csearch"),
        goog("codefmt-google"),
        goog("languages"),
        goog("googlestyle"),
        goog("googlespell"),
        goog("googlepaths"),
        goog("google-filetypes"),
        goog("ft-java"),
        goog("ft-kotlin"),
        goog("ft-proto"),
        goog("critique"),
        goog("piper"),
        goog("gtimporter"),
        goog("blaze"),
        goog("buganizer"),
        goog("relatedfiles"),
        goog("g4"),
        goog("outline-window"),
        goog("fzf-query"),
        {
            name = "codefmt",
            dir = "/usr/share/vim/google/codefmt",
            dependencies = { "maktaba", "glaive" },
            config = function()
                vim.cmd([[Glaive codefmt ktfmt_executable=`["/google/bin/releases/kotlin-google-eng/ktfmt/ktfmt_deploy.jar", "--google-style"]`]])
            end
        },
        {
            name = "imp-google",
            dir = "/usr/share/vim/google/imp-google",
            dependencies = { "maktaba", "vim-imp", "glaive" },
            config = function()
                require("config.imp-google")
            end,
        },
        {
            "flwyd/vim-imp",
            dependencies = {"imp-google"},
            keys = {
                { "<leader>ii", ":ImpSuggest <C-r><C-w><cr>" },
            }
        },
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
            dependencies = {'rcarriga/nvim-notify', 'nvim-lua/plenary.nvim'},
            config = function()
                require("config.google-comments")
            end,
        },
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
else
    return {}
end

