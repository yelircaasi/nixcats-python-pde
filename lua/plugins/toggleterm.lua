return {
  "toggleterm.nvim",
  keys = {
    {
      "<C-l>",
      function()
        vim.cmd("ToggleTerm direction=float")
      end,
      mode = { "n", "t", "v" },
      desc = "Toggle terminal"
    },
    {
      "<leader>tv",
      function()
        vim.cmd("ToggleTerm direction=vertical")
      end,
      desc = "Vertical terminal",
      mode = "n",
    },
    {
      "<leader>tt",
      function()
        vim.cmd("ToggleTerm direction=horizontal")
      end,
      desc = "Horizontal terminal",
      mode = "n",
    },
    {
      "<leader>ts",
      function()
        vim.cmd("TermSelect")
      end,
      desc = "Terminal select",
      mode = "n",
    },
  },
  after = function()
    require("toggleterm").setup({
      shade_terminals = false,
    })
  end,
}
