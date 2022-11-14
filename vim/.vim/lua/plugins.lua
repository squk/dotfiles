local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
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


local file_exists = require("utils").file_exists

require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }

    -- Undo tree
    use {
        'mbbill/undotree',
        cmd = 'UndotreeToggle',
        config = [[vim.g.undotree_SetFocusWhenToggle = 1]],
    }

    use 'nvim-lua/plenary.nvim'

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
            'williamboman/nvim-lsp-installer',
            'hrsh7th/cmp-cmdline',
            'f3fora/cmp-spell',
            'hrsh7th/cmp-nvim-lsp-document-symbol',
            'hrsh7th/cmp-nvim-lsp-signature-help',
            'hrsh7th/cmp-nvim-lua',
            'hrsh7th/cmp-path',
            'hrsh7th/cmp-vsnip',
            { 'saadparwaiz1/cmp_luasnip', after = {'LuaSnip'} },
        },
        -- config = [[require('lsp')]],
        -- event = 'InsertEnter',
    }
    use 'folke/trouble.nvim'

    use 'hrsh7th/vim-vsnip'
    use 'kosayoda/nvim-lightbulb'
    use {'andymass/vim-matchup', event = 'VimEnter'}
    use { 'ErichDonGubler/lsp_lines.nvim', config = [[require("lsp_lines").setup()]] }

    use 'jghauser/mkdir.nvim'
    use { 'simrat39/symbols-outline.nvim' }
    use { 'petertriho/nvim-scrollbar', config = [[require("scrollbar").setup()]] }

    use {
        'nvim-telescope/telescope.nvim' , branch = '0.1.x',
        requires = { {'nvim-lua/plenary.nvim'} }
    }

    use {
        'rmagatti/auto-session',
        config = function()
            require("auto-session").setup {
                log_level = "error",
                auto_session_suppress_dirs = { "~/", "~/Downloads", "/"},
            }
        end
    }

    use {
        'sso://googler@user/vintharas/telescope-codesearch.nvim',
        cond = file_exists(os.getenv("HOME").."/use_google"),
    }

    use {
        -- 'sso://googler@user/chmnchiang/google-comments',
        -- '/google/src/head/depot/google3/experimental/users/chmnchiang/neovim/google-comments',
        '/google/src/cloud/cnieves/google-comments/google3/experimental/users/chmnchiang/neovim/google-comments',
        cond = file_exists(os.getenv("HOME").."/use_google"),
        requires = {'rcarriga/nvim-notify', 'nvim-lua/plenary.nvim'},
        config = [[ require("google_comments") ]]
    }

    use {
        '/google/src/cloud/cnieves/google-comments/google3/experimental/users/cnieves/neovim/critique',
        config = [[ require("critique").setup() ]]
    }

    use {
        'nvim-lualine/lualine.nvim',
        config = [[ require("lualine_config") ]]
    }
    use {
        'rcarriga/nvim-notify',
        config = [[ require("notify_config") ]]
    }

    -- Git
    use {
        {
            'lewis6991/gitsigns.nvim',
            requires = 'nvim-lua/plenary.nvim',
            config = [[require('config.gitsigns')]],
            event = 'User ActuallyEditing',
        },
        { 'TimUntersberger/neogit', cmd = 'Neogit', config = [[require('config.neogit')]] },
        {
            'akinsho/git-conflict.nvim',
            tag = '*',
            config = [[require('git-conflict').setup()]]
        }
    }

    -- use { "catppuccin/nvim", as = "catppuccin" }
    use { "catppuccin/nvim", as = "catppuccin", config = [[require("catppuccin-config")]]}

    -- mine
    use {
        'squk/vim-quantum',
        'squk/java-syntax.vim'
    }

    use 'ntpeters/vim-better-whitespace'
    use 'junegunn/fzf.vim'
    vim.opt.rtp:append(os.getenv("HOME") .. "/.fzf")

    use 'nathanaelkane/vim-indent-guides'
    use 'tversteeg/registers.nvim'

    use 'preservim/vimux'
    use 'tmux-plugins/vim-tmux'
    use 'christoomey/vim-tmux-navigator'
    use 'whatyouhide/vim-tmux-syntax'
    use 'skywind3000/asyncrun.vim'

    use 'christoomey/vim-titlecase'
    use 'chiedo/vim-case-convert'

    use 'jremmen/vim-ripgrep'

    use 'preservim/nerdtree'
    use 'tiagofumo/vim-nerdtree-syntax-highlight'

    use 'udalov/kotlin-vim'

    use 'tmux-plugins/vim-tmux-focus-events'
    use 'tpope/vim-obsession'
    use 'Valloric/MatchTagAlways'
    use 'wesQ3/vim-windowswap'

    use 'tpope/vim-surround'
    use 'scrooloose/nerdcommenter'
    use 'mhinz/vim-signify'
    use { 'j-hui/fidget.nvim', config = [[require("fidget").setup()]] }

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if packer_bootstrap then
        require('packer').sync()
    end
end)

-- CiderLSP
vim.opt.completeopt = { "menu", "menuone", "noselect" }

require('lspconfig')
require("lsp")
require("diagnostics")
require("treesitter")
require("telescope_config")
require("symbols-outline-config")
require("spell_config")

-- redundant w/ lsp_lines
vim.diagnostic.config({
    virtual_text = false,
})