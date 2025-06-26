-- Java development configuration

-- Function to find Java installation
local function find_java_executable()
  local java_paths = {
    vim.env.JAVA_HOME and vim.env.JAVA_HOME .. '/bin/java',
    '/usr/lib/jvm/default-java/bin/java',
    '/usr/lib/jvm/java-11-openjdk/bin/java',
    '/usr/lib/jvm/java-17-openjdk/bin/java',
    '/usr/lib/jvm/java-21-openjdk/bin/java',
    -- macOS paths
    '/Library/Java/JavaVirtualMachines/openjdk-11.jdk/Contents/Home/bin/java',
    '/Library/Java/JavaVirtualMachines/openjdk-17.jdk/Contents/Home/bin/java',
    '/Library/Java/JavaVirtualMachines/openjdk-21.jdk/Contents/Home/bin/java',
    vim.fn.executable('java') == 1 and vim.fn.exepath('java'),
  }
  
  for _, path in ipairs(java_paths) do
    if path and vim.fn.executable(path) == 1 then
      return path
    end
  end
  
  return 'java' -- fallback
end

-- Function to find JDTLS installation path
local function get_jdtls_install_path()
  local possible_paths = {
    vim.fn.expand('~/.local/share/nvim/mason/packages/jdtls'),
    vim.fn.expand('~/.local/share/eclipse.jdt.ls'),
    '/opt/jdtls',
    '/usr/local/share/java/jdtls',
  }
  
  for _, path in ipairs(possible_paths) do
    if vim.fn.isdirectory(path) == 1 then
      return path
    end
  end
  
  return nil
end

-- Function to get workspace directory
local function get_workspace_dir()
  local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
  return vim.fn.expand('~/.cache/jdtls/workspace/') .. project_name
end

-- Function to detect project type
local function detect_project_type()
  local cwd = vim.fn.getcwd()
  if vim.fn.filereadable(cwd .. '/pom.xml') == 1 then
    return 'maven'
  elseif vim.fn.filereadable(cwd .. '/build.gradle') == 1 or vim.fn.filereadable(cwd .. '/build.gradle.kts') == 1 then
    return 'gradle'
  end
  return 'plain'
end

-- JDTLS setup (only if available)
local ok_jdtls, jdtls = pcall(require, 'jdtls')
if ok_jdtls then
  local jdtls_path = get_jdtls_install_path()
  
  if jdtls_path then
    -- JDTLS configuration
    local config = {
      cmd = {
        find_java_executable(),
        '-Declipse.application=org.eclipse.jdt.ls.core.id1',
        '-Dosgi.bundles.defaultStartLevel=4',
        '-Declipse.product=org.eclipse.jdt.ls.core.product',
        '-Dlog.protocol=true',
        '-Dlog.level=ALL',
        '-Xms1g',
        '--add-modules=ALL-SYSTEM',
        '--add-opens', 'java.base/java.util=ALL-UNNAMED',
        '--add-opens', 'java.base/java.lang=ALL-UNNAMED',
        '-jar', vim.fn.glob(jdtls_path .. '/plugins/org.eclipse.equinox.launcher_*.jar'),
        '-configuration', jdtls_path .. '/config_linux',
        '-data', get_workspace_dir(),
      },
      root_dir = vim.fs.dirname(vim.fs.find({'gradlew', '.git', 'mvnw', 'pom.xml', 'build.gradle'}, { upward = true })[1]),
      settings = {
        java = {
          eclipse = {
            downloadSources = true,
          },
          configuration = {
            updateBuildConfiguration = "interactive",
          },
          maven = {
            downloadSources = true,
          },
          implementationsCodeLens = {
            enabled = true,
          },
          referencesCodeLens = {
            enabled = true,
          },
          references = {
            includeDecompiledSources = true,
          },
          format = {
            enabled = true,
            settings = {
              url = vim.fn.stdpath("config") .. "/lang-servers/intellij-java-google-style.xml",
              profile = "GoogleStyle",
            },
          },
        },
        signatureHelp = { enabled = true },
        completion = {
          favoriteStaticMembers = {
            "org.hamcrest.MatcherAssert.assertThat",
            "org.hamcrest.Matchers.*",
            "org.hamcrest.CoreMatchers.*",
            "org.junit.jupiter.api.Assertions.*",
            "java.util.Objects.requireNonNull",
            "java.util.Objects.requireNonNullElse",
            "org.mockito.Mockito.*",
          },
        },
        contentProvider = { preferred = 'fernflower' },
        extendedClientCapabilities = jdtls.extendedClientCapabilities,
        sources = {
          organizeImports = {
            starThreshold = 9999,
            staticStarThreshold = 9999,
          },
        },
        codeGeneration = {
          toString = {
            template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
          },
          useBlocks = true,
        },
      },
      flags = {
        allow_incremental_sync = true,
      },
      init_options = {
        bundles = {},
      },
    }

    -- Auto-start JDTLS for Java files
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "java",
      callback = function()
        jdtls.start_or_attach(config)
      end,
    })
  end
