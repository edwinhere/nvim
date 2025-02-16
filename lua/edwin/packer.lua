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
  use {
    'milanglacier/yarepl.nvim',
    config = function()
      local yarepl = require('yarepl')
      yarepl.setup {
        buflisted = true,
        scratch = true,
        ft = 'REPL',
        wincmd = 'vertical botright 80 split',
        metas = {
          aider = {
            cmd = "aider --chat-language English --architect --model sonnet --editor-model sonnet --yes-always",
            pattern = {
              prompt = "Human: ",
              continue = "Assistant: "
            },
            type = "stdio",
            formatter = 'trim_empty_lines'
          },
          aichat = { cmd = 'aichat', formatter = 'bracketed_pasting' },
          radian = { cmd = 'radian', formatter = 'bracketed_pasting_no_final_new_line' },
          ipython = { cmd = 'ipython', formatter = 'bracketed_pasting' },
          python = { cmd = 'python', formatter = 'trim_empty_lines' },
          R = { cmd = 'R', formatter = 'trim_empty_lines' },
          bash = { cmd = 'bash', formatter = vim.fn.has('linux') == 1 and 'bracketed_pasting' or 'trim_empty_lines' },
          zsh = { cmd = 'zsh', formatter = 'bracketed_pasting' },
        },
        close_on_exit = true,
        scroll_to_bottom_after_sending = true,
        format_repl_buffers_names = true,
        os = {
          windows = {
            send_delayed_cr_after_sending = true,
          },
        },
      }
    end
  }

end)
