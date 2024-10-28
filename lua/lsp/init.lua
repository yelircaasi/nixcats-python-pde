local M = {}

M.setup = function()
  local symbols = { Error = "󰅙", Info = "󰋼", Hint = "󰌵", Warn = "" }

  for name, icon in pairs(symbols) do
    local hl = "DiagnosticSign" .. name
    vim.fn.sign_define(hl, { text = icon, numhl = hl, texthl = hl })
  end

  local lspconfig = require("lspconfig")

  lspconfig.lua_ls.setup({
    settings = {
      Lua = {
        runtime = {
          -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
          version = "LuaJIT",
        },
        diagnostics = {
          -- Get the language server to recognize the `vim` global
          globals = { "vim", "nixCats", "MiniBufremove" },
        },
        workspace = {
          -- Make the server aware of Neovim runtime files
          library = vim.api.nvim_get_runtime_file("", true),
        },
        -- Do not send telemetry data containing a randomized but unique identifier
        telemetry = {
          enable = false,
        },
      },
    },
  })

  lspconfig.nixd.setup({
    nixd = {
      nixpkgs = {
        expr = [[import (builtins.getFlake ")]] .. nixCats("nixdExtras.nixpkgs") .. [[") { }   ]],
      },
      -- options = {
      --   nixos = {
      --     expr = [[(builtins.getFlake "]]
      --       .. nixCats("nixdExtras.flake-path")
      --       .. [[").nixosConfigurations."]]
      --       .. nixCats("nixdExtras.systemCFGname")
      --       .. [[".options]],
      --   },
      --   -- (builtins.getFlake "<path_to_system_flake>").homeConfigurations."<name>".options
      --   ["home-manager"] = {
      --     expr = [[(builtins.getFlake "]]
      --       .. nixCats("nixdExtras.flake-path")
      --       .. [[").homeConfigurations."]]
      --       .. nixCats("nixdExtras.homeCFGname")
      --       .. [[".options]],
      --   },
      -- },
    },
  })
  lspconfig.marksman.setup({})
  lspconfig.tinymist.setup({})
  lspconfig.svelte.setup({})
  lspconfig.tailwindcss.setup({})
end

return M
