require("keymaps")
require("plugins")

require("scripts.autoroot").setup()

vim.opt.relativenumber = true
vim.opt.number = true

-- Global statusline
vim.opt.laststatus = 3
-- Persistent undos across session
vim.opt.undofile = true

vim.opt.tabstop = 4
vim.opt.shiftwidth = 2

vim.treesitter.indent = true
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldmethod = "expr"
vim.opt.foldenable = false

vim.opt.signcolumn = "yes"
vim.opt.updatetime = 250

vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

vim.opt.scrolloff = 10

vim.cmd.colorscheme("rose-pine")

require("nvim-treesitter.configs").setup({
  ensure_installed = {},
  sync_install = false,
  auto_install = false,
  modules = { "highlight", "incremental_selection", "indent" },
  ignore_install = {},
  highlight = { enable = true },
  disable = function(_, buf)
    local max_filesize = 100 * 1024 -- 100 KB
    local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
    if ok and stats and stats.size > max_filesize then
      return true
    end
  end,
  additional_vim_regex_highlighting = false,
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "<CR>",
      node_incremental = "<C-k>",
      scope_incremental = "<BS>",
      node_decremental = "<C-j>",
    },
  },
})

vim.api.nvim_create_autocmd({
  "TermOpen",
}, {
  group = vim.api.nvim_create_augroup("terminal", {}),
  callback = function()
    vim.cmd("setlocal nonumber norelativenumber")
  end,
})

vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank({ higroup = "Visual", timeout = 300 })
  end,
})


-- vim.treesitter.language.register('xit', 'xit')

vim.api.nvim_create_augroup('XitFiletypeGroup', { clear = true })

vim.api.nvim_create_autocmd('FileType', {

  group = 'XitFiletypeGroup',
  pattern = 'xit',
  callback = function()
    require('nvim-treesitter.configs').setup({highlight = {enable = true,}})
    require('xit').setup({
      disable_default_highlights = false,
      disable_default_mappings = false,
      default_jump_group = "all", -- possible values: all, open_and_ongoing
      wrap_jumps = true,
    })
    vim.api.nvim_set_hl(0, '@XitHeadline', {
      fg = '#FFD700',
      bg = 'NONE',
      bold = true,
      underline = true,
    })
  end,
})


-- lua end concealing
-- -- Define a function to place virtual text markers
-- local function mark_lua_ends()
--   -- Clear all previous virtual text in the current buffer
--   local ns = vim.api.nvim_create_namespace("EndMarker")
--   vim.api.nvim_buf_clear_namespace(0, ns, 0, -1)

--   -- Get the lines in the current buffer
--   local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
--   for i, line in ipairs(lines) do
--     -- Look for 'end' keywords not under the cursor
--     local s, e = line:find("%f[%a]end%f[%A]") -- Word-boundary match for 'end'
--     if s and i - 1 ~= vim.fn.line('.') - 1 then
--       -- Add virtual text at the end keyword
--       vim.api.nvim_buf_set_extmark(0, ns, i - 1, e, {
--         virt_text = { { "❯", "NonText" } }, -- Customize 'NonText' as needed
--         virt_text_pos = "overlay",
--       })
--     end
--   end
-- end

-- -- Create an autocommand to update markers on buffer changes and cursor movement
-- vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "CursorMoved" }, {
--   pattern = "*.lua",
--   callback = function()
--     mark_lua_ends()
--   end,
-- })

-- replace 'end' with '›' using virtual text, to reduce visual noise
local function replace_lua_ends()
  local ns = vim.api.nvim_create_namespace("EndReplacer")
  vim.api.nvim_buf_clear_namespace(0, ns, 0, -1)

  local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
  local cursor_line = vim.fn.line('.') - 1
  local cursor_col = vim.fn.col('.') - 1

  for i, line in ipairs(lines) do
    local s, e = line:find("^%s*%f[%a](end)%f[%A]")
    if s and not (i - 1 == cursor_line and cursor_col >= e - 1 and cursor_col < e) then
      vim.api.nvim_buf_set_extmark(0, ns, i - 1, e - 3, {
        virt_text = { { "›  ", "Keyword" } }, -- alt: ⦆⦄❩⸩〛⦆⦄）〕⦘〙〉》〉❯」」』» ›)
        virt_text_pos = "overlay",
        hl_mode = "replace",
      })
    end
  end
end

vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "CursorMoved" }, {
  pattern = "*.lua",
  callback = function()
    replace_lua_ends()
  end,
})
