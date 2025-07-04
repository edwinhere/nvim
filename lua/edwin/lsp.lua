-- IMPORTANT: make sure to setup neodev BEFORE lspconfig
require("neodev").setup({
  -- add any options here, or leave empty to use the default settings
})

local lsp_zero = require('lsp-zero')

lsp_zero.on_attach(function(client, bufnr)
  -- see :help lsp-zero-keybindings
  -- to learn the available actions
  lsp_zero.default_keymaps({ buffer = bufnr })
end)

-- Setup mason without automatic LSP configuration
require('mason').setup({})

-- Setup LSP servers manually without mason-lspconfig
local lspconfig = require('lspconfig')

-- Only setup servers that are actually available
pcall(function() lspconfig.lua_ls.setup({}) end)
pcall(function() 
  lspconfig.gopls.setup({
    settings = {
      gopls = {
        analyses = {
          unusedparams = true,
        },
        staticcheck = true,
        gofumpt = true,
      },
    },
  })
end)
pcall(function() 
  lspconfig.ruff.setup({
    init_options = {
      settings = {
        args = {"--ignore=E501"}  -- Ignore line length errors
      }
    }
  })
end)
pcall(function() 
  lspconfig.pyright.setup({
    settings = {
      python = {
        analysis = {
          autoSearchPaths = true,
          diagnosticMode = "workspace",
          useLibraryCodeForTypes = true,
          typeCheckingMode = "basic"
        }
      }
    }
  })
end)
pcall(function() 
  lspconfig.ts_ls.setup({
    settings = {
      typescript = {
        inlayHints = {
          includeInlayParameterNameHints = 'all',
          includeInlayParameterNameHintsWhenArgumentMatchesName = false,
          includeInlayFunctionParameterTypeHints = true,
          includeInlayVariableTypeHints = true,
          includeInlayPropertyDeclarationTypeHints = true,
          includeInlayFunctionLikeReturnTypeHints = true,
          includeInlayEnumMemberValueHints = true,
        }
      },
      javascript = {
        inlayHints = {
          includeInlayParameterNameHints = 'all',
          includeInlayParameterNameHintsWhenArgumentMatchesName = false,
          includeInlayFunctionParameterTypeHints = true,
          includeInlayVariableTypeHints = true,
          includeInlayPropertyDeclarationTypeHints = true,
          includeInlayFunctionLikeReturnTypeHints = true,
          includeInlayEnumMemberValueHints = true,
        }
      }
    }
  })
end)
pcall(function() 
  lspconfig.eslint.setup({
    settings = {
      workingDirectory = { mode = 'auto' }
    }
  })
end)
pcall(function() lspconfig.jdtls.setup({}) end)
pcall(function() 
  lspconfig.hls.setup({
    cmd = { vim.fn.expand('~/.ghcup/bin/haskell-language-server-wrapper'), '--lsp' },
    filetypes = { 'haskell', 'lhaskell', 'cabal' },
    settings = {
      haskell = {
        formattingProvider = "ormolu"
      }
    }
  })
end)

local cmp = require('cmp')
local cmp_action = require('lsp-zero').cmp_action()

local lspkind = require('lspkind')

cmp.setup({
  sources = {
    {name = 'nvim_lsp', group_index = 2},
    {name = 'luasnip', group_index = 2},
  },
  mapping = {
    ['<CR>'] = cmp.mapping.confirm({select = false}),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-f>'] = cmp_action.luasnip_jump_forward(),
    ['<C-b>'] = cmp_action.luasnip_jump_backward(),
  },
  formatting = {
    format = lspkind.cmp_format({
      mode = 'symbol',
      maxwidth = 50,
      ellipsis_char = '...',
      symbol_map = { Copilot = "" }
    })
  }
})
