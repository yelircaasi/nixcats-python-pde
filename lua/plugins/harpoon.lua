return {
  "harpoon2",
  after = function()
    require("harpoon"):setup()
  end,
  keys = {
    {
      "<leader>a",
      function()
        require("harpoon"):list():add()
      end,
      desc = "Add to harpoon",
      mode = "n",
    },
    {
      "<C-h><C-a>",
      function()
        require("harpoon"):list():select(1)
      end,
      desc = "Select harpoon 1",
      mode = "n",
    },
    {
      "<C-h><C-s>",
      function()
        require("harpoon"):list():select(2)
      end,
      desc = "Select harpoon 2",
      mode = "n",
    },
    {
      "<C-h><C-d>",
      function()
        require("harpoon"):list():select(3)
      end,
      desc = "Select harpoon 3",
      mode = "n",
    },
    {
      "<C-h><C-f>",
      function()
        require("harpoon"):list():select(4)
      end,
      desc = "Select harpoon 4",
      mode = "n",
    },
    {
      "<C-h><C-h>",
      function()
        require("lz.n").trigger_load("telescope.nvim")

        local conf = require("telescope.config").values
        local function toggle_telescope(harpoon_files)
          local file_paths = {}
          for _, item in ipairs(harpoon_files.items) do
            table.insert(file_paths, item.value)
          end

          require("telescope.pickers")
            .new({}, {
              prompt_title = "Harpoon",
              finder = require("telescope.finders").new_table({
                results = file_paths,
              }),
              previewer = conf.file_previewer({}),
              sorter = conf.generic_sorter({}),
            })
            :find()
        end

        toggle_telescope(require("harpoon"):list())
      end,
      mode = "n",
      desc = "toggle harpoon menu",
    },
  },
}
