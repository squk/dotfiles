packadd termdebug
" MINE
Plug 'squk/vim-quantum'
Plug 'squk/java-syntax.vim'

" LSP
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-nvim-lua'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/vim-vsnip'
Plug 'neovim/nvim-lspconfig'
Plug 'onsails/lspkind.nvim'
Plug 'j-hui/fidget.nvim'
Plug 'simrat39/symbols-outline.nvim'
" required only for diagnostics
Plug 'folke/trouble.nvim'

" Nvim
Plug 'kosayoda/nvim-lightbulb'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'jghauser/mkdir.nvim'
Plug 'ErichDonGubler/lsp_lines.nvim'

Plug 'nvim-lua/plenary.nvim'           " lua helpers
Plug 'nvim-telescope/telescope.nvim'   " actual plugin
Plug 'sso://user/vintharas/telescope-codesearch.nvim'
Plug 'nvim-lualine/lualine.nvim'
Plug 'rcarriga/nvim-notify'

" UI EXTENSIONS
Plug 'ntpeters/vim-better-whitespace'  "auto-set tab/space size
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

Plug 'nathanaelkane/vim-indent-guides'
Plug 'mbbill/undotree'
Plug 'tversteeg/registers.nvim', { 'branch': 'main' }

" INTEGRATION
Plug 'AndrewRadev/linediff.vim'
Plug 'tpope/vim-fugitive'             " git
Plug 'tpope/vim-git'
Plug 'airblade/vim-gitgutter'         " live git diff gutter
Plug 'tmux-plugins/vim-tmux'          " tmux
Plug 'preservim/vimux'
Plug 'christoomey/vim-tmux-navigator' " tmux
Plug 'skywind3000/asyncrun.vim'
" Plug 'easymotion/vim-easymotion'

" AUTO-COMPLETION
Plug 'christoomey/vim-titlecase'
Plug 'chiedo/vim-case-convert'

" FILE INTERACTIONS
Plug 'jremmen/vim-ripgrep'

Plug 'preservim/nerdtree'  " File Tree
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'

" LANGUAGE PLUGINS
Plug 'udalov/kotlin-vim'
Plug 'hsanson/vim-android'
Plug 'OmniSharp/omnisharp-vim'
Plug 'whatyouhide/vim-tmux-syntax'

au BufNewFile,BufRead *.vtl, set ft=velocity

" FUNCTIONALITY STUFF
Plug 'tmux-plugins/vim-tmux-focus-events'
set autoread
Plug 'tpope/vim-obsession'     " auto vim-sessions session
Plug 'Valloric/MatchTagAlways' " hilight closing tags in HTML etc.
Plug 'wesQ3/vim-windowswap'

" FORMATTING
Plug 'tpope/vim-surround'       " easily surround with delimiters
Plug 'scrooloose/nerdcommenter' " comment bindings

" THEMES
Plug 'catppuccin/nvim', { 'as': 'catppuccin' }
Plug 'jdkanani/vim-material-theme'
Plug 'kristijanhusak/vim-hybrid-material'
Plug 'kyazdani42/nvim-web-devicons'

" ONE LINERS ONLY
set statusline=%{pathshorten(expand('%:f'))}

let g:rainbow_active = 1 "set to 0 if you want to enable it later via :RainbowToggle
