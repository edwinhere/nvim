-- Haskell-specific configuration

-- Enable Haskell syntax highlighting and indentation
vim.g.haskell_enable_quantification = 1   -- Enable highlighting of forall
vim.g.haskell_enable_recursivedo = 1       -- Enable highlighting of mdo and rec
vim.g.haskell_enable_arrowsyntax = 1       -- Enable highlighting of proc
vim.g.haskell_enable_pattern_synonyms = 1 -- Enable highlighting of pattern synonyms
vim.g.haskell_enable_typeroles = 1         -- Enable highlighting of type roles
vim.g.haskell_enable_static_pointers = 1   -- Enable highlighting of static pointers

-- Hindent configuration for automatic indentation
vim.g.hindent_on_save = 1
vim.g.hindent_indent_size = 2
vim.g.hindent_line_length = 80

-- Set up Haskell-specific key mappings
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "haskell", "lhaskell" },
  callback = function()
    local opts = { noremap = true, silent = true, buffer = true }
    
    -- Quick compile and run
    vim.keymap.set('n', '<leader>hc', ':!ghc %<CR>', opts)
    vim.keymap.set('n', '<leader>hr', ':!runhaskell %<CR>', opts)
    
    -- REPL integration
    vim.keymap.set('n', '<leader>hi', ':!ghci %<CR>', opts)
    
    -- Format with ormolu
    vim.keymap.set('n', '<leader>hf', ':!ormolu --mode inplace %<CR>', opts)
    
    -- Cabal commands
    vim.keymap.set('n', '<leader>cb', ':!cabal build<CR>', opts)
    vim.keymap.set('n', '<leader>ct', ':!cabal test<CR>', opts)
    vim.keymap.set('n', '<leader>cr', ':!cabal run<CR>', opts)
    
    -- Stack commands
    vim.keymap.set('n', '<leader>sb', ':!stack build<CR>', opts)
    vim.keymap.set('n', '<leader>st', ':!stack test<CR>', opts)
    vim.keymap.set('n', '<leader>sr', ':!stack run<CR>', opts)
    vim.keymap.set('n', '<leader>sg', ':!stack ghci<CR>', opts)
  end,
})

-- Configure Treesitter for Haskell
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    -- Check if Haskell parser is installed before installing
    local parsers = require('nvim-treesitter.parsers')
    if not parsers.has_parser('haskell') then
      vim.cmd('TSInstall haskell')
    end
  end,
})