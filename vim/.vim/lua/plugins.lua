local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
local use_google = require("utils").use_google
if fn.empty(fn.glob(install_path)) > 0 then
    packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.o.runtimepath = vim.fn.stdpath('data') .. '/site/pack/*/start/*,' .. vim.o.runtimepath
end

vim.cmd([[
augroup packer_user_config
autocmd!
autocmd BufWritePost plugins.lua source <afile> | PackerCompile
augroup end
]])

require('lspconfig')

require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'
    use 'lewis6991/impatient.nvim'
    use 'dstein64/vim-startuptime'

    use {
        'google/vim-maktaba',
        config = [[ vim.cmd("call glaive#Install()")]],
        disable = use_google(),
        after  =  {
            'flwyd/vim-imp',
        }
    }
    use {
        'flwyd/vim-imp',
        disable = use_google(),
    }
    use {
        'google/vim-glaive',
        disable = use_google(),
    }

    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate',
        config =[[ require("config.nvim-treesitter") ]]
    }

    use {
        'nvim-tree/nvim-tree.lua',
        config =[[ require("config.nvim-tree") ]]
    }

    -- Undo tree
    use {
        'mbbill/undotree',
        cmd = 'UndotreeToggle',
        config = [[vim.g.undotree_SetFocusWhenToggle = 1]],
    }

    use 'nvim-lua/plenary.nvim'
    use {
        'renerocksai/telekasten.nvim',
        config = [[ require("config.telekasten") ]]
    }
    use 'renerocksai/calendar-vim'

    use 'google/vim-searchindex'
    use { 'ray-x/go.nvim',ft='go' }
    use { 'ray-x/guihua.lua',ft='go' }

    -- Pretty symbols
    use 'kyazdani42/nvim-web-devicons'

    use({"L3MON4D3/LuaSnip", tag = "v<CurrentMajor>.*"})

    -- Completion and linting
    use 'neovim/nvim-lspconfig'
    use {
        'hrsh7th/nvim-cmp',
        requires = {
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
            { 'saadparwaiz1/cmp_luasnip', after = {'LuaSnip'} },
        },
        config = [[ require("config.lsp") ]],
        -- event = 'InsertEnter',
    }
    use {
        "tzachar/cmp-tabnine", run = "./install.sh",
        cond = not use_google(),
    }
    use { 'ErichDonGubler/lsp_lines.nvim', config = [[ require("lsp_lines").setup() ]] }
    use {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        'VonHeikemen/lsp-zero.nvim',
    }
    use {
        'jose-elias-alvarez/null-ls.nvim',
        config = [[ require("config.null-ls") ]]
    }

    -- Rust
    use {
        'saecki/crates.nvim',
        ft = 'rust',
        tag = 'v0.3.0',
        requires = { 'nvim-lua/plenary.nvim' },
        config = [[ require('crates').setup() ]]
    }
    use {'simrat39/rust-tools.nvim', ft = 'rust'}

    use {
        'folke/trouble.nvim',
        config = [[ require("config.trouble")]]
    }

    use {
        'ThePrimeagen/refactoring.nvim',
        config = [[ require("config.refactoring")]]
    }
    use 'apalmer1377/factorus'

    -- use {
        --     'mfussenegger/nvim-dap',
        --     'mfussenegger/nvim-jdtls',
        --     ft = {'java','kotlin'},
        --     config = [[ require("config.dap")]],
        -- }

        use 'hrsh7th/vim-vsnip'
        use 'kosayoda/nvim-lightbulb'
        use {'andymass/vim-matchup', event = 'VimEnter'}

        use 'jghauser/mkdir.nvim'
        use { 'simrat39/symbols-outline.nvim', config = [[ require("config.symbols-outline") ]]  }
        use { 'petertriho/nvim-scrollbar', config = [[ require("scrollbar").setup() ]] }

        use {
            'nvim-telescope/telescope.nvim',
            branch = '0.1.x',
            config = [[ require("config.telescope") ]]
        }
        use 'nvim-telescope/telescope-file-browser.nvim'

        use {
            'rmagatti/auto-session',
            config = function()
                require("auto-session").setup {
                    log_level = "error",
                    auto_session_suppress_dirs = { "~/", "~/Downloads", "/", os.getenv("HOME")},
                }
            end
        }

        use {
            'sso://googler@user/piloto/cmp-nvim-ciderlsp',
            'sso://googler@user/kdark/ciderlsp-nvim',
            'sso://googler@user/vintharas/telescope-codesearch.nvim',
            'sso://googler@user/aktau/telescope-citc.nvim',
            'sso://googler@user/tylersaunders/telescope-fig.nvim',

            cond = use_google(),
        }

        use {
            'sso://googler@user/chmnchiang/google-comments',
            -- '/google/src/head/depot/google3/experimental/users/chmnchiang/neovim/google-comments',
            -- '/google/src/cloud/cnieves/google-comments/google3/experimental/users/chmnchiang/neovim/google-comments',
            cond = use_google(),
            requires = {'rcarriga/nvim-notify', 'nvim-lua/plenary.nvim'},
            config = [[ require("config.google-comments") ]]
        }

        use {
            '/google/src/cloud/cnieves/google-comments/google3/experimental/users/cnieves/neovim/critique',
            cond = use_google(),
            config = [[ require("critique").setup() ]]
        }

        use {
            "ipod825/libp.nvim",
            config = function()
                require("libp").setup()
            end,
        }
        use {
            "sso://googler@user/jackcogdill/nvim-figtree",
            cond = use_google(),
        }
        use {
            "sso://googler@user/smwang/hg.nvim",
            requires =  { "ipod825/libp.nvim" },
            config = function()
                require("config.fig")
                require("hg").setup()
            end,
            cond = use_google(),
        }

        use 'nvim-lua/lsp-status.nvim'
        use {
            'nvim-lualine/lualine.nvim',
            config = [[ require("config.lualine") ]]
        }
        use {
            'rcarriga/nvim-notify',
            config = [[ require("config.notify") ]]
        }

        -- Git
        use {
            {
                'lewis6991/gitsigns.nvim',
                requires = 'nvim-lua/plenary.nvim',
                config = [[require('config.gitsigns')]],
                event = 'User ActuallyEditing',
            },
            -- { 'TimUntersberger/neogit', cmd = 'Neogit', config = [[require('config.neogit')]] },
            {
                'akinsho/git-conflict.nvim',
                tag = '*',
                config = [[require('git-conflict').setup()]]
            },
            { 'rhysd/conflict-marker.vim' }
        }

        -- use { "catppuccin/nvim", as = "catppuccin" }
        use { "catppuccin/nvim", as = "catppuccin", config = [[require("config.catppuccin")]]}
        -- Tmux
        use {
            'preservim/vimux',
            'tmux-plugins/vim-tmux',
            'christoomey/vim-tmux-navigator',
            'whatyouhide/vim-tmux-syntax',
            'tmux-plugins/vim-tmux-focus-events',
            'jabirali/vim-tmux-yank',
            'skywind3000/asyncrun.vim',
        }
        use {
            'ojroques/nvim-osc52',
            config = [[ require("config.oscyank") ]]
        }

        -- mine
        use {
            'squk/java-syntax.vim', ft='java'
        }

        use {
            "folke/which-key.nvim",
            config = [[require("config.whichkey")]]
        }

        use 'ntpeters/vim-better-whitespace'
        use 'junegunn/fzf.vim'
        use { 'junegunn/fzf', run = ":call fzf#install()" }

        vim.opt.rtp:append(os.getenv("HOME") .. "/.fzf")

        use 'nathanaelkane/vim-indent-guides'
        use 'tversteeg/registers.nvim'

        use 'jremmen/vim-ripgrep'

        -- use 'preservim/nerdtree'
        -- use 'tiagofumo/vim-nerdtree-syntax-highlight'

        use { 'udalov/kotlin-vim', ft='kotin' }

        use {
            'wesQ3/vim-windowswap',
            setup = [[ vim.g.windowswap_map_keys = 0 ]]
        }

        use 'tpope/vim-surround'
        use 'scrooloose/nerdcommenter'

        use {
            'mhinz/vim-signify',
            config= [[require('config.signify')]]
        }

        use { 'j-hui/fidget.nvim', config = [[require("fidget").setup()]] }
        use({ "iamcco/markdown-preview.nvim", run = "cd app && npm install", setup = function() vim.g.mkdp_filetypes = { "markdown" } end, ft = { "markdown" }, })


        -- Automatically set up your configuration after cloning packer.nvim
        -- Put this at the end after all plugins
        if packer_bootstrap then
            require('packer').sync()
        end
    end)

    -- CiderLSP
    vim.opt.completeopt = { "menu", "menuone", "noselect" }
    -- Don't show the dumb matching stuff
    vim.opt.shortmess:append("c")

    vim.opt.spell = true
    vim.opt.spelllang = { 'en_us' }

    require("config.imp")
