return {
  "oil.nvim",
  after = function()
    require("oil").setup({
      columns = {
        "size",
        "icon",
      },
      use_default_keymaps = false,
      keymaps = {
        ["J"] = "actions.parent",
        ["Q"] = "actions.close",
        ["<C-h>"] = "actions.select_split",
        ["<C-l>"] = "actions.refresh",
        ["<C-p>"] = "actions.preview",
        ["<C-s>"] = "actions.select_vsplit",
        ["<C-t>"] = "actions.select_tab",
        ["<CR>"] = "actions.select",
        ["K"] = "actions.select",
        ["_"] = "actions.open_cwd",
        ["`"] = "actions.cd",
        ["g."] = "actions.toggle_hidden",
        ["g?"] = "actions.show_help",
        ["g\\"] = "actions.toggle_trash",
        ["gs"] = "actions.change_sort",
        ["gx"] = "actions.open_external",
        ["~"] = "actions.tcd",
      },
    })

    vim.keymap.set("n", "<leader>e", function()
      vim.cmd("Oil")
    end, { desc = "Open file explorer in current file directory" })

    vim.keymap.set("n", "<leader>fe", function()
      vim.cmd("Oil " .. vim.fn.getcwd())
    end, { desc = "Open file explorer in current working directory" })
  end,
}
