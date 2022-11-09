-- Automatically generated packer.nvim plugin loader code

if vim.api.nvim_call_function('has', {'nvim-0.5'}) ~= 1 then
  vim.api.nvim_command('echohl WarningMsg | echom "Invalid Neovim version for packer.nvim! | echohl None"')
  return
end

vim.api.nvim_command('packadd packer.nvim')

local no_errors, error_msg = pcall(function()

_G._packer = _G._packer or {}
_G._packer.inside_compile = true

local time
local profile_info
local should_profile = false
if should_profile then
  local hrtime = vim.loop.hrtime
  profile_info = {}
  time = function(chunk, start)
    if start then
      profile_info[chunk] = hrtime()
    else
      profile_info[chunk] = (hrtime() - profile_info[chunk]) / 1e6
    end
  end
else
  time = function(chunk, start) end
end

local function save_profiles(threshold)
  local sorted_times = {}
  for chunk_name, time_taken in pairs(profile_info) do
    sorted_times[#sorted_times + 1] = {chunk_name, time_taken}
  end
  table.sort(sorted_times, function(a, b) return a[2] > b[2] end)
  local results = {}
  for i, elem in ipairs(sorted_times) do
    if not threshold or threshold and elem[2] > threshold then
      results[i] = elem[1] .. ' took ' .. elem[2] .. 'ms'
    end
  end
  if threshold then
    table.insert(results, '(Only showing plugins that took longer than ' .. threshold .. ' ms ' .. 'to load)')
  end

  _G._packer.profile_output = results
end

time([[Luarocks path setup]], true)
local package_path_str = "/usr/local/google/home/cnieves/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?.lua;/usr/local/google/home/cnieves/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?/init.lua;/usr/local/google/home/cnieves/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?.lua;/usr/local/google/home/cnieves/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/usr/local/google/home/cnieves/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

time([[Luarocks path setup]], false)
time([[try_loadstring definition]], true)
local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s), name, _G.packer_plugins[name])
  if not success then
    vim.schedule(function()
      vim.api.nvim_notify('packer.nvim: Error running ' .. component .. ' for ' .. name .. ': ' .. result, vim.log.levels.ERROR, {})
    end)
  end
  return result
end

