-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- optionally enable 24-bit colour
vim.opt.termguicolors = true

local function my_on_attach(bufnr)
  local api = require "nvim-tree.api"

  local function opts(desc)
    return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end

  -- default mappings
  api.config.mappings.default_on_attach(bufnr)

  -- custom mappings
  vim.keymap.set('n', '<F3>', api.tree.toggle, {})
  vim.keymap.set('n', '<F2>', api.tree.find_file, opts('Find current file in tree'))
end

require("nvim-tree").setup({
  sort = {
    sorter = "case_sensitive",
  },
  view = {
    width = 30,
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = true,
  },
  ---
  on_attach = my_on_attach,
  ---
})

vim.keymap.set('n', '<F3>', ':NvimTreeToggle<CR>', {})
vim.keymap.set('n', '<F2>', ':NvimTreeFindFile<CR>', {})
