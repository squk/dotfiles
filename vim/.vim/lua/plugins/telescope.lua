local use_google = require("utils").use_google
local exec = require("utils").exec
local TableConcat = require("utils").TableConcat
local scopes = require("neoscopes")

_G.find_files = function(search_dirs)
  require("telescope.builtin").find_files({ search_dirs = search_dirs, })
end
-- Helper functions to fetch the current scope and set `search_dirs`
_G.find_dotfiles = function()
end

_G.search_cwd = function()
  local builtin = require("telescope.builtin")
  local utils = require("telescope.utils")
  builtin.find_files({ cwd = utils.buffer_dir() })
end

_G.live_grep = function(search_dirs)
  require("telescope.builtin").live_grep({
    search_dirs = search_dirs,
  })
end

_G.live_grep_cword = function(search_dirs)
  require("telescope.builtin").live_grep({ search_dirs = search_dirs, })
end

local function exe(cmd)
  return vim.split(vim.fn.system(cmd), "\n")
end

function fig_modified()
  return exe("hg pstatus -ma -n --no-status --template= | sort")
end

function fig_all_modified()
  return exe("hg status -ma -n --rev p4base --no-status --template= | sort")
end

-- stylua: ignore
local keys = {
  { "<leader>e",  ":lua search_cwd()<CR>",                                                                           desc = "Find Files in Buffer Directory" },
  { "<leader>ts", require('telescope.builtin').live_grep },
  { "<leader>TS", function() require('telescope.builtin').live_grep { default_text = vim.fn.expand("<cword>") } end, },
  {
    "<leader>t.",
    function()
      require("telescope.builtin").git_files({
        cwd = vim.fn.expand("$HOME/dotfiles"), })
    end
    ,
    desc = "Find Dotfiles"
  },
  { "<leader>tc",  ":Telescope textcase<CR>",                           desc = "Text case" },
  { "<leader>tC",  ":CritiqueUnresolvedCommentsTelescope<CR>",          desc = "Critique unresolved comments" },
  { "<leader>tca", ":CritiqueCommentsTelescope<CR>",                    desc = "Critique all comments" },
  { "<leader>tg",  ":Telescope git_files<CR>",                          desc = "Git Files" },
  { "<leader>tk",  ":Telescope keymaps<CR>",                            desc = "Keymaps" },
  { "<leader>tn",  ":Telescope notify<CR>",                             desc = "Notifications" },
  { "<leader>tr",  ":Telescope resume<CR>",                             desc = "Telescope Resume" },
  { "<leader>th",  ":lua require('telescope.builtin').help_tags{}<CR>", desc = "[T]elescope [H]elp" },
}

if use_google() then
  local find_files = require("telescope.builtin").find_files
  local cs_query = require("telescope").extensions.codesearch.find_query
  -- stylua: ignore
  TableConcat(keys, {
    { "<leader>tm", function() find_files({ search_dirs = fig_modified() }) end,     desc = "list modified Fig files." },
    { "<leader>tM", function() find_files({ search_dirs = fig_all_modified() }) end, desc = "List *all* modified Fig files" },
    { "<leader>tf", function() find_files({ search_dirs = fig_modified() }) end,     desc = "Grep modified Fig files." },
    { "<leader>tF", function() find_files({ search_dirs = fig_modified() }) end,     desc = "Grep *all* modified Fig files." },
    { "<C-P>",      require("telescope").extensions.codesearch.find_files,           desc = "Code search files" },
    { "<leader>cs", require("telescope").extensions.codesearch.find_query,           desc = "Code search query" },
    { "<leader>cs", cs_query,                                                        desc = "Code search query",             mode = "v" },
    { "<leader>CS", function() cs_query({ default_text_expand = '<cword>' }) end,    desc = "Code search query <cword>" },
  })
end

