local use_google = require("utils").use_google

return
{
    -- Pretty symbols
    'kyazdani42/nvim-web-devicons',

    'jghauser/mkdir.nvim',
    'lewis6991/impatient.nvim',
    'dstein64/vim-startuptime',
    'will133/vim-dirdiff',
    'renerocksai/calendar-vim',
    'google/vim-searchindex',
    'apalmer1377/factorus',
    'hrsh7th/vim-vsnip',
    'kosayoda/nvim-lightbulb',
    'tpope/vim-surround',
    'ntpeters/vim-better-whitespace',
    'junegunn/fzf.vim',
    'nathanaelkane/vim-indent-guides',
    'tversteeg/registers.nvim',
    'jremmen/vim-ripgrep',
    'nvim-lua/plenary.nvim',

    {
        'preservim/nerdcommenter',
        init = function()
            require("config.nerdcommenter")
        end,
        keys = {
            { "<leader>c<Space>", ":call nerdcommenter#Comment(0, 'toggle')<CR>" },
            { "<leader>c<Space>", ":call nerdcommenter#Comment(0, 'toggle')<CR>", mode='v' },

            { "<leader>cS", ":call nerdcommenter#Comment(0, 'sexy')<CR>" },
            { "<leader>cS", ":call nerdcommenter#Comment(0, 'sexy')<CR>", mode='v' },

            { "<leader>c$", ":call nerdcommenter#Comment(0, 'ToEOL')<CR>" },
            { "<leader>c$", ":call nerdcommenter#Comment(0, 'ToEOL')<CR>", mode='v' },
        }
    },
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

    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    'nvim-lua/lsp-status.nvim',
    'VonHeikemen/lsp-zero.nvim',

    -- Completion and linting
    {
        'hrsh7th/nvim-cmp',
        event = "VimEnter",

        dependencies = {
            'onsails/lspkind.nvim',
            'neovim/nvim-lspconfig',
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
        event = "VimEnter",
        keys = {
          { "<leader>l", function() require("lsp_lines").toggle() end, desc = "Toggle LSP Lines" },
        },
    },
    {
        'jose-elias-alvarez/null-ls.nvim',
        event = "VimEnter",
        config = function()
            require("config.null-ls")
        end
    },

    {
        'nvim-telescope/telescope.nvim',
        branch = '0.1.x',
        config = function()
            require("config.telescope")
        end,
        dependencies = {
            "telescope_codesearch",
            "telescope_citc",
            "telescope_fig",
            'nvim-telescope/telescope-file-browser.nvim',
        },
        keys = {
            { '<leader>tb', ":Telescope file_buffers", desc = '[T]elescope [B]uffers' } ,
            { '<leader>tf', [[:lua require('telescope.builtin').find_files{ find_command = {'rg', '--files', '--hidden', '-g', '!node_modules/**'} }<cr>]], desc = '[T]elescope [F]iles' },
            { '<leader>th', [[:lua require('telescope.builtin').help_tags<cr>]],  desc = '[T]elescope [H]elp' },
            { '<leader>tw', [[:lua require('telescope.builtin').grep_string<cr>]],  desc = '[T]elescope current [W]ord' },
            { '<leader>tg', [[:lua require('telescope.builtin').live_grep<cr>]],  desc = '[T]elescope by [G]rep' },
            -- Google mappings
            { '<C-P>', [[:lua require('telescope').extensions.codesearch.find_files{}<CR>]],'n', { noremap = true, silent=true }},
            { '<C-Space>', [[:lua require('telescope').extensions.codesearch.find_query{}<CR>]], { noremap = true, silent = true }},
            { '<leader>cs', [[:lua require('telescope').extensions.codesearch.find_query{}<CR>]], { noremap = true, silent = true }},
            { '<leader>cs', [[:lua require('telescope').extensions.codesearch.find_query{}<CR>]], mode='v', { noremap = true, silent = true }},
            { '<leader>CS', [[:lua require('telescope').extensions.codesearch.find_query{default_text_expand='<cword>'}<CR>]], { noremap = true, silent = true } },
        },
    },

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
        event = "VimEnter",
        config = function()
            require("config.trouble")
        end,
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

    { 'simrat39/symbols-outline.nvim',
        config = function()
            require("config.symbols-outline")
        end
    },
    {
        'petertriho/nvim-scrollbar',
        config = function()
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
        'squk/java-syntax.vim',
        lazy = false,
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
        init = function()
            vim.g.mkdp_filetypes = { "markdown" }
        end,
        ft = { "markdown" }
    },
}