time([[try_loadstring definition]], false)
time([[Defining packer_plugins]], true)
_G.packer_plugins = {
  LuaSnip = {
    loaded = true,
    path = "/usr/local/google/home/cnieves/.local/share/nvim/site/pack/packer/start/LuaSnip",
    url = "https://github.com/L3MON4D3/LuaSnip"
  },
  MatchTagAlways = {
    loaded = true,
    path = "/usr/local/google/home/cnieves/.local/share/nvim/site/pack/packer/start/MatchTagAlways",
    url = "https://github.com/Valloric/MatchTagAlways"
  },
  ["asyncrun.vim"] = {
    loaded = true,
    path = "/usr/local/google/home/cnieves/.local/share/nvim/site/pack/packer/start/asyncrun.vim",
    url = "https://github.com/skywind3000/asyncrun.vim"
  },
  ["auto-session"] = {
    config = { "\27LJ\2\n‰\1\0\0\4\0\6\0\t6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\4\0=\3\5\2B\0\2\1K\0\1\0\31auto_session_suppress_dirs\1\4\0\0\a~/\16~/Downloads\6/\1\0\1\14log_level\nerror\nsetup\17auto-session\frequire\0" },
    loaded = true,
    path = "/usr/local/google/home/cnieves/.local/share/nvim/site/pack/packer/start/auto-session",
    url = "https://github.com/rmagatti/auto-session"
  },
  catppuccin = {
    config = { 'require("catppuccin-config")' },
    loaded = true,
    path = "/usr/local/google/home/cnieves/.local/share/nvim/site/pack/packer/start/catppuccin",
    url = "https://github.com/catppuccin/nvim"
  },
  ["cmp-buffer"] = {
    loaded = true,
    path = "/usr/local/google/home/cnieves/.local/share/nvim/site/pack/packer/start/cmp-buffer",
    url = "https://github.com/hrsh7th/cmp-buffer"
  },
  ["cmp-cmdline"] = {
    loaded = true,
    path = "/usr/local/google/home/cnieves/.local/share/nvim/site/pack/packer/start/cmp-cmdline",
    url = "https://github.com/hrsh7th/cmp-cmdline"
  },
  ["cmp-nvim-lsp"] = {
    loaded = true,
    path = "/usr/local/google/home/cnieves/.local/share/nvim/site/pack/packer/start/cmp-nvim-lsp",
    url = "https://github.com/hrsh7th/cmp-nvim-lsp"
  },
  ["cmp-nvim-lsp-document-symbol"] = {
    loaded = true,
    path = "/usr/local/google/home/cnieves/.local/share/nvim/site/pack/packer/start/cmp-nvim-lsp-document-symbol",
    url = "https://github.com/hrsh7th/cmp-nvim-lsp-document-symbol"
  },
  ["cmp-nvim-lsp-signature-help"] = {
    loaded = true,
    path = "/usr/local/google/home/cnieves/.local/share/nvim/site/pack/packer/start/cmp-nvim-lsp-signature-help",
    url = "https://github.com/hrsh7th/cmp-nvim-lsp-signature-help"
  },
  ["cmp-nvim-lua"] = {
    loaded = true,
    path = "/usr/local/google/home/cnieves/.local/share/nvim/site/pack/packer/start/cmp-nvim-lua",
    url = "https://github.com/hrsh7th/cmp-nvim-lua"
  },
  ["cmp-path"] = {
    loaded = true,
    path = "/usr/local/google/home/cnieves/.local/share/nvim/site/pack/packer/start/cmp-path",
    url = "https://github.com/hrsh7th/cmp-path"
  },
  ["cmp-spell"] = {
    loaded = true,
    path = "/usr/local/google/home/cnieves/.local/share/nvim/site/pack/packer/start/cmp-spell",
    url = "https://github.com/f3fora/cmp-spell"
  },
  ["cmp-under-comparator"] = {
    loaded = true,
    path = "/usr/local/google/home/cnieves/.local/share/nvim/site/pack/packer/start/cmp-under-comparator",
    url = "https://github.com/lukas-reineke/cmp-under-comparator"
  },
  ["cmp-vsnip"] = {
    loaded = true,
    path = "/usr/local/google/home/cnieves/.local/share/nvim/site/pack/packer/start/cmp-vsnip",
    url = "https://github.com/hrsh7th/cmp-vsnip"
  },
  cmp_luasnip = {
    after_files = { "/usr/local/google/home/cnieves/.local/share/nvim/site/pack/packer/opt/cmp_luasnip/after/plugin/cmp_luasnip.lua" },
    load_after = {},
    loaded = true,
    needs_bufread = false,
    path = "/usr/local/google/home/cnieves/.local/share/nvim/site/pack/packer/opt/cmp_luasnip",
    url = "https://github.com/saadparwaiz1/cmp_luasnip"
  },
  ["fidget.nvim"] = {
    config = { 'require("fidget").setup()' },
    loaded = true,
    path = "/usr/local/google/home/cnieves/.local/share/nvim/site/pack/packer/start/fidget.nvim",
    url = "https://github.com/j-hui/fidget.nvim"
  },
  ["fzf.vim"] = {
    loaded = true,
    path = "/usr/local/google/home/cnieves/.local/share/nvim/site/pack/packer/start/fzf.vim",
    url = "https://github.com/junegunn/fzf.vim"
  },
  ["git-conflict.nvim"] = {
    config = { "require('git-conflict').setup()" },
    loaded = true,
    path = "/usr/local/google/home/cnieves/.local/share/nvim/site/pack/packer/start/git-conflict.nvim",
    url = "https://github.com/akinsho/git-conflict.nvim"
  },
  ["gitsigns.nvim"] = {
    config = { "require('config.gitsigns')" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/usr/local/google/home/cnieves/.local/share/nvim/site/pack/packer/opt/gitsigns.nvim",
    url = "https://github.com/lewis6991/gitsigns.nvim"
  },
  ["java-syntax.vim"] = {
    loaded = true,
    path = "/usr/local/google/home/cnieves/.local/share/nvim/site/pack/packer/start/java-syntax.vim",
    url = "https://github.com/squk/java-syntax.vim"
  },
  ["kotlin-vim"] = {
    loaded = true,
    path = "/usr/local/google/home/cnieves/.local/share/nvim/site/pack/packer/start/kotlin-vim",
    url = "https://github.com/udalov/kotlin-vim"
  },
  ["lsp_lines.nvim"] = {
    config = { 'require("lsp_lines").setup()' },
    loaded = true,
    path = "/usr/local/google/home/cnieves/.local/share/nvim/site/pack/packer/start/lsp_lines.nvim",
    url = "https://github.com/ErichDonGubler/lsp_lines.nvim"
  },
  ["lspkind.nvim"] = {
    loaded = true,
    path = "/usr/local/google/home/cnieves/.local/share/nvim/site/pack/packer/start/lspkind.nvim",
    url = "https://github.com/onsails/lspkind.nvim"
  },
  ["lualine.nvim"] = {
    config = { ' require("lualine_config") ' },
    loaded = true,
    path = "/usr/local/google/home/cnieves/.local/share/nvim/site/pack/packer/start/lualine.nvim",
    url = "https://github.com/nvim-lualine/lualine.nvim"
  },
  ["mkdir.nvim"] = {
    loaded = true,
    path = "/usr/local/google/home/cnieves/.local/share/nvim/site/pack/packer/start/mkdir.nvim",
    url = "https://github.com/jghauser/mkdir.nvim"
  },
  neogit = {
    commands = { "Neogit" },
    config = { "require('config.neogit')" },
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/usr/local/google/home/cnieves/.local/share/nvim/site/pack/packer/opt/neogit",
    url = "https://github.com/TimUntersberger/neogit"
  },
  nerdcommenter = {
    loaded = true,
    path = "/usr/local/google/home/cnieves/.local/share/nvim/site/pack/packer/start/nerdcommenter",
    url = "https://github.com/scrooloose/nerdcommenter"
  },
  nerdtree = {
    loaded = true,
    path = "/usr/local/google/home/cnieves/.local/share/nvim/site/pack/packer/start/nerdtree",
    url = "https://github.com/preservim/nerdtree"
  },
  ["nvim-cmp"] = {
    loaded = true,
    path = "/usr/local/google/home/cnieves/.local/share/nvim/site/pack/packer/start/nvim-cmp",
    url = "https://github.com/hrsh7th/nvim-cmp"
  },
  ["nvim-lightbulb"] = {
    loaded = true,
    path = "/usr/local/google/home/cnieves/.local/share/nvim/site/pack/packer/start/nvim-lightbulb",
    url = "https://github.com/kosayoda/nvim-lightbulb"
  },
  ["nvim-lspconfig"] = {
    loaded = true,
    path = "/usr/local/google/home/cnieves/.local/share/nvim/site/pack/packer/start/nvim-lspconfig",
    url = "https://github.com/neovim/nvim-lspconfig"
  },
  ["nvim-notify"] = {
    loaded = true,
    path = "/usr/local/google/home/cnieves/.local/share/nvim/site/pack/packer/start/nvim-notify",
    url = "https://github.com/rcarriga/nvim-notify"
  },
  ["nvim-scrollbar"] = {
    config = { 'require("scrollbar").setup()' },
    loaded = true,
    path = "/usr/local/google/home/cnieves/.local/share/nvim/site/pack/packer/start/nvim-scrollbar",
    url = "https://github.com/petertriho/nvim-scrollbar"
  },
  ["nvim-treesitter"] = {
    loaded = true,
    path = "/usr/local/google/home/cnieves/.local/share/nvim/site/pack/packer/start/nvim-treesitter",
    url = "https://github.com/nvim-treesitter/nvim-treesitter"
  },
  ["nvim-web-devicons"] = {
    loaded = true,
    path = "/usr/local/google/home/cnieves/.local/share/nvim/site/pack/packer/start/nvim-web-devicons",
    url = "https://github.com/kyazdani42/nvim-web-devicons"
  },
  ["packer.nvim"] = {
    loaded = true,
    path = "/usr/local/google/home/cnieves/.local/share/nvim/site/pack/packer/start/packer.nvim",
    url = "https://github.com/wbthomason/packer.nvim"
  },
  ["plenary.nvim"] = {
    loaded = true,
    path = "/usr/local/google/home/cnieves/.local/share/nvim/site/pack/packer/start/plenary.nvim",
    url = "https://github.com/nvim-lua/plenary.nvim"
  },
  ["registers.nvim"] = {
    loaded = true,
    path = "/usr/local/google/home/cnieves/.local/share/nvim/site/pack/packer/start/registers.nvim",
    url = "https://github.com/tversteeg/registers.nvim"
  },
  ["symbols-outline.nvim"] = {
    loaded = true,
    path = "/usr/local/google/home/cnieves/.local/share/nvim/site/pack/packer/start/symbols-outline.nvim",
    url = "https://github.com/simrat39/symbols-outline.nvim"
  },
  ["telescope-codesearch.nvim"] = {
    loaded = true,
    path = "/usr/local/google/home/cnieves/.local/share/nvim/site/pack/packer/start/telescope-codesearch.nvim",
    url = "sso://googler@user/vintharas/telescope-codesearch.nvim"
  },
  ["telescope.nvim"] = {
    loaded = true,
    path = "/usr/local/google/home/cnieves/.local/share/nvim/site/pack/packer/start/telescope.nvim",
    url = "https://github.com/nvim-telescope/telescope.nvim"
  },
  ["trouble.nvim"] = {
    loaded = true,
    path = "/usr/local/google/home/cnieves/.local/share/nvim/site/pack/packer/start/trouble.nvim",
    url = "https://github.com/folke/trouble.nvim"
  },
  undotree = {
    commands = { "UndotreeToggle" },
    config = { "vim.g.undotree_SetFocusWhenToggle = 1" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/usr/local/google/home/cnieves/.local/share/nvim/site/pack/packer/opt/undotree",
    url = "https://github.com/mbbill/undotree"
  },
  ["vim-better-whitespace"] = {
    loaded = true,
    path = "/usr/local/google/home/cnieves/.local/share/nvim/site/pack/packer/start/vim-better-whitespace",
    url = "https://github.com/ntpeters/vim-better-whitespace"
  },
  ["vim-case-convert"] = {
    loaded = true,
    path = "/usr/local/google/home/cnieves/.local/share/nvim/site/pack/packer/start/vim-case-convert",
    url = "https://github.com/chiedo/vim-case-convert"
  },
  ["vim-indent-guides"] = {
    loaded = true,
    path = "/usr/local/google/home/cnieves/.local/share/nvim/site/pack/packer/start/vim-indent-guides",
    url = "https://github.com/nathanaelkane/vim-indent-guides"
  },
  ["vim-matchup"] = {
    after_files = { "/usr/local/google/home/cnieves/.local/share/nvim/site/pack/packer/opt/vim-matchup/after/plugin/matchit.vim" },
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/usr/local/google/home/cnieves/.local/share/nvim/site/pack/packer/opt/vim-matchup",
    url = "https://github.com/andymass/vim-matchup"
  },
  ["vim-nerdtree-syntax-highlight"] = {
    loaded = true,
    path = "/usr/local/google/home/cnieves/.local/share/nvim/site/pack/packer/start/vim-nerdtree-syntax-highlight",
    url = "https://github.com/tiagofumo/vim-nerdtree-syntax-highlight"
  },
  ["vim-obsession"] = {
    loaded = true,
    path = "/usr/local/google/home/cnieves/.local/share/nvim/site/pack/packer/start/vim-obsession",
    url = "https://github.com/tpope/vim-obsession"
  },
  ["vim-quantum"] = {
    loaded = true,
    path = "/usr/local/google/home/cnieves/.local/share/nvim/site/pack/packer/start/vim-quantum",
    url = "https://github.com/squk/vim-quantum"
  },
  ["vim-ripgrep"] = {
    loaded = true,
    path = "/usr/local/google/home/cnieves/.local/share/nvim/site/pack/packer/start/vim-ripgrep",
    url = "https://github.com/jremmen/vim-ripgrep"
  },
  ["vim-signify"] = {
    loaded = true,
    path = "/usr/local/google/home/cnieves/.local/share/nvim/site/pack/packer/start/vim-signify",
    url = "https://github.com/mhinz/vim-signify"
  },
  ["vim-surround"] = {
    loaded = true,
    path = "/usr/local/google/home/cnieves/.local/share/nvim/site/pack/packer/start/vim-surround",
    url = "https://github.com/tpope/vim-surround"
  },
  ["vim-titlecase"] = {
    loaded = true,
    path = "/usr/local/google/home/cnieves/.local/share/nvim/site/pack/packer/start/vim-titlecase",
    url = "https://github.com/christoomey/vim-titlecase"
  },
  ["vim-tmux"] = {
    loaded = true,
    path = "/usr/local/google/home/cnieves/.local/share/nvim/site/pack/packer/start/vim-tmux",
    url = "https://github.com/tmux-plugins/vim-tmux"
  },
  ["vim-tmux-focus-events"] = {
    loaded = true,
    path = "/usr/local/google/home/cnieves/.local/share/nvim/site/pack/packer/start/vim-tmux-focus-events",
    url = "https://github.com/tmux-plugins/vim-tmux-focus-events"
  },
  ["vim-tmux-navigator"] = {
    loaded = true,
    path = "/usr/local/google/home/cnieves/.local/share/nvim/site/pack/packer/start/vim-tmux-navigator",
    url = "https://github.com/christoomey/vim-tmux-navigator"
  },
  ["vim-tmux-syntax"] = {
    loaded = true,
    path = "/usr/local/google/home/cnieves/.local/share/nvim/site/pack/packer/start/vim-tmux-syntax",
    url = "https://github.com/whatyouhide/vim-tmux-syntax"
  },
  ["vim-vsnip"] = {
    loaded = true,
    path = "/usr/local/google/home/cnieves/.local/share/nvim/site/pack/packer/start/vim-vsnip",
    url = "https://github.com/hrsh7th/vim-vsnip"
  },
  ["vim-windowswap"] = {
    loaded = true,
    path = "/usr/local/google/home/cnieves/.local/share/nvim/site/pack/packer/start/vim-windowswap",
    url = "https://github.com/wesQ3/vim-windowswap"
  },
  vimux = {
    loaded = true,
    path = "/usr/local/google/home/cnieves/.local/share/nvim/site/pack/packer/start/vimux",
    url = "https://github.com/preservim/vimux"
  }
}

time([[Defining packer_plugins]], false)
-- Config for: auto-session
time([[Config for auto-session]], true)
try_loadstring("\27LJ\2\n‰\1\0\0\4\0\6\0\t6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\4\0=\3\5\2B\0\2\1K\0\1\0\31auto_session_suppress_dirs\1\4\0\0\a~/\16~/Downloads\6/\1\0\1\14log_level\nerror\nsetup\17auto-session\frequire\0", "config", "auto-session")
time([[Config for auto-session]], false)
-- Config for: lualine.nvim
time([[Config for lualine.nvim]], true)
 require("lualine_config") 
time([[Config for lualine.nvim]], false)
-- Config for: nvim-scrollbar
time([[Config for nvim-scrollbar]], true)
require("scrollbar").setup()
time([[Config for nvim-scrollbar]], false)
-- Config for: git-conflict.nvim
time([[Config for git-conflict.nvim]], true)
require('git-conflict').setup()
time([[Config for git-conflict.nvim]], false)
-- Config for: lsp_lines.nvim
time([[Config for lsp_lines.nvim]], true)
require("lsp_lines").setup()
time([[Config for lsp_lines.nvim]], false)
-- Config for: catppuccin
time([[Config for catppuccin]], true)
require("catppuccin-config")
time([[Config for catppuccin]], false)
-- Config for: fidget.nvim
time([[Config for fidget.nvim]], true)
require("fidget").setup()
time([[Config for fidget.nvim]], false)
-- Load plugins in order defined by `after`
time([[Sequenced loading]], true)
vim.cmd [[ packadd LuaSnip ]]
vim.cmd [[ packadd cmp_luasnip ]]
time([[Sequenced loading]], false)

-- Command lazy-loads
time([[Defining lazy-load commands]], true)
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file Neogit lua require("packer.load")({'neogit'}, { cmd = "Neogit", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file UndotreeToggle lua require("packer.load")({'undotree'}, { cmd = "UndotreeToggle", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
time([[Defining lazy-load commands]], false)

vim.cmd [[augroup packer_load_aucmds]]
vim.cmd [[au!]]
  -- Event lazy-loads
time([[Defining lazy-load event autocommands]], true)
vim.cmd [[au VimEnter * ++once lua require("packer.load")({'vim-matchup'}, { event = "VimEnter *" }, _G.packer_plugins)]]
vim.cmd [[au User ActuallyEditing ++once lua require("packer.load")({'gitsigns.nvim'}, { event = "User ActuallyEditing" }, _G.packer_plugins)]]
time([[Defining lazy-load event autocommands]], false)
vim.cmd("augroup END")

_G._packer.inside_compile = false
if _G._packer.needs_bufread == true then
  vim.cmd("doautocmd BufRead")
end
_G._packer.needs_bufread = false

if should_profile then save_profiles() end

end)

if not no_errors then
  error_msg = error_msg:gsub('"', '\\"')
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
end
