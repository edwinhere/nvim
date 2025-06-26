-- Node.js development configuration

-- Package.json management (only if available)
local ok_package_info, package_info = pcall(require, 'package-info')
if ok_package_info then
  package_info.setup({
  colors = {
    up_to_date = "#3C4048",
    outdated = "#d19a66",
  },
  icons = {
    enable = true,
    style = {
      up_to_date = "|  ",
      outdated = "|  ",
    },
  },
    autostart = true,
    hide_up_to_date = false,
    hide_unstable_versions = false,
  })
end

-- Prettier setup (only if available)
local ok_prettier, prettier = pcall(require, "prettier")
if ok_prettier then
  prettier.setup({
  bin = 'prettier',
  filetypes = {
    "css",
    "graphql",
    "html",
    "javascript",
    "javascriptreact",
    "json",
    "less",
    "markdown",
    "scss",
    "typescript",
    "typescriptreact",
    "yaml",
  },
  cli_options = {
    arrow_parens = "always",
    bracket_spacing = true,
    bracket_same_line = false,
    embedded_language_formatting = "auto",
    end_of_line = "lf",
    html_whitespace_sensitivity = "css",
    jsx_bracket_same_line = false,
    jsx_single_quote = false,
    print_width = 80,
    prose_wrap = "preserve",
    quote_props = "as-needed",
    semi = true,
    single_attribute_per_line = false,
    single_quote = false,
    tab_width = 2,
    trailing_comma = "es5",
    use_tabs = false,
    vue_indent_script_and_style = false,
    },
  })
end

-- null-ls setup for additional formatting/linting (only if available)
local ok_null_ls, null_ls = pcall(require, "null-ls")
if ok_null_ls then
  null_ls.setup({
  sources = {
    -- JavaScript/TypeScript
    null_ls.builtins.formatting.prettier.with({
      filetypes = { 
        "javascript", "javascriptreact", "typescript", "typescriptreact", 
        "vue", "css", "scss", "less", "html", "json", "yaml", "markdown" 
      },
    }),
    null_ls.builtins.diagnostics.eslint,
    null_ls.builtins.code_actions.eslint,
    
    -- Spell checking (only if cspell is available)
    null_ls.builtins.diagnostics.cspell.with({
      condition = function(utils)
        return utils.root_has_file({ ".cspell.json", "cspell.json", ".cspell.config.js" })
          and vim.fn.executable("cspell") == 1
      end,
      diagnostics_postprocess = function(diagnostic)
        diagnostic.severity = vim.diagnostic.severity.HINT
      end,
    }),
    },
  })
end

-- Debug adapter setup for Node.js (only if available)
local ok_dap, dap = pcall(require, 'dap')
if ok_dap then

-- Use VS Code JS Debug adapter
dap.adapters['pwa-node'] = {
  type = 'server',
  host = '127.0.0.1',
  port = '${port}',
  executable = {
    command = 'js-debug-adapter',
    args = { '${port}' },
  }
}

-- Node.js debugging configurations
dap.configurations.javascript = {
  {
    type = 'pwa-node',
    request = 'launch',
    name = 'Launch file',
    program = '${file}',
    cwd = '${workspaceFolder}',
    sourceMaps = true,
  },
  {
    type = 'pwa-node',
    request = 'attach',
    name = 'Attach',
    processId = require'dap.utils'.pick_process,
    cwd = '${workspaceFolder}',
    sourceMaps = true,
  },
  {
    type = 'pwa-node',
    request = 'launch',
    name = 'Debug Jest Tests',
    runtimeExecutable = 'node',
    runtimeArgs = {
      './node_modules/.bin/jest',
      '--runInBand',
    },
    rootPath = '${workspaceFolder}',
    cwd = '${workspaceFolder}',
    console = 'integratedTerminal',
    internalConsoleOptions = 'neverOpen',
  }
}

