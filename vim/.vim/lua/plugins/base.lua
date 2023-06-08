local use_google = require("utils").use_google

return
{
    -- Pretty symbols
    'kyazdani42/nvim-web-devicons',

    'nvim-lua/lsp-status.nvim',
    'jghauser/mkdir.nvim',
    'lewis6991/impatient.nvim',
    'dstein64/vim-startuptime',
    'will133/vim-dirdiff',
    'renerocksai/calendar-vim',
    'google/vim-searchindex',
    'apalmer1377/factorus',
    'hrsh7th/vim-vsnip',
    'kosayoda/nvim-lightbulb',

    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    'VonHeikemen/lsp-zero.nvim',

    'tpope/vim-surround',
    'scrooloose/nerdcommenter',
    'ntpeters/vim-better-whitespace',
    'junegunn/fzf.vim',
    'nathanaelkane/vim-indent-guides',
    'tversteeg/registers.nvim',
    'jremmen/vim-ripgrep',
    'nvim-lua/plenary.nvim',


    {
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate',
        config = function()
            require("config.nvim-treesitter")
        end,
        lazy = false,
    },

    {
      "nvim-neo-tree/neo-tree.nvim",
        branch = "v2.x",
        config = function()
            require("config.neotree")
        end,
        dependencies = {
          "nvim-lua/plenary.nvim",
          "MunifTanjim/nui.nvim",
        },
        keys = {
          { "<C-n>", ":Neotree filesystem reveal toggle reveal_force_cwd<cr>", desc = "Open NeoTree" },
        },
      },

    -- Undo tree
    {
        'mbbill/undotree',
        cmd = 'UndotreeToggle',
        config = function()
            vim.g.undotree_SetFocusWhenToggle = 1
        end
    },

    {
        'renerocksai/telekasten.nvim',
        config = function()
            require("config.telekasten")
        end,
        keys = {
          { "<leader>zf", ":lua require('telekasten').find_notes()<CR>", desc = "Find Notes" },
        },
    },
    { 'ray-x/go.nvim',ft='go' },
    { 'ray-x/guihua.lua',ft='go' },

    -- Completion and linting
    'neovim/nvim-lspconfig',
    {
        'hrsh7th/nvim-cmp',
        event = "InsertEnter",

        dependencies = {
            'onsails/lspkind.nvim',
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-buffer',
            'lukas-reineke/cmp-under-comparator',
            'hrsh7th/cmp-cmdline',
            'f3fora/cmp-spell',
            'hrsh7th/cmp-nvim-lsp-document-symbol',
            'hrsh7th/cmp-nvim-lsp-signature-help',
            'hrsh7th/cmp-nvim-lua',
            'hrsh7th/cmp-path',
            'hrsh7th/cmp-vsnip',
            'ray-x/cmp-treesitter',
        },
        config = function()
            require("config.lsp")
        end
    },
    {
        "tzachar/cmp-tabnine", build = "./install.sh",
        event = 'InsertEnter',
        cond = not use_google(),
    },
    {
        'ErichDonGubler/lsp_lines.nvim',
        event = "InsertEnter",
        config = function()
            require("lsp_lines").setup()
        end
    },
    {
        'jose-elias-alvarez/null-ls.nvim',
        event = "InsertEnter",
        config = function()
            require("config.null-ls")
        end
    },

    {
        'nvim-telescope/telescope.nvim',
        branch = '0.1.x',
        config = function()
            require("config.telescope")
        end
    },
    'nvim-telescope/telescope-file-browser.nvim',

    -- Rust
    {
        'saecki/crates.nvim',
        ft = 'rust',
        version = 'v0.3.0',
        dependencies = { 'nvim-lua/plenary.nvim' },
        config = function()
            require('crates').setup()
        end
    },

    {'simrat39/rust-tools.nvim', ft = 'rust'},

    {
        'folke/trouble.nvim',
        config = function()
            require("config.trouble")
        end
    },

    {
        'ThePrimeagen/refactoring.nvim',
         dependencies = {
            {"nvim-lua/plenary.nvim"},
            {"nvim-treesitter/nvim-treesitter"}
        },
        config = function()
            require("config.refactoring")
        end
    },
    {'andymass/vim-matchup', event = 'VimEnter'},

    { 'simrat39/symbols-outline.nvim', config = function()
        require("config.symbols-outline")
    end
},
    {
        'petertriho/nvim-scrollbar', config = function()
        require("scrollbar").setup()
        end,
        lazy = false,
},

    {
        'rmagatti/auto-session',
        config = function()
            require("auto-session").setup {
                log_level = "error",
                auto_session_suppress_dirs = { "~/", "~/Downloads", "/", os.getenv("HOME")},
            }
        end
    },


    {
        "ipod825/libp.nvim",
        config = function()
            require("libp").setup()
        end,
    },

    {
        'nvim-lualine/lualine.nvim',
        lazy = false,
        config = function()
            require("config.lualine")
        end
    },
    {
        'rcarriga/nvim-notify',
        config = function()
            require("config.notify")
        end
    },

    -- Git
    {
        {
            'lewis6991/gitsigns.nvim',
            dependencies = 'nvim-lua/plenary.nvim',
            event = 'User ActuallyEditing',
        },
        {
            'akinsho/git-conflict.nvim',
            version = '*',
            config = function()
                require('git-conflict').setup()
            end,
        },
        { 'rhysd/conflict-marker.vim' }
    },

    {
        "catppuccin/nvim",
    name = "catppuccin",
        lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
        require("config.catppuccin")
        end
    },
    {
        'ojroques/nvim-osc52',
        config = function()
            require("config.oscyank")
        end
    },

    -- mine
    {
        'squk/java-syntax.vim', ft='java'
    },

    {
        "folke/which-key.nvim",
        config = function()
            require("config.whichkey")
        end
    },
    { 'junegunn/fzf', build = ":call fzf#install()" },

    { 'udalov/kotlin-vim', ft='kotin' },

    {
        'wesQ3/vim-windowswap',
        init = function()
            vim.g.windowswap_map_keys = 0
        end,
    },

    { 'vim-scripts/vcscommand.vim' },
    {
        'mhinz/vim-signify',
        config= function()
            require('config.signify')
        end
    },

    {
        'j-hui/fidget.nvim',
        init = function() require("fidget").setup() end
    },
    {
        "iamcco/markdown-preview.nvim",
        build = "cd app && npm install",
        setup = function()
            vim.g.mkdp_filetypes = { "markdown" }
        end,
        ft = { "markdown" }
    },
}
