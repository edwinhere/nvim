-- Python development configuration

-- Function to check if we're in a virtual environment
local function in_virtualenv()
  return vim.env.VIRTUAL_ENV ~= nil
end

-- Function to get Python executable
local function get_python_path()
  if in_virtualenv() then
    return vim.env.VIRTUAL_ENV .. '/bin/python'
  end
  -- Try common Python paths
  local python_paths = {
    vim.fn.executable('python3') == 1 and vim.fn.exepath('python3'),
    vim.fn.executable('python') == 1 and vim.fn.exepath('python'),
    '/usr/bin/python3',
    '/usr/local/bin/python3'
  }
  
  for _, path in ipairs(python_paths) do
    if path and vim.fn.executable(path) == 1 then
      return path
    end
  end
  
  return 'python3' -- fallback
end

-- Debug adapter setup for Python (only if available)
local ok_dap, dap = pcall(require, 'dap')
local ok_dap_python, dap_python = pcall(require, 'dap-python')

if ok_dap and ok_dap_python then
  -- Setup debugpy
  dap_python.setup(get_python_path())
  
  -- Custom configurations
  table.insert(dap.configurations.python, {
    type = 'python',
    request = 'launch',
    name = 'Launch current file',
    program = '${file}',
    pythonPath = get_python_path(),
    console = 'integratedTerminal',
  })
  
  table.insert(dap.configurations.python, {
    type = 'python',
    request = 'launch',
    name = 'Django',
    program = vim.fn.getcwd() .. '/manage.py',
    args = {'runserver'},
    pythonPath = get_python_path(),
    console = 'integratedTerminal',
  })
  
  table.insert(dap.configurations.python, {
    type = 'python',
    request = 'launch',
    name = 'FastAPI',
    module = 'uvicorn',
    args = {'main:app', '--reload'},
    pythonPath = get_python_path(),
    console = 'integratedTerminal',
  })
  
  table.insert(dap.configurations.python, {
    type = 'python',
    request = 'launch',
    name = 'Flask',
    module = 'flask',
    env = {
      FLASK_APP = 'app.py',
      FLASK_ENV = 'development',
    },
    args = {'run', '--no-debugger', '--no-reload'},
    pythonPath = get_python_path(),
    console = 'integratedTerminal',
  })
end

-- Neotest setup for Python tests (only if neotest is available)
local ok_neotest, neotest = pcall(require, 'neotest')
if ok_neotest then
  local neotest_adapters = {}
  
  -- Add existing adapters from other languages
  local ok_go, neotest_go = pcall(require, 'neotest-go')
  if ok_go then
    table.insert(neotest_adapters, neotest_go)
  end
  
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
  
  local ok_vitest, neotest_vitest = pcall(require, 'neotest-vitest')
  if ok_vitest then
    table.insert(neotest_adapters, neotest_vitest)
  end
  
  -- Add Python adapter if available
  local ok_python, neotest_python = pcall(require, 'neotest-python')
  if ok_python then
    table.insert(neotest_adapters, neotest_python({
      dap = { justMyCode = false },
      args = {"--log-level", "DEBUG"},
      runner = "pytest",
      python = get_python_path(),
    }))
  end
  
  neotest.setup({
    adapters = neotest_adapters,
    output = {
      enabled = true,
      open_on_run = "short",
    },
  })
end

-- Python specific keybindings
local function map(mode, lhs, rhs, opts)
  opts = opts or {}
  opts.silent = opts.silent ~= false
  vim.keymap.set(mode, lhs, rhs, opts)
end

-- Python execution
map('n', '<leader>pr', ':!python %<CR>', { desc = 'Run Python file' })
map('n', '<leader>pi', ':!python -i %<CR>', { desc = 'Run Python interactive' })
map('n', '<leader>pp', ':!python3 %<CR>', { desc = 'Run Python3 file' })

-- Virtual environment management
map('n', '<leader>pv', function()
  local venv = vim.fn.input('Virtual environment path: ', vim.fn.getcwd() .. '/venv')
  if venv ~= '' then
    vim.env.VIRTUAL_ENV = venv
    vim.env.PATH = venv .. '/bin:' .. vim.env.PATH
    print('Activated virtual environment: ' .. venv)
  end
end, { desc = 'Activate virtual environment' })

-- Package management
map('n', '<leader>pI', ':!pip install ', { desc = 'pip install' })
map('n', '<leader>pU', ':!pip install --upgrade ', { desc = 'pip upgrade' })
map('n', '<leader>pS', ':!pip show ', { desc = 'pip show' })
map('n', '<leader>pF', ':!pip freeze > requirements.txt<CR>', { desc = 'pip freeze to requirements.txt' })
map('n', '<leader>pR', ':!pip install -r requirements.txt<CR>', { desc = 'pip install from requirements.txt' })