return {
  {
    "aznhe21/actions-preview.nvim",
    config = function()
      require("actions-preview").setup({
        telescope = {
          sorting_strategy = "ascending",
          layout_strategy = "vertical",
          layout_config = {
            width = 0.8,
            height = 0.9,
            prompt_position = "top",
            preview_cutoff = 20,
            preview_height = function(_, _, max_lines)
              return max_lines - 15
            end,
          },
        },
      })
    end,
    keys = {
      { "?", "<cmd>lua require('actions-preview').code_actions()<cr>" },
    },
  },
  {
    "smartpde/telescope-recent-files",
    config = function()
      require("telescope").load_extension("recent_files")
    end,
    keys = {
      { "<leader>to", require('telescope').extensions.recent_files.pick },
    },
  },
  {
    "piersolenski/telescope-import.nvim",
    dependencies = "nvim-telescope/telescope.nvim",
    config = function()
      require("telescope").load_extension("import")
    end,
    keys = function()
      if not use_google() then
        return {
          { "<leader>i", ":Telescope import<CR>" },
        }
      end
    end,
  },
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "mfussenegger/nvim-dap",
      "smartpde/telescope-recent-files",
      "rcarriga/nvim-dap-ui",
    },
    config = function()
      require("telescope").setup({
        defaults = {
          -- The vertical layout strategy is good to handle long paths like those in
          -- google3 repos because you have nearly the full screen to display a file path.
          -- The caveat is that the preview area is smaller.
          layout_strategy = "vertical",
          -- Common paths in google3 repos are collapsed following the example of Cider
          -- It is nice to keep this as a user config rather than part of
          -- telescope-codesearch because it can be reused by other telescope pickers.
          path_display = function(opts, path)
            -- Do common substitutions
            path = path:gsub("^/google/src/cloud/[^/]+/[^/]+/google3/", "google3/", 1)
            path = path:gsub("^google3/java/com/google/", "//j/c/g/", 1)
            path = path:gsub("^google3/javatests/com/google/", "//jt/c/g/", 1)
            path = path:gsub("^google3/third_party/", "//3p/", 1)
            path = path:gsub("^google3/", "//", 1)

            -- Do truncation. This allows us to combine our custom display formatter
            -- with the built-in truncation.
            -- `truncate` handler in transform_path memoizes computed truncation length in opts.__length.
            -- Here we are manually propagating this value between new_opts and opts.
            -- We can make this cleaner and more complicated using metatables :)
            local new_opts = {
              path_display = {
                truncate = true,
              },
              __length = opts.__length,
            }
            path = require("telescope.utils").transform_path(new_opts, path)
            opts.__length = new_opts.__length
            return path
          end,
          mappings = {
            n = {
              ["<C-c>"] = "close",
              ["<Esc>"] = "close",
            },
            i = {
              -- ["<cr>"] = function(bufnr)
              --   require("telescope.actions.set").edit(bufnr, "tab drop")
              -- end,
              ["<C-c>"] = "close",
              ["<Esc>"] = "close",
              ["<S-Down>"] = "cycle_history_next",
              ["<S-Up>"] = "cycle_history_prev",
            },
          },
        },
        extensions = {
          codesearch = {
            experimental = true, -- enable results from google3/experimental
          },
          recent_files = {
            -- This function rewrites all file paths to the current workspace.
            -- For example, if w2 is the current workspace, then
            -- /google/.../w1/google3/my_file.cc becomes /google/.../w2/google3/my_file.cc,
            transform_file_path = function(path)
              local neocitc = require("neocitc")
              local path_func = neocitc.path_in_current_workspace_or_head
                  or neocitc.path_in_current_workspace
              return path_func(path)
            end,
            -- This is a useful option to speed up Telescope by avoiding the check
            -- for file existence.
            stat_files = false,
            -- Ignore common patterns that can show up from other google plugins
            ignore_patterns = {
              "/%.git/COMMIT_EDITING$",
              "/%.git/COMMIT_EDITMSG$",
              "/%.git/MERGE_MSG$",
              "^/tmp/%.pipertmp-",
              "/Related_Files$",
              "^term:",
              ";#toggleterm#",
            },
          },
          persisted = {},
          import = {
            -- Add imports to the top of the file keeping the cursor in place
            insert_at_top = true,
          },
        },
      })
    end,
    keys = keys,
  },
}
