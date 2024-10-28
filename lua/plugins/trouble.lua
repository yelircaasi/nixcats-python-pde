return {
  "trouble.nvim",
  cmd = "Trouble",
  after = function()
    require("trouble").setup()
  end,
  keys = {
    {
      "<leader>xx",
      function()
        vim.cmd("Trouble diagnostics toggle")
      end,
      desc = "Diagnostics",
      mode = "n",
    },
    {
      "<leader>xX",
      function()
        vim.cmd("Trouble diagnostics toggle filter.buf=0")
      end,
      desc = "Buffer diagnostics",
      mode = "n",
    },
    {
      "<leader>cs",
      function()
        vim.cmd("Trouble symbols toggle")
      end,
      desc = "Symbols",
      mode = "n",
    },
    {
      "<leader>cl",
      function()
        vim.cmd("Trouble lsp toggle win.position=right")
      end,
      desc = "LSP definitions / references /...",
      mode = "n",
    },
    {
      "<leader>ql",
      function()
        vim.cmd("Trouble qflist toggle")
      end,
      desc = "Quickfix list (trouble)",
      mode = "n",
    },
  },
}