end

-- Debug adapter setup for Java (only if available)
local ok_dap, dap = pcall(require, 'dap')
if ok_dap then
  dap.configurations.java = {
    {
      type = 'java',
      request = 'attach',
      name = "Debug (Attach) - Remote",
      hostName = "127.0.0.1",
      port = 5005,
    },
    {
      type = 'java',
      request = 'launch',
      name = "Debug (Launch) - Current File",
      program = "${file}",
    },
  }
end

-- Neotest setup for Java tests (only if neotest is available)
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
  
  local ok_python, neotest_python = pcall(require, 'neotest-python')
  if ok_python then
    table.insert(neotest_adapters, neotest_python({
      dap = { justMyCode = false },
      args = {"--log-level", "DEBUG"},
      runner = "pytest",
    }))
  end
  
  -- Note: Java testing is handled directly through JDTLS and manual commands
  -- No specific neotest adapter needed as JDTLS provides test integration
  
  neotest.setup({
    adapters = neotest_adapters,
    output = {
      enabled = true,
      open_on_run = "short",
    },
  })
end

-- Java specific keybindings
local function map(mode, lhs, rhs, opts)
  opts = opts or {}
  opts.silent = opts.silent ~= false
  vim.keymap.set(mode, lhs, rhs, opts)
end

-- Project type detection and build commands
local function run_build_command()
  local project_type = detect_project_type()
  if project_type == 'maven' then
    vim.cmd('!mvn compile')
  elseif project_type == 'gradle' then
    vim.cmd('!./gradlew build')
  else
    vim.cmd('!javac *.java')
  end
end

local function run_test_command()
  local project_type = detect_project_type()
  if project_type == 'maven' then
    vim.cmd('!mvn test')
  elseif project_type == 'gradle' then
    vim.cmd('!./gradlew test')
  else
    print("No build system detected. Please run tests manually.")
  end
end

local function run_project()
  local project_type = detect_project_type()
  if project_type == 'maven' then
    vim.cmd('!mvn exec:java')
  elseif project_type == 'gradle' then
    vim.cmd('!./gradlew run')
  else
    -- Try to find main class
    local main_class = vim.fn.input('Main class: ', 'Main')
    if main_class ~= '' then
      vim.cmd('!java ' .. main_class)
    end
  end
end

-- Building & Running
map('n', '<leader>jb', run_build_command, { desc = 'Build Java project' })
map('n', '<leader>jr', run_project, { desc = 'Run Java project' })
map('n', '<leader>jc', ':!javac %<CR>', { desc = 'Compile current Java file' })
map('n', '<leader>jR', function()
  local file = vim.fn.expand('%:t:r')
  vim.cmd('!java ' .. file)
end, { desc = 'Run current Java file' })

-- Maven specific commands
map('n', '<leader>mc', ':!mvn clean<CR>', { desc = 'Maven clean' })
map('n', '<leader>mC', ':!mvn compile<CR>', { desc = 'Maven compile' })
map('n', '<leader>mt', ':!mvn test<CR>', { desc = 'Maven test' })
map('n', '<leader>mp', ':!mvn package<CR>', { desc = 'Maven package' })
map('n', '<leader>mi', ':!mvn install<CR>', { desc = 'Maven install' })
map('n', '<leader>me', ':!mvn exec:java<CR>', { desc = 'Maven exec:java' })

-- Gradle specific commands
map('n', '<leader>gc', ':!./gradlew clean<CR>', { desc = 'Gradle clean' })
map('n', '<leader>gC', ':!./gradlew compileJava<CR>', { desc = 'Gradle compile' })
map('n', '<leader>gt', ':!./gradlew test<CR>', { desc = 'Gradle test' })
map('n', '<leader>gb', ':!./gradlew build<CR>', { desc = 'Gradle build' })
map('n', '<leader>gr', ':!./gradlew run<CR>', { desc = 'Gradle run' })

-- Testing
map('n', '<leader>jt', run_test_command, { desc = 'Run Java tests' })
map('n', '<leader>jtf', function()
  local file = vim.fn.expand('%:t:r')
  local project_type = detect_project_type()
  if project_type == 'maven' then
    vim.cmd('!mvn test -Dtest=' .. file)
  elseif project_type == 'gradle' then
    vim.cmd('!./gradlew test --tests ' .. file)
  else
    print("No build system detected for single test execution.")
  end
end, { desc = 'Run tests for current file' })

