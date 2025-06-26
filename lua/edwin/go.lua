-- Go development configuration

-- vim-go settings
vim.g.go_highlight_types = 1
vim.g.go_highlight_fields = 1
vim.g.go_highlight_functions = 1
vim.g.go_highlight_function_calls = 1
vim.g.go_highlight_operators = 1
vim.g.go_highlight_extra_types = 1
vim.g.go_highlight_build_constraints = 1
vim.g.go_highlight_generate_tags = 1

-- Use goimports instead of gofmt
vim.g.go_fmt_command = "goimports"

-- Run gofmt/goimports on save
vim.g.go_fmt_autosave = 1

-- Disable vim-go LSP (we use gopls via lspconfig)
vim.g.go_def_mapping_enabled = 0
vim.g.go_gopls_enabled = 0

-- Test settings
vim.g.go_test_show_name = 1

-- Debug adapter setup
local dap = require('dap')
require('dap-go').setup()

-- Neotest setup for Go tests
require('neotest').setup({
  adapters = {
    require('neotest-go'),
  },
})

-- Go-specific keybindings
local function map(mode, lhs, rhs, opts)
  opts = opts or {}
  opts.silent = opts.silent ~= false
  vim.keymap.set(mode, lhs, rhs, opts)
end

-- Go test keybindings
map('n', '<leader>gt', ':GoTest<CR>', { desc = 'Run Go tests' })
map('n', '<leader>gT', ':GoTestFunc<CR>', { desc = 'Run Go test function' })
map('n', '<leader>gc', ':GoCoverageToggle<CR>', { desc = 'Toggle Go coverage' })

-- Go build and run
map('n', '<leader>gb', ':GoBuild<CR>', { desc = 'Build Go project' })
map('n', '<leader>gr', ':GoRun<CR>', { desc = 'Run Go main' })

-- Go debugging
map('n', '<leader>gd', function() dap.continue() end, { desc = 'Debug continue' })
map('n', '<leader>gD', function() dap.toggle_breakpoint() end, { desc = 'Toggle breakpoint' })

-- Neotest keybindings
map('n', '<leader>tn', function() require('neotest').run.run() end, { desc = 'Run nearest test' })
map('n', '<leader>tf', function() require('neotest').run.run(vim.fn.expand('%')) end, { desc = 'Run file tests' })
map('n', '<leader>ts', function() require('neotest').summary.toggle() end, { desc = 'Test summary' })