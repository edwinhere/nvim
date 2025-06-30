-- Terminal mode mappings and settings
vim.api.nvim_create_autocmd("TermOpen", {
  pattern = "*",
  callback = function()
    -- Map escape from terminal mode to normal mode
    vim.keymap.set('t', '<C-[>', [[<C-\><C-n>]], { noremap = true, silent = true, buffer = true })
    
    -- Map window navigation from terminal normal mode
    vim.keymap.set('t', '<C-w>h', [[<C-\><C-n><C-w>h]], { noremap = true, silent = true, buffer = true })
    vim.keymap.set('t', '<C-w>j', [[<C-\><C-n><C-w>j]], { noremap = true, silent = true, buffer = true })
    vim.keymap.set('t', '<C-w>k', [[<C-\><C-n><C-w>k]], { noremap = true, silent = true, buffer = true })
    vim.keymap.set('t', '<C-w>l', [[<C-\><C-n><C-w>l]], { noremap = true, silent = true, buffer = true })
  end,
})