dap.configurations.typescript = {
  {
    type = 'pwa-node',
    request = 'launch',
    name = 'Launch TypeScript file',
    program = '${file}',
    cwd = '${workspaceFolder}',
    sourceMaps = true,
    runtimeExecutable = 'ts-node',
  },
  {
    type = 'pwa-node',
    request = 'attach',
    name = 'Attach',
    processId = require'dap.utils'.pick_process,
    cwd = '${workspaceFolder}',
    sourceMaps = true,
  },
  {
    type = 'pwa-node',
    request = 'launch',
    name = 'Debug Jest Tests',
    runtimeExecutable = 'node',
    runtimeArgs = {
      './node_modules/.bin/jest',
      '--runInBand',
    },
    rootPath = '${workspaceFolder}',
    cwd = '${workspaceFolder}',
    console = 'integratedTerminal',
    internalConsoleOptions = 'neverOpen',
  }
}

end

-- Neotest setup for JavaScript/TypeScript tests (only if neotest is available)
local ok_neotest, neotest = pcall(require, 'neotest')
if ok_neotest then
  local neotest_adapters = {}
  
  -- Add Go adapter if available
  local ok_go, neotest_go = pcall(require, 'neotest-go')
  if ok_go then
    table.insert(neotest_adapters, neotest_go)
  end

  -- Add Jest adapter if available
  local ok_jest, neotest_jest = pcall(require, 'neotest-jest')
  if ok_jest then
    table.insert(neotest_adapters, neotest_jest({
      jestCommand = "npm test --",
      jestConfigFile = "jest.config.js",
      env = { CI = true },
      cwd = function(path)
        return vim.fn.getcwd()
      end,
    }))
  end

  -- Add Vitest adapter if available
  local ok_vitest, neotest_vitest = pcall(require, 'neotest-vitest')
  if ok_vitest then
    table.insert(neotest_adapters, neotest_vitest)
  end

  neotest.setup({
    adapters = neotest_adapters,
  })
end

-- Node.js specific keybindings
local function map(mode, lhs, rhs, opts)
  opts = opts or {}
  opts.silent = opts.silent ~= false
  vim.keymap.set(mode, lhs, rhs, opts)
end

-- Package.json management (only if package-info is available)
if ok_package_info then
  map('n', '<leader>ns', package_info.show, { desc = 'Show package info' })
  map('n', '<leader>nc', package_info.hide, { desc = 'Hide package info' })
  map('n', '<leader>nt', package_info.toggle, { desc = 'Toggle package info' })
  map('n', '<leader>nu', package_info.update, { desc = 'Update package' })
  map('n', '<leader>nd', package_info.delete, { desc = 'Delete package' })
  map('n', '<leader>ni', package_info.install, { desc = 'Install package' })
  map('n', '<leader>np', package_info.change_version, { desc = 'Change package version' })
end

-- NPM/Node commands
map('n', '<leader>nr', ':!npm run ', { desc = 'Run npm script' })
map('n', '<leader>nI', ':!npm install<CR>', { desc = 'npm install' })
map('n', '<leader>nT', ':!npm test<CR>', { desc = 'npm test' })
map('n', '<leader>nS', ':!npm start<CR>', { desc = 'npm start' })
map('n', '<leader>nB', ':!npm run build<CR>', { desc = 'npm build' })
map('n', '<leader>nD', ':!npm run dev<CR>', { desc = 'npm dev' })

-- Debugging (only if dap is available)
if ok_dap then
  map('n', '<leader>jd', function() dap.continue() end, { desc = 'JS Debug continue' })
  map('n', '<leader>jD', function() dap.toggle_breakpoint() end, { desc = 'JS Toggle breakpoint' })
  map('n', '<leader>jr', function() dap.repl.open() end, { desc = 'JS Debug REPL' })
end

-- Testing with neotest (only if neotest is available)
if ok_neotest then
  map('n', '<leader>jt', function() neotest.run.run() end, { desc = 'Run nearest JS test' })
  map('n', '<leader>jf', function() neotest.run.run(vim.fn.expand('%')) end, { desc = 'Run JS file tests' })
  map('n', '<leader>js', function() neotest.summary.toggle() end, { desc = 'JS Test summary' })
end

-- Formatting (only if prettier is available)
if ok_prettier then
  map('n', '<leader>jp', ':Prettier<CR>', { desc = 'Format with Prettier' })
end

-- File type specific settings
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
  callback = function()
    -- Enable inlay hints if supported
    if vim.lsp.inlay_hint then
      vim.lsp.inlay_hint.enable(true)
    end
    
    -- Set up formatting on save
    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = vim.api.nvim_get_current_buf(),
      callback = function()
        vim.lsp.buf.format({ async = false })
      end,
    })
  end,
})