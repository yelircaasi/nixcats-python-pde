return {
    "xit",
    ft = "xit",
    after = function()
      require("xit").setup({
            disable_default_highlights = false,
            disable_default_mappings = false,
            default_jump_group = "all", -- possible values: all, open_and_ongoing
            wrap_jumps = true,
      })
    end,
  }
  