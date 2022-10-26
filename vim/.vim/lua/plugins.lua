local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
    packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.o.runtimepath = vim.fn.stdpath('data') .. '/site/pack/*/start/*,' .. vim.o.runtimepath
end

local packerGroup = vim.api.nvim_create_augroup("packer_auto_compile", { clear = true })
vim.api.nvim_create_autocmd("BufWritePost", {
    pattern = "*/vim/lua/plugins.lua",
    command = "source <afile> | PackerCompile",
    group = packerGroup,
})

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
            'hrsh7th/cmp-cmdline',
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

    use {
        'LucHermitte/vim-refactor',
        requires = {
            'LucHermitte/lh-vim-lib',
            'LucHermitte/lh-tags',
            'LucHermitte/lh-dev',
            'LucHermitte/lh-style',
            'LucHermitte/lh-brackets',
        },
        cmd = 'ExtractFunction'
    }

    use 'hrsh7th/vim-vsnip'
    use 'kosayoda/nvim-lightbulb'
    use {'andymass/vim-matchup', event = 'VimEnter'}
    use { 'ErichDonGubler/lsp_lines.nvim', config = [[require("lsp_lines").setup()]] }

    use 'jghauser/mkdir.nvim'
    use 'simrat39/symbols-outline.nvim'
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
    use 'sso://googler@user/vintharas/telescope-codesearch.nvim'
    use 'nvim-lualine/lualine.nvim'
    use 'rcarriga/nvim-notify'

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

    use { "catppuccin/nvim", as = "catppuccin"}

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

    use 'airblade/vim-gitgutter'
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
require("lualine_config")
require("notify_config")
require("catppuccin-config")
require("symbols-outline-config")

-- redundant w/ lsp_lines
vim.diagnostic.config({
    virtual_text = false,
})