-- Django specific commands
map('n', '<leader>dm', ':!python manage.py migrate<CR>', { desc = 'Django migrate' })
map('n', '<leader>dmm', ':!python manage.py makemigrations<CR>', { desc = 'Django makemigrations' })
map('n', '<leader>dr', ':!python manage.py runserver<CR>', { desc = 'Django runserver' })
map('n', '<leader>ds', ':!python manage.py shell<CR>', { desc = 'Django shell' })
map('n', '<leader>dt', ':!python manage.py test<CR>', { desc = 'Django test' })
map('n', '<leader>dc', ':!python manage.py collectstatic<CR>', { desc = 'Django collectstatic' })

-- Testing with pytest
map('n', '<leader>pt', ':!pytest<CR>', { desc = 'Run pytest' })
map('n', '<leader>ptv', ':!pytest -v<CR>', { desc = 'Run pytest verbose' })
map('n', '<leader>ptf', ':!pytest %<CR>', { desc = 'Run pytest on current file' })
map('n', '<leader>ptc', ':!pytest --cov<CR>', { desc = 'Run pytest with coverage' })

-- Debugging (only if dap is available)
if ok_dap and ok_dap_python then
  map('n', '<leader>pd', function() dap.continue() end, { desc = 'Python Debug continue' })
  map('n', '<leader>pD', function() dap.toggle_breakpoint() end, { desc = 'Python Toggle breakpoint' })
  map('n', '<leader>pdr', function() dap.repl.open() end, { desc = 'Python Debug REPL' })
  map('n', '<leader>pdl', function() dap.run_last() end, { desc = 'Python Debug run last' })
end

-- Testing with neotest (only if neotest is available)
if ok_neotest then
  map('n', '<leader>pnt', function() neotest.run.run() end, { desc = 'Run nearest Python test' })
  map('n', '<leader>pnf', function() neotest.run.run(vim.fn.expand('%')) end, { desc = 'Run Python file tests' })
  map('n', '<leader>pns', function() neotest.summary.toggle() end, { desc = 'Python Test summary' })
  map('n', '<leader>pno', function() neotest.output.open({ enter = true }) end, { desc = 'Show test output' })
end

-- Formatting with Black (if available)
local ok_black = vim.fn.executable('black') == 1
if ok_black then
  map('n', '<leader>pb', ':!black %<CR>', { desc = 'Format with Black' })
  map('n', '<leader>pB', ':!black .<CR>', { desc = 'Format all Python files with Black' })
end

-- Linting with ruff (if available)
local ok_ruff = vim.fn.executable('ruff') == 1
if ok_ruff then
  map('n', '<leader>pl', ':!ruff check %<CR>', { desc = 'Lint with ruff' })
  map('n', '<leader>pL', ':!ruff check .<CR>', { desc = 'Lint all files with ruff' })
  map('n', '<leader>pf', ':!ruff check --fix %<CR>', { desc = 'Fix with ruff' })
end

-- Auto-formatting on save for Python files
vim.api.nvim_create_autocmd("FileType", {
  pattern = "python",
  callback = function()
    -- Set up formatting on save if Black is available
    if ok_black then
      vim.api.nvim_create_autocmd("BufWritePre", {
        buffer = vim.api.nvim_get_current_buf(),
        callback = function()
          vim.cmd('silent !black --quiet %')
          vim.cmd('edit!')
        end,
      })
    end
    
    -- Set Python-specific options
    vim.opt_local.tabstop = 4
    vim.opt_local.shiftwidth = 4
    vim.opt_local.expandtab = true
    vim.opt_local.autoindent = true
    vim.opt_local.smartindent = true
    
    -- Enable folding for Python
    vim.opt_local.foldmethod = 'indent'
    vim.opt_local.foldlevel = 99
  end,
})

-- REPL integration
map('n', '<leader>pR', function()
  vim.cmd('split')
  vim.cmd('terminal python')
end, { desc = 'Open Python REPL' })

-- Jupyter notebook support (if available)
local ok_jupytext = vim.fn.executable('jupytext') == 1
if ok_jupytext then
  map('n', '<leader>pj', ':!jupytext --to notebook %<CR>', { desc = 'Convert to Jupyter notebook' })
  map('n', '<leader>pJ', ':!jupytext --to py %<CR>', { desc = 'Convert from Jupyter notebook' })
end