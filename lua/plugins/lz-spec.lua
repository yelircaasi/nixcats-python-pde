return {
  require("plugins.blink-cmp"),
  require("plugins.telescope"),
  require("plugins.oil"),
  require("plugins.harpoon"),
  require("plugins.lualine"),
  require("plugins.conform"),
  require("plugins.lsp-progress"),
  require("plugins.gitsigns"),
  require("plugins.autopairs"),
  require("plugins.trouble"),
  require("plugins.render-markdown"),
  require("plugins.toggleterm"),
  { "telescope-ui-select.nvim" },
  { "vim-wakatime" },
  { "vim-sleuth" },
  {
    "nvim-lspconfig",
    event = "BufEnter",
    after = require("lsp").setup,
  },
  {
    "which-key.nvim",
    after = function()
      require("which-key").setup({
        delay = 1000,
      })
    end,
  },
  { "nvim-web-devicons" },
  { "rose-pine", priority = 100 },
  {
    "markdown-preview.nvim",
    filetypes = { "markdown" },
  },
  {
    "typst-preview",
    filetypes = { "*.typ" },
    after = function()
      require("typst-preview").setup({
        dependencies_bin = {
          ["tinymist"] = nixCats("bin.tinymist"),
          ["websocat"] = nixCats("bin.websocat"),
        },
      })
    end,
  },
  {
    "mini.ai",
    event = "BufEnter",
    after = function()
      require("mini.ai").setup()
    end,
  },
  {
    "mini.surround",
    event = "BufEnter",
    after = function()
      require("mini.surround").setup()
    end,
  },
  {
    "mini.starter",
    after = function()
      require("mini.starter").setup()
    end,
  },
  {
    "mini.notify",
    after = function()
      require("mini.notify").setup({
        -- handled by statusline
        lsp_progress = { enable = false },
      })
    end,
  },
  {
    "mini.trailspace",
    event = "BufEnter",
    after = function()
      require("mini.trailspace").setup()
    end,
  },
  {
    "cellular-automaton.nvim",
    cmd = "CellularAutomaton",
    keys = {
      {
        "<leader>mr",
        function()
          vim.cmd.CellularAutomaton("make_it_rain")
        end,
        desc = "A surprise!",
        mode = "n",
      },
      {
        "<leader>bruh",
        function()
          vim.cmd.CellularAutomaton("game_of_life")
        end,
        desc = "A surprise!",
        mode = "n",
      },
    },
  },
  {
    "indent-blankline.nvim",
    after = function()
      require("ibl").setup({
        indent = {
          char = "│",
          tab_char = "│",
        },
        scope = { show_start = false, show_end = false },
        exclude = {
          filetypes = {
            "help",
            "ministarter",
            "Trouble",
            "trouble",
            "toggleterm",
          },
        },
      })
    end,
  },
  {
    "mini.bufremove",
    keys = {
      {
        "<leader>bd",
        function()
          MiniBufremove.delete()
        end,
        mode = { "n", "v" },
        desc = "Close buffer",
      },
    },
    after = function()
      require("mini.bufremove").setup()
    end,
  },
  {
    "mini.hipatterns",
    event = "BufEnter",
    after = function()
      require("mini.hipatterns").setup()
    end,
  },
  {
    "neogit",
    cmd = "Neogit",
    keys = {
      {
        "<leader>gg",
        function()
          vim.cmd.Neogit()
        end,
        desc = "Open neogit",
        mode = "n",
      },
      {
        "<leader>gc",
        function()
          vim.cmd.Neogit("kind=floating commit")
        end,
        desc = "Open neogit commit menu",
        mode = "n",
      },
    },
    before = function()
      local lz = require("lz.n")
      lz.trigger_load("diffview.nvim")
      lz.trigger_load("telescope.nvim")
    end,
    after = function()
      require("neogit").setup({
        graph_style = "unicode",
        integrations = {
          telescope = true,
          diffview = true,
        },
      })
    end,
  },
  {
    "diffiew.nvim",
    cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFocusFiles", "DiffviewRefresh" },
  },
  {
    "barbecue.nvim",
    event = "BufEnter",
    after = function()
      require("barbecue").setup()
    end,
  },
  {
    "undotree",
    cmd = "UndotreeToggle",
    keys = {
      {
        "<leader>u",
        function()
          vim.cmd.UndotreeToggle()
        end,
        desc = "Toggle undotree",
        mode = "n",
      },
    },
  },
  {
    "neocord",
    event = "BufEnter",
    after = function()
      require("neocord").setup({
        editing_text = "Hacking %s",
        logo_tooltip = "The One True Text Editor",
        terminal_text = "Bypassing the mainframe",
        workspace_text = "The One True Text Editor",
      })
    end,
  },
  {
    "crates.nvim",
    event = "BufRead Cargo.toml",
    after = function()
      require("crates").setup({})
    end,
  },
  { "rustaceanvim" },
  { "haskell-tools.nvim" },
  {
    "typescript-tools.nvim",
    filetypes = { "typescriptreact", "typescript", "javascript", "svelte", "javascriptreact" },
    after = function()
      require("lz.n").trigger_load("nvim-lspconfig")
      require("typescript-tools").setup({})
    end,
  },
  {
    "lsp_lines.nvim",
    event = "LspAttach",
    after = function()
      require("lsp_lines").setup()
      vim.diagnostic.config({
        virtual_text = false,
        virtual_lines = { only_current_line = true },
      })
    end,
  },
}
