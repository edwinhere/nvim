vim.o.tabstop = 2
vim.o.softtabstop = 0
vim.o.shiftwidth = 2
vim.o.expandtab = true
vim.o.hidden = true
vim.o.hlsearch = true
vim.o.incsearch = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.fileformats = "unix,dos,mac"
vim.o.ruler = true
vim.o.number = true
vim.cmd.colorscheme("gruvbox")
vim.cmd.syntax("on")
vim.o.mouse = "a"
vim.o.mousemodel = "popup"
vim.o.gcr = "a:blinkon0"
vim.o.modeline = true
vim.o.modelines = 10

-- Auto-refresh files when changed on disk
vim.o.autoread = true
-- Trigger `autoread` when files changes on disk
vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "CursorHold", "CursorHoldI" }, {
    pattern = "*",
    command = "if mode() != 'c' | checktime | endif",
})
-- Notification after file change
vim.api.nvim_create_autocmd("FileChangedShellPost", {
    pattern = "*",
    callback = function()
        vim.notify("File changed on disk. Buffer reloaded.", vim.log.levels.WARN)
    end,
})

-- Centering Find Next or Previous
vim.keymap.set('n', 'n', 'nzzzv', { silent = false })
vim.keymap.set('n', 'N', 'Nzzzv', { silent = false })

-- Frequent Typos
vim.cmd.cnoreabbrev("W!", "w!")
vim.cmd.cnoreabbrev("Q!", "q!")
vim.cmd.cnoreabbrev("Qall!", "qall!")
vim.cmd.cnoreabbrev("Wq", "wq")
vim.cmd.cnoreabbrev("Wa", "wa")
vim.cmd.cnoreabbrev("wQ", "wq")
vim.cmd.cnoreabbrev("WQ", "wq")
vim.cmd.cnoreabbrev("W", "w")
vim.cmd.cnoreabbrev("Q", "q")
vim.cmd.cnoreabbrev("Qall", "qall")

-- Terminal
vim.keymap.set('n', '<leader>sh', vim.cmd.terminal, { silent = true })
-- Split
vim.keymap.set('', '<Leader>h', ':<C-u>split<CR>', { silent = false })
vim.keymap.set('', '<Leader>v', ':<C-u>vsplit<CR>', { silent = false })
-- Cut, Copy, Paste
vim.keymap.set('', 'YY', '"+y<CR>', { silent = false })
vim.keymap.set('', '<leader>p', '"+gP<CR>', { silent = false })
vim.keymap.set('', 'XX', '"+x<CR>', { silent = false })
-- Buffer Navigation
vim.keymap.set('', '<leader>z', ':bp<CR>', { silent = false })
vim.keymap.set('', '<leader>q', ':bp<CR>', { silent = false })
vim.keymap.set('', '<leader>x', ':bn<CR>', { silent = false })
vim.keymap.set('', '<leader>w', ':bn<CR>', { silent = false })
-- Buffer Close
vim.keymap.set('', '<leader>c', ':bd<CR>', { silent = false })
-- Clean Search
vim.keymap.set('n', '<leader><space>', ':noh<cr>', { silent = true })
-- Switching Windows
vim.keymap.set('', '<C-j>', '<C-w>j', { silent = false })
vim.keymap.set('', '<C-k>', '<C-w>k', { silent = false })
vim.keymap.set('', '<C-l>', '<C-w>l', { silent = false })
vim.keymap.set('', '<C-h>', '<C-w>h', { silent = false })
-- Vmap for maintain Visual Mode after shifting > and <
vim.cmd.vmap("<", "<gv")
vim.cmd.vmap(">", ">gv")
-- Move visual block
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv")
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv")
