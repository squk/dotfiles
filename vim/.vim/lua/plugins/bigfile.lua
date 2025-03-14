return {
  "LunarVim/bigfile.nvim",
  opts = {
    filesize = 2, -- size of the file in MiB, the plugin round file sizes to the closest MiB
    pattern = function(bufnr, filesize_mib)
      -- you can't use `nvim_buf_line_count` because this runs on BufReadPre
      local file_contents = vim.fn.readfile(vim.api.nvim_buf_get_name(bufnr))
      local file_lines = #file_contents
      local filetype = vim.filetype.match({ buf = bufnr })
      if filetype == "c" or filetype == "cpp" then
        if file_lines > 1000 then
          vim.b.codefmt_formatt = "" -- disable codefmt
          vim.cmd(":FormatDisable") -- disable conform
          return true
        end
      end
      return filesize_mib > 1
    end,
    features = { -- features to disable
      "indent_blankline",
      "illuminate",
      "lsp",
      "treesitter",
      -- "syntax",
      "matchparen",
      -- "vimopts",
      -- "filetype",
    },
  }
}
