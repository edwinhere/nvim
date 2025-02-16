local builtin = require('telescope.builtin')
local actions = require('telescope.actions')

-- Setup telescope with custom mappings
require('telescope').setup({
    defaults = {
        mappings = {
            i = {
                ["<C-a>"] = function()
                    require('edwin.repl').add_telescope_grep_results_to_aider()
                end
            },
            n = {
                ["<C-a>"] = function()
                    require('edwin.repl').add_telescope_grep_results_to_aider()
                end
            }
        }
    }
})

vim.keymap.set('n', '<leader>e', builtin.find_files, {})
vim.keymap.set('n', '<leader>gf', builtin.git_files, {})
vim.keymap.set('n', '<leader>f', builtin.live_grep, {})
vim.keymap.set('n', '<leader>b', builtin.buffers, {})
vim.keymap.set('n', '<leader>?', builtin.help_tags, {})
vim.keymap.set('n', '<leader>m', builtin.man_pages, {})
vim.keymap.set('n', '<F1>', builtin.colorscheme, {})
vim.keymap.set('n', '<leader>r', builtin.registers, {})
vim.keymap.set('n', '<leader>k', builtin.keymaps, {})
vim.keymap.set('n', '<leader>t', builtin.treesitter, {})