-- JDTLS specific commands (only if available)
if ok_jdtls then
  map('n', '<leader>jo', function() jdtls.organize_imports() end, { desc = 'Organize imports' })
  map('n', '<leader>jv', function() jdtls.extract_variable() end, { desc = 'Extract variable' })
  map('n', '<leader>jV', function() jdtls.extract_variable(true) end, { desc = 'Extract variable (visual)' })
  map('n', '<leader>jm', function() jdtls.extract_method(true) end, { desc = 'Extract method' })
  map('n', '<leader>jM', function() jdtls.extract_method() end, { desc = 'Extract method (visual)' })
  map('n', '<leader>jc', function() jdtls.extract_constant() end, { desc = 'Extract constant' })
  map('n', '<leader>jt', function() jdtls.test_nearest_method() end, { desc = 'Test nearest method' })
  map('n', '<leader>jT', function() jdtls.test_class() end, { desc = 'Test class' })
  map('n', '<leader>ju', function() jdtls.update_projects_config() end, { desc = 'Update project config' })
end

-- Debugging (only if dap is available)
if ok_dap then
  map('n', '<leader>jd', function() dap.continue() end, { desc = 'Java Debug continue' })
  map('n', '<leader>jD', function() dap.toggle_breakpoint() end, { desc = 'Java Toggle breakpoint' })
  map('n', '<leader>jdr', function() dap.repl.open() end, { desc = 'Java Debug REPL' })
  map('n', '<leader>jdl', function() dap.run_last() end, { desc = 'Java Debug run last' })
end

-- JDTLS testing integration (only if JDTLS is available)
if ok_jdtls then
  map('n', '<leader>jnt', function() jdtls.test_nearest_method() end, { desc = 'Run nearest Java test' })
  map('n', '<leader>jnc', function() jdtls.test_class() end, { desc = 'Run Java test class' })
end

-- Dependency management
map('n', '<leader>jdm', function()
  local project_type = detect_project_type()
  if project_type == 'maven' then
    vim.cmd('!mvn dependency:tree')
  elseif project_type == 'gradle' then
    vim.cmd('!./gradlew dependencies')
  else
    print("No build system detected for dependency management.")
  end
end, { desc = 'Show dependencies' })

-- Code generation helpers
map('n', '<leader>jg', function()
  local class_name = vim.fn.input('Class name: ')
  if class_name ~= '' then
    local lines = {
      'public class ' .. class_name .. ' {',
      '    public ' .. class_name .. '() {',
      '        // Constructor',
      '    }',
      '',
      '    public static void main(String[] args) {',
      '        // Main method',
      '    }',
      '}'
    }
    vim.api.nvim_put(lines, 'l', true, true)
  end
end, { desc = 'Generate class template' })

-- JAR operations
map('n', '<leader>jj', function()
  local jar_name = vim.fn.input('JAR name: ', 'app.jar')
  if jar_name ~= '' then
    vim.cmd('!jar -cvf ' .. jar_name .. ' *.class')
  end
end, { desc = 'Create JAR file' })

map('n', '<leader>jJ', function()
  local jar_file = vim.fn.input('JAR file: ')
  if jar_file ~= '' then
    vim.cmd('!java -jar ' .. jar_file)
  end
end, { desc = 'Run JAR file' })

-- Auto-formatting and settings for Java files
vim.api.nvim_create_autocmd("FileType", {
  pattern = "java",
  callback = function()
    -- Set Java-specific options
    vim.opt_local.tabstop = 4
    vim.opt_local.shiftwidth = 4
    vim.opt_local.expandtab = true
    vim.opt_local.autoindent = true
    vim.opt_local.smartindent = true
    
    -- Enable folding for Java
    vim.opt_local.foldmethod = 'syntax'
    vim.opt_local.foldlevel = 99
    
    -- Set up formatting on save if available
    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = vim.api.nvim_get_current_buf(),
      callback = function()
        vim.lsp.buf.format({ async = false })
      end,
    })
  end,
})

-- Spring Boot specific commands
map('n', '<leader>spr', ':!./mvnw spring-boot:run<CR>', { desc = 'Spring Boot run (Maven)' })
map('n', '<leader>spg', ':!./gradlew bootRun<CR>', { desc = 'Spring Boot run (Gradle)' })
map('n', '<leader>spt', ':!./mvnw spring-boot:test<CR>', { desc = 'Spring Boot test (Maven)' })
map('n', '<leader>spb', ':!./mvnw spring-boot:build-image<CR>', { desc = 'Spring Boot build image (Maven)' })