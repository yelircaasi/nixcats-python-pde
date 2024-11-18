# Dev Notes

Here's a set of modern, Lua-based Neovim plugins tailored to create a powerful development environment, especially for Python, covering LSP, formatting, linting, debugging, and navigation:

1. LSP Management
nvim-lspconfig: The go-to plugin for configuring and managing language servers. It includes robust support for Python (using pyright or pylsp).
mason.nvim: Provides an easy way to install LSP servers, DAP servers, linters, and formatters. Works seamlessly with nvim-lspconfig and null-ls.
mason-lspconfig.nvim: Bridges mason.nvim and nvim-lspconfig to ensure all LSP servers are managed in sync.
2. Formatting and Linting
null-ls.nvim: Integrates external formatters and linters, allowing you to use black for formatting and flake8 or mypy for linting Python. It acts as an LSP server for these tools, keeping everything unified.
formatter.nvim: An alternative to null-ls for running formatters, if you prefer to separate linting from formatting. This plugin supports async formatting, making it smooth and non-blocking.
3. Debugging
nvim-dap: A powerful debugger plugin with support for many languages. For Python, pair it with nvim-dap-python, which integrates with debugpy.
nvim-dap-ui: Provides a clean and configurable UI for nvim-dap, with floating windows for variables, call stacks, and breakpoints, making debugging more intuitive.
mason-nvim-dap.nvim: Helps manage and install DAP servers easily within the mason.nvim ecosystem, including debugpy for Python debugging.
4. Quickfix and Navigation
trouble.nvim: A modern and customizable UI for quickfix and location lists, integrating with LSP diagnostics and nvim-dap for error navigation.
telescope.nvim: Essential for fuzzy finding and navigating within a project. Works well with trouble.nvim and includes extensions for quickfix and diagnostics navigation.
5. Quality-of-Life Enhancements
nvim-navic: Provides code context, displaying the current symbol or function at the top of your editor, keeping you oriented in large Python files.
which-key.nvim: Displays a keybinding guide, which can be invaluable as you expand your workflow.

```lua
-- LSP setup with mason
require("mason").setup()
require("mason-lspconfig").setup({ ensure_installed = { "pyright", "lua_ls" } })
require("lspconfig").pyright.setup({})

-- Formatting and linting with null-ls
local null_ls = require("null-ls")
null_ls.setup({
  sources = {
    null_ls.builtins.formatting.black,
    null_ls.builtins.diagnostics.flake8,
  },
})

-- DAP setup for Python debugging
require("dap-python").setup("~/.virtualenvs/debugpy/bin/python")
require("dapui").setup()

-- Trouble for quickfix navigation
require("trouble").setup()

-- Telescope for fuzzy finding
require("telescope").setup()
```

Here’s a breakdown of the plugins and how to set them up:

1. LuaSnip
LuaSnip is a fast and flexible snippet engine written in Lua.
It supports advanced features like placeholders, choice nodes, and dynamic snippets, making it ideal for Python and multi-language setups.
LuaSnip has integration with friendly-snippets, a collection of snippets for multiple languages, including Python.
2. friendly-snippets
This is a large, community-maintained collection of snippets for various programming languages.
When paired with LuaSnip, it provides you with ready-to-use snippets for Python and other languages you may add later.
3. nvim-cmp (for autocompletion)
nvim-cmp is a popular autocompletion plugin that works well with LuaSnip.
It offers a wide range of sources, including buffer words, LSP, and snippets, making it a comprehensive completion engine.
4. cmp_luasnip Source
This is a bridge plugin for nvim-cmp and LuaSnip, allowing you to use LuaSnip’s snippets directly in the completion menu.
Example Configuration
Here’s how you might configure these plugins in your Neovim setup:

```lua
-- LuaSnip setup
local luasnip = require("luasnip")
require("luasnip.loaders.from_vscode").lazy_load()  -- Load snippets from friendly-snippets

-- nvim-cmp setup
local cmp = require("cmp")
cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)  -- Use LuaSnip as the snippet engine
    end,
  },
  sources = {
    { name = "nvim_lsp" },
    { name = "luasnip" },  -- Add LuaSnip as a completion source
    { name = "buffer" },
    { name = "path" },
  },
  mapping = {
    ["<Tab>"] = cmp.mapping.select_next_item(),
    ["<S-Tab>"] = cmp.mapping.select_prev_item(),
    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<CR>"] = cmp.mapping.confirm({ select = true }),
  },
})

-- Keybindings for LuaSnip
vim.keymap.set({ "i", "s" }, "<C-j>", function()
  if luasnip.expand_or_jumpable() then
    luasnip.expand_or_jump()
  end
end)
vim.keymap.set({ "i", "s" }, "<C-k>", function()
  if luasnip.jumpable(-1) then
    luasnip.jump(-1)
  end
end)

```

Key Features of This Setup
Tab Completion: Cycles through snippet options.
Lazy Loading Snippets: The setup automatically loads snippets from friendly-snippets.
Jumping Between Placeholders: <C-j> and <C-k> allow jumping forward and backward between snippet placeholders, which is especially useful for complex Python code snippets.
With this setup, you’ll have an efficient and extensible snippet experience in Neovim, fully integrated with autocompletion and ready to support multiple languages beyond Python.
