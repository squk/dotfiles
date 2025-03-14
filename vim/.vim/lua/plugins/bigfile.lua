return {
  "LunarVim/bigfile.nvim",
  opts = {
    filesize = 2, -- size of the file in MiB, the plugin round file sizes to the closest MiB
    pattern = function(bufnr, filesize_mib)
      vim.cmd(":NoAutoFormatBuffer")
      vim.cmd(":FormatDisable")
      -- you can't use `nvim_buf_line_count` because this runs on BufReadPre
      local file_contents = vim.fn.readfile(vim.api.nvim_buf_get_name(bufnr))
      local file_lines = #file_contents
      local filetype = vim.filetype.match({ buf = bufnr })
      if file_lines > 1000 and (filetype == "c" or filetype == "cpp") then
        return true
      end
      return filesize_mib > 1
    end,
    features = { -- features to disable
      "indent_blankline",
      -- "illuminate",
      "lsp",
      "treesitter",
      -- "syntax",
      -- "matchparen",
      -- "vimopts",
      "filetype",
    },
  }
}
