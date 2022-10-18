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

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

Plug 'nvim-lua/plenary.nvim'           " lua helpers
Plug 'nvim-telescope/telescope.nvim'   " actual plugin
Plug 'sso://user/vintharas/telescope-codesearch.nvim'

" UI EXTENSIONS
Plug 'ntpeters/vim-better-whitespace'  "auto-set tab/space size
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'nvim-lualine/lualine.nvim'
Plug 'rcarriga/nvim-notify'
" Plug 'vim-airline/vim-airline'         " ...
" Plug 'vim-airline/vim-airline-themes'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'Konfekt/vim-scratchpad'
Plug 'guns/xterm-color-table.vim'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'mbbill/undotree'
Plug 'tversteeg/registers.nvim', { 'branch': 'main' }
" Plug 'ryanoasis/vim-devicons'

" INTEGRATION
Plug 'AndrewRadev/linediff.vim'
Plug 'tpope/vim-fugitive'             " git
Plug 'junegunn/gv.vim'                " git commit browser
Plug 'tpope/vim-git'
Plug 'airblade/vim-gitgutter'         " live git diff gutter
Plug 'tmux-plugins/vim-tmux'          " tmux
Plug 'preservim/vimux'
Plug 'christoomey/vim-tmux-navigator' " tmux
Plug 'ferrine/md-img-paste.vim'       " copy-paste images to markdown
Plug 'junegunn/vim-easy-align'        " markdown table aligns
Plug 'skywind3000/asyncrun.vim'
Plug 'dhruvasagar/vim-table-mode'     " git readme tables
Plug 'NLKNguyen/cloudformation-syntax.vim'
Plug 'stephpy/vim-yaml'
Plug 'towolf/vim-helm'
Plug 'tell-k/vim-autoflake' " remove unused python imports
Plug 'embear/vim-uncrustify'
Plug 'sakhnik/nvim-gdb', { 'do': 'bash ./install.sh \| UpdateRemotePlugins' }
Plug 'kburdett/vim-nuuid'
Plug 'easymotion/vim-easymotion'

" AUTO-COMPLETION
Plug 'christoomey/vim-titlecase'
Plug 'chiedo/vim-case-convert'

" FILE INTERACTIONS
" Plug 'mileszs/ack.vim'      " Ack bindings
Plug 'jremmen/vim-ripgrep'

Plug 'preservim/nerdtree'  " File Tree
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'

" LANGUAGE PLUGINS
Plug 'udalov/kotlin-vim'
Plug 'hsanson/vim-android'
Plug 'OmniSharp/omnisharp-vim'
Plug 'whatyouhide/vim-tmux-syntax'
Plug 'chase/vim-ansible-yaml'
Plug 'justinmk/vim-syntax-extra'
Plug 'NLKNguyen/c-syntax.vim'
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'hexdigest/gounit-vim'
Plug 'pangloss/vim-javascript'
Plug 'mattn/emmet-vim'

Plug 'jparise/vim-graphql'
Plug 'StanAngeloff/php.vim'
Plug 'sealemar/vtl'
Plug 'wavded/vim-stylus'
Plug 'nikvdp/ejs-syntax'
Plug 'lepture/vim-velocity'
au BufNewFile,BufRead *.vtl, set ft=velocity

" MARKUP/OBJECT NOTATION
Plug 'plasticboy/vim-markdown'
Plug 'elzr/vim-json'

" FUNCTIONALITY STUFF
Plug 'tmux-plugins/vim-tmux-focus-events'
set autoread
Plug 'tpope/vim-obsession'     " auto vim-sessions session
Plug 'Valloric/MatchTagAlways' " hilight closing tags in HTML etc.
Plug 'wesQ3/vim-windowswap'

" FORMATTING
Plug 'tpope/vim-surround'       " easily surround with delimiters
Plug 'scrooloose/nerdcommenter' " comment bindings
Plug 'junegunn/vim-easy-align'
Plug 'tommcdo/vim-exchange'

" THEMES
Plug 'catppuccin/nvim', { 'as': 'catppuccin' }
Plug 'altercation/vim-colors-solarized'
Plug 'vim-airline/vim-airline-themes'
Plug 'jdkanani/vim-material-theme'
Plug 'sonph/onehalf', { 'rtp': 'vim' }
Plug 'gosukiwi/vim-atom-dark'
Plug 'jacoborus/tender.vim'
Plug 'kristijanhusak/vim-hybrid-material'
Plug 'NLKNguyen/papercolor-theme'
Plug 'arcticicestudio/nord-vim'
Plug 'chase/focuspoint-vim'
Plug 'patstockwell/vim-monokai-tasty' " airline
Plug 'fxn/vim-monochrome'
Plug 'robertmeta/nofrils'
Plug 'kristiandupont/shades-of-teal'
Plug 'joshdick/onedark.vim'
Plug 'google/vim-colorscheme-primary'
Plug 'kyoz/purify', { 'rtp': 'vim' }

" ONE LINERS ONLY
set statusline=%{pathshorten(expand('%:f'))}

let g:rainbow_active = 1 "set to 0 if you want to enable it later via :RainbowToggle
