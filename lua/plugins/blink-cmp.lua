return {
  "blink-cmp",
  event = "BufEnter",
  after = function()
    require("blink-cmp").setup({
      -- for keymap, all values may be string | string[]
      -- use an empty table to disable a keymap
      keymap = {
        show = "<C-space>",
        hide = "<C-e>",
        accept = "<Tab>",
        select_prev = { "<Up>", "<C-p>" },
        select_next = { "<Down>", "<C-n>" },

        show_documentation = {},
        hide_documentation = {},
        scroll_documentation_up = "<C-b>",
        scroll_documentation_down = "<C-f>",

        snippet_forward = "<Tab>",
        snippet_backward = "<S-Tab>",
      },

      fuzzy = {
        -- frencency tracks the most recently/frequently used items and boosts the score of the item
        use_frecency = true,
        -- proximity bonus boosts the score of items with a value in the buffer
        use_proximity = true,
        max_items = 200,
        -- controls which sorts to use and in which order, these three are currently the only allowed options
        sorts = { "label", "kind", "score" },

        prebuiltBinaries = {
          -- Whether or not to automatically download a prebuilt binary from github. If this is set to `false`
          -- you will need to manually build the fuzzy binary dependencies by running `cargo build --release`
          download = false,
          -- When downloading a prebuilt binary force the downloader to resolve this version. If this is uset
          -- then the downloader will attempt to infer the version from the checked out git tag (if any).
          --
          -- Beware that if the FFI ABI changes while tracking main then this may result in blink breaking.
          forceVersion = nil,
        },
      },

      windows = {
        documentation = {
          min_width = 10,
          max_width = 60,
          max_height = 20,
          border = "padded",
          auto_show = true,
          auto_show_delay_ms = 500,
          update_delay_ms = 100,
        },
        signature_help = {
          min_width = 1,
          max_width = 100,
          max_height = 10,
          border = "padded",
        },
      },
    })
  end,
}
