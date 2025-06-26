vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)

  use { "ellisonleao/gruvbox.nvim" }
  use 'wbthomason/packer.nvim'

  use {
    'nvim-telescope/telescope.nvim', tag = '0.1.6',
    requires = { { 'nvim-lua/plenary.nvim' } }
  }

  use {
    'nvim-treesitter/nvim-treesitter',
    run = function()
      local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
      ts_update()
      -- Ensure markdown parser is installed without interactive prompt
      vim.cmd('TSInstall! markdown markdown_inline')
    end,
  }

  use {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v3.x',
    requires = {
      { 'williamboman/mason.nvim' },
      { 'williamboman/mason-lspconfig.nvim' },

      { 'neovim/nvim-lspconfig' },
      { 'hrsh7th/nvim-cmp' },
      { 'hrsh7th/cmp-nvim-lsp' },
      { 'L3MON4D3/LuaSnip' },
    }
  }

  use 'folke/neodev.nvim' -- to autocomplete neovim lua
  use 'tpope/vim-rhubarb' -- required by fugitive to :GBrowse

  use {
    'nvim-tree/nvim-tree.lua',
    requires = {
      'nvim-tree/nvim-web-devicons', -- optional
    },
  }

  use {
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup()
    end
  }

  use 'jamessan/vim-gnupg'
  use {
    'akinsho/bufferline.nvim',
    tag = "*",
    requires = 'nvim-tree/nvim-web-devicons'
  }
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'nvim-tree/nvim-web-devicons', opt = true }
  }
  use 'gpanders/nvim-parinfer'
  use({
    "kdheepak/lazygit.nvim",
    -- optional for floating window border decoration
    requires = {
      "nvim-lua/plenary.nvim",
    },
  })
  use 'lewis6991/gitsigns.nvim'
  use 'vim-scripts/dbext.vim'
  use 'onsails/lspkind.nvim'

  -- Claude Code integration
  use {
    'greggh/claude-code.nvim',
    requires = { 'nvim-lua/plenary.nvim' }
  }

  -- Haskell plugins
  use 'neovimhaskell/haskell-vim'  -- Better Haskell syntax highlighting
  use 'alx741/vim-hindent'         -- Haskell indentation

  -- Go plugins
  use 'fatih/vim-go'               -- Go development tools
  use 'mfussenegger/nvim-dap'      -- Debug Adapter Protocol
  use 'leoluz/nvim-dap-go'         -- Go debugging support
  use {
    'nvim-neotest/neotest',        -- Test runner
    requires = {
      'nvim-neotest/nvim-nio',     -- Required dependency
      'nvim-lua/plenary.nvim',
      'antoinemadec/FixCursorHold.nvim',
      'nvim-treesitter/nvim-treesitter'
    }
  }
  use 'nvim-neotest/neotest-go'    -- Go test adapter

  -- Python plugins
  use 'mfussenegger/nvim-dap-python'   -- Python debugging
  use 'nvim-neotest/neotest-python'    -- Python test adapter
  use 'psf/black'                      -- Python formatter
  use 'charliermarsh/ruff-lsp'         -- Python linter/formatter

  -- Java plugins
  use 'mfussenegger/nvim-jdtls'        -- Java LSP with advanced features
  use 'mfussenegger/nvim-dap'          -- Debug Adapter Protocol (already included but needed for Java)

  -- Node.js/JavaScript/TypeScript plugins
  use 'microsoft/vscode-js-debug' -- Node.js debugging
  use 'nvim-neotest/neotest-jest'   -- Jest test adapter
  use 'marilari88/neotest-vitest' -- Vitest test adapter
  use 'jose-elias-alvarez/null-ls.nvim' -- Formatting and linting
  use 'MunifTanjim/prettier.nvim'   -- Prettier integration
  use 'vuki656/package-info.nvim'   -- Package.json management
  use 'davidmh/cspell.nvim'         -- Spell checking for code

end)
