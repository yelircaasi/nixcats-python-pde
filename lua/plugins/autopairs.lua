return {
  "nvim-autopairs",
  event = "BufEnter",
  after = function()
    require("nvim-autopairs").setup()
  end,
}
