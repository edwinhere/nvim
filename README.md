# Neovim Configuration Keybindings

This document outlines all keybindings and their functionalities in this Neovim configuration.

## LSP (Language Server Protocol)

*These keybindings are provided by lsp-zero default mappings*

| Keybinding   | Mode   | Description               |
|--------------|--------|---------------------------|
| `K`          | Normal | Hover documentation       |
| `gd`         | Normal | Go to definition         |
| `gD`         | Normal | Go to declaration        |
| `gi`         | Normal | Go to implementation     |
| `gr`         | Normal | Show references          |
| `gs`         | Normal | Show signature help      |
| `<leader>rn` | Normal | Rename symbol            |
| `<leader>ca` | Normal | Code actions             |
| `<leader>f`  | Normal | Format file (LSP)        |
| `[d`         | Normal | Previous diagnostic      |
| `]d`         | Normal | Next diagnostic          |

## Autocompletion

| Keybinding   | Mode   | Description              |
|--------------|--------|--------------------------|
| `<C-Space>`  | Insert | Trigger autocompletion   |
| `<CR>`       | Insert | Confirm selection        |
| `<C-f>`      | Insert | Jump forward in snippet  |
| `<C-b>`      | Insert | Jump backward in snippet |

## Telescope

| Keybinding   | Mode   | Description              |
|--------------|--------|--------------------------|
| `<leader>e`  | Normal | Find files              |
| `<leader>gf` | Normal | Git files               |
| `<leader>f`  | Normal | Live grep (Telescope)   |
| `<leader>b`  | Normal | Buffers                 |
| `<leader>?`  | Normal | Help tags               |
| `<leader>m`  | Normal | Man pages               |
| `<F1>`       | Normal | Colorscheme picker      |
| `<leader>r`  | Normal | Registers               |
| `<leader>k`  | Normal | Keymaps                 |
| `<leader>t`  | Normal | Treesitter              |

## File Explorer (NvimTree)

| Keybinding | Mode   | Description                |
|------------|--------|----------------------------|
| `<F3>`     | Normal | Toggle file explorer      |
| `<F2>`     | Normal | Find current file in tree |

## Git

| Keybinding   | Mode   | Description        |
|--------------|--------|--------------------|
| `<leader>gg` | Normal | Open LazyGit      |

## Buffer Navigation

| Keybinding   | Mode   | Description           |
|--------------|--------|-----------------------|
| `<leader>z`  | Normal | Previous buffer       |
| `<leader>q`  | Normal | Previous buffer       |
| `<leader>x`  | Normal | Next buffer          |
| `<leader>w`  | Normal | Next buffer          |
| `<leader>c`  | Normal | Close buffer         |

## Window Management

| Keybinding   | Mode   | Description           |
|--------------|--------|-----------------------|
| `<leader>h`  | Normal | Split horizontal     |
| `<leader>v`  | Normal | Split vertical       |
| `<C-h>`      | Normal | Move to left window  |
| `<C-j>`      | Normal | Move to bottom window|
| `<C-k>`      | Normal | Move to top window   |
| `<C-l>`      | Normal | Move to right window |

## Terminal

| Keybinding   | Mode   | Description        |
|--------------|--------|--------------------|
| `<leader>sh` | Normal | Open terminal      |

## Clipboard Operations

| Keybinding   | Mode   | Description        |
|--------------|--------|--------------------|
| `YY`         | Normal | Copy to clipboard  |
| `<leader>p`  | Normal | Paste from clipboard|
| `XX`         | Normal | Cut to clipboard   |

## Visual Mode Operations

| Keybinding | Mode   | Description                |
|------------|--------|----------------------------|
| `J`        | Visual | Move block down            |
| `K`        | Visual | Move block up              |
| `<`        | Visual | Indent left (keeps selection) |
| `>`        | Visual | Indent right (keeps selection)|

## Search

| Keybinding        | Mode   | Description        |
|-------------------|--------|--------------------|
| `n`               | Normal | Next search result (centered) |
| `N`               | Normal | Previous search result (centered) |
| `<leader><space>` | Normal | Clear search highlighting |

## AI Assistant (Claude Code)

| Keybinding   | Mode   | Description                    |
|--------------|--------|--------------------------------|
| `<C-,>`      | Normal | Toggle Claude Code terminal    |
| `<leader>cc` | Normal | Continue Claude Code conversation |
| `<leader>cv` | Normal | Start Claude Code in verbose mode |
| `<leader>cn` | Normal | Start new Claude Code chat     |

## Go Development

### Building & Running
| Keybinding   | Mode   | Description        |
|--------------|--------|--------------------| 
| `<leader>gb` | Normal | Build Go project   |
| `<leader>gr` | Normal | Run Go main        |

### Testing
| Keybinding   | Mode   | Description              |
|--------------|--------|--------------------------|
| `<leader>gt` | Normal | Run Go tests             |
| `<leader>gT` | Normal | Run Go test function     |
| `<leader>gc` | Normal | Toggle Go coverage       |
| `<leader>tn` | Normal | Run nearest test         |
| `<leader>tf` | Normal | Run file tests          |
| `<leader>ts` | Normal | Test summary             |

### Debugging
| Keybinding   | Mode   | Description        |
|--------------|--------|--------------------| 
| `<leader>gd` | Normal | Go Debug continue  |
| `<leader>gD` | Normal | Toggle breakpoint  |

### Go Commands
- `:GoTest` - Run tests
- `:GoTestFunc` - Test function under cursor
- `:GoBuild` - Build with error list
- `:GoRun` - Run current file
- `:GoCoverage` - Show coverage
- `:GoDoc` - Show documentation
- `:GoRename` - Rename symbol
- `:GoFillStruct` - Fill struct literals
- `:GoInstallBinaries` - Install Go tools

### Features
- Auto-formatting with `goimports` on save
- Static analysis via gopls
- Syntax highlighting for Go constructs
- Unused parameter detection
- Import management
- Code completion and diagnostics

## Haskell Development

### Building & Running
| Keybinding   | Mode   | Description              |
|--------------|--------|--------------------------|
| `<leader>hc` | Normal | Compile with GHC         |
| `<leader>hr` | Normal | Run with runhaskell      |
| `<leader>hi` | Normal | Open GHCi REPL          |

### Cabal Projects
| Keybinding   | Mode   | Description        |
|--------------|--------|--------------------|
| `<leader>cb` | Normal | Build project      |
| `<leader>ct` | Normal | Run tests          |
| `<leader>cr` | Normal | Run executable     |

### Stack Projects
| Keybinding   | Mode   | Description        |
|--------------|--------|--------------------|
| `<leader>sb` | Normal | Stack build        |
| `<leader>st` | Normal | Stack test         |
| `<leader>sr` | Normal | Stack run          |
| `<leader>sg` | Normal | Stack GHCi         |

### Formatting
| Keybinding   | Mode   | Description              |
|--------------|--------|--------------------------|
| `<leader>hf` | Normal | Format with Ormolu       |
| `<leader>f`  | Normal | LSP formatting           |

### Features
- Haskell Language Server (HLS) integration
- Advanced syntax highlighting (forall, mdo, proc, patterns)
- Auto-indentation with hindent (runs on save)
- Ormolu formatting support
- Real-time error diagnostics
- Code completion and hover documentation
- Cabal and Stack project support

### Prerequisites
Install Haskell toolchain:
```bash
ghcup install ghc
ghcup install cabal
ghcup install stack
ghcup install hls
cabal install ormolu
cabal install hindent
```

## Node.js/JavaScript/TypeScript Development

### Package Management
| Keybinding   | Mode   | Description              |
|--------------|--------|--------------------------|
| `<leader>ns` | Normal | Show package info        |
| `<leader>nc` | Normal | Hide package info        |
| `<leader>nt` | Normal | Toggle package info      |
| `<leader>nu` | Normal | Update package           |
| `<leader>nd` | Normal | Delete package           |
| `<leader>ni` | Normal | Install package          |
| `<leader>np` | Normal | Change package version   |

### NPM Commands
| Keybinding   | Mode   | Description              |
|--------------|--------|--------------------------|
| `<leader>nr` | Normal | Run npm script           |
| `<leader>nI` | Normal | npm install              |
| `<leader>nT` | Normal | npm test                 |
| `<leader>nS` | Normal | npm start                |
| `<leader>nB` | Normal | npm run build            |
| `<leader>nD` | Normal | npm run dev              |

### Testing
| Keybinding   | Mode   | Description              |
|--------------|--------|--------------------------|
| `<leader>jt` | Normal | Run nearest JS test      |
| `<leader>jf` | Normal | Run JS file tests        |
| `<leader>js` | Normal | JS Test summary          |

### Debugging
| Keybinding   | Mode   | Description              |
|--------------|--------|--------------------------|
| `<leader>jd` | Normal | JS Debug continue        |
| `<leader>jD` | Normal | JS Toggle breakpoint     |
| `<leader>jr` | Normal | JS Debug REPL            |

### Formatting
| Keybinding   | Mode   | Description              |
|--------------|--------|--------------------------|
| `<leader>jp` | Normal | Format with Prettier     |

### Features
- **TypeScript Language Server** with inlay hints for parameters, types, and return values
- **ESLint integration** for real-time linting and code actions
- **Prettier formatting** with customizable rules and auto-format on save
- **Package.json management** with visual dependency info and version updates
- **Jest and Vitest test runners** with nearest test execution
- **VS Code JS Debug** adapter for Node.js debugging with breakpoints
- **Auto-formatting on save** for JS/TS files
- **Enhanced syntax highlighting** for JavaScript, TypeScript, JSX, TSX
- **Spell checking** with cspell (when available)
- **null-ls integration** for additional formatting and linting tools
- **Graceful degradation** - Features only activate when plugins are installed

### Prerequisites
Install Node.js toolchain:
```bash
# Install Node.js via nvm (recommended)
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash
nvm install --lts
nvm use --lts

# Install global development tools
npm install -g typescript eslint prettier @typescript-eslint/parser @typescript-eslint/eslint-plugin
npm install -g ts-node jest @types/node
npm install -g js-debug-adapter  # For debugging support

# Optional: Install spell checker
npm install -g cspell
```

## Python Development

### Python Execution
| Keybinding   | Mode   | Description              |
|--------------|--------|--------------------------|
| `<leader>pr` | Normal | Run Python file         |
| `<leader>pi` | Normal | Run Python interactive  |
| `<leader>pp` | Normal | Run Python3 file        |
| `<leader>pR` | Normal | Open Python REPL        |

### Virtual Environment Management
| Keybinding   | Mode   | Description              |
|--------------|--------|--------------------------|
| `<leader>pv` | Normal | Activate virtual environment |

### Package Management
| Keybinding   | Mode   | Description              |
|--------------|--------|--------------------------|
| `<leader>pI` | Normal | pip install             |
| `<leader>pU` | Normal | pip upgrade             |
| `<leader>pS` | Normal | pip show                |
| `<leader>pF` | Normal | pip freeze to requirements.txt |
| `<leader>pR` | Normal | pip install from requirements.txt |

### Django Development
| Keybinding   | Mode   | Description              |
|--------------|--------|--------------------------|
| `<leader>dm` | Normal | Django migrate          |
| `<leader>dmm`| Normal | Django makemigrations   |
| `<leader>dr` | Normal | Django runserver        |
| `<leader>ds` | Normal | Django shell            |
| `<leader>dt` | Normal | Django test             |
| `<leader>dc` | Normal | Django collectstatic    |

### Testing
| Keybinding   | Mode   | Description              |
|--------------|--------|--------------------------|
| `<leader>pt` | Normal | Run pytest              |
| `<leader>ptv`| Normal | Run pytest verbose      |
| `<leader>ptf`| Normal | Run pytest on current file |
| `<leader>ptc`| Normal | Run pytest with coverage |
| `<leader>pnt`| Normal | Run nearest Python test (neotest) |
| `<leader>pnf`| Normal | Run Python file tests (neotest) |
| `<leader>pns`| Normal | Python Test summary (neotest) |
| `<leader>pno`| Normal | Show test output (neotest) |

### Debugging
| Keybinding   | Mode   | Description              |
|--------------|--------|--------------------------|
| `<leader>pd` | Normal | Python Debug continue   |
| `<leader>pD` | Normal | Python Toggle breakpoint |
| `<leader>pdr`| Normal | Python Debug REPL       |
| `<leader>pdl`| Normal | Python Debug run last   |

### Formatting & Linting
| Keybinding   | Mode   | Description              |
|--------------|--------|--------------------------|
| `<leader>pb` | Normal | Format with Black        |
| `<leader>pB` | Normal | Format all files with Black |
| `<leader>pl` | Normal | Lint with ruff           |
| `<leader>pL` | Normal | Lint all files with ruff |
| `<leader>pf` | Normal | Fix with ruff            |

### Jupyter Notebook
| Keybinding   | Mode   | Description              |
|--------------|--------|--------------------------|
| `<leader>pj` | Normal | Convert to Jupyter notebook |
| `<leader>pJ` | Normal | Convert from Jupyter notebook |

### Features
- **Pyright Language Server** for type checking and intelligent code completion
- **Ruff integration** for fast linting and code formatting
- **Black formatter** with auto-format on save
- **pytest integration** with neotest for visual test running
- **debugpy support** for Python debugging with breakpoints
- **Django/FastAPI/Flask** debug configurations
- **Virtual environment detection** and management
- **Auto-indentation** with 4-space tabs (PEP 8 compliant)
- **Code folding** based on indentation
- **Jupyter notebook** conversion support
- **REPL integration** for interactive development
- **Graceful degradation** - Features only activate when tools are installed

### Prerequisites
Install Python development tools:
```bash
# Install Python (if not already installed)
# macOS: brew install python
# Ubuntu: sudo apt install python3 python3-pip python3-venv
# Windows: Download from python.org

# Install Python development tools
pip install --upgrade pip
pip install debugpy pytest black ruff pyright
pip install jupytext  # Optional: for Jupyter notebook support

# For Django development
pip install django

# For FastAPI development  
pip install fastapi uvicorn

# For Flask development
pip install flask

# Create and activate virtual environment (recommended)
python -m venv venv
source venv/bin/activate  # On Windows: venv\Scripts\activate
```

## Java Development

### Building & Running
| Keybinding   | Mode   | Description              |
|--------------|--------|--------------------------|
| `<leader>jb` | Normal | Build Java project      |
| `<leader>jr` | Normal | Run Java project        |
| `<leader>jc` | Normal | Compile current Java file |
| `<leader>jR` | Normal | Run current Java file    |

### Maven Commands
| Keybinding   | Mode   | Description              |
|--------------|--------|--------------------------|
| `<leader>mc` | Normal | Maven clean              |
| `<leader>mC` | Normal | Maven compile            |
| `<leader>mt` | Normal | Maven test               |
| `<leader>mp` | Normal | Maven package            |
| `<leader>mi` | Normal | Maven install            |
| `<leader>me` | Normal | Maven exec:java          |

### Gradle Commands
| Keybinding   | Mode   | Description              |
|--------------|--------|--------------------------|
| `<leader>gc` | Normal | Gradle clean             |
| `<leader>gC` | Normal | Gradle compile           |
| `<leader>gt` | Normal | Gradle test              |
| `<leader>gb` | Normal | Gradle build             |
| `<leader>gr` | Normal | Gradle run               |

### Testing
| Keybinding   | Mode   | Description              |
|--------------|--------|--------------------------|
| `<leader>jt` | Normal | Run Java tests          |
| `<leader>jtf`| Normal | Run tests for current file |
| `<leader>jnt`| Normal | Run nearest Java test (JDTLS) |
| `<leader>jnc`| Normal | Run Java test class (JDTLS) |

### JDTLS Code Actions
| Keybinding   | Mode   | Description              |
|--------------|--------|--------------------------|
| `<leader>jo` | Normal | Organize imports         |
| `<leader>jv` | Normal | Extract variable         |
| `<leader>jV` | Normal | Extract variable (visual) |
| `<leader>jm` | Normal | Extract method           |
| `<leader>jM` | Normal | Extract method (visual)  |
| `<leader>jc` | Normal | Extract constant         |
| `<leader>ju` | Normal | Update project config    |

### Debugging
| Keybinding   | Mode   | Description              |
|--------------|--------|--------------------------|
| `<leader>jd` | Normal | Java Debug continue      |
| `<leader>jD` | Normal | Java Toggle breakpoint   |
| `<leader>jdr`| Normal | Java Debug REPL          |
| `<leader>jdl`| Normal | Java Debug run last      |

### Dependency Management
| Keybinding   | Mode   | Description              |
|--------------|--------|--------------------------|
| `<leader>jdm`| Normal | Show dependencies        |

### JAR Operations
| Keybinding   | Mode   | Description              |
|--------------|--------|--------------------------|
| `<leader>jj` | Normal | Create JAR file          |
| `<leader>jJ` | Normal | Run JAR file             |

### Code Generation
| Keybinding   | Mode   | Description              |
|--------------|--------|--------------------------|
| `<leader>jg` | Normal | Generate class template  |

### Spring Boot Development
| Keybinding   | Mode   | Description              |
|--------------|--------|--------------------------|
| `<leader>spr`| Normal | Spring Boot run (Maven)  |
| `<leader>spg`| Normal | Spring Boot run (Gradle) |
| `<leader>spt`| Normal | Spring Boot test (Maven) |
| `<leader>spb`| Normal | Spring Boot build image (Maven) |

### Features
- **Eclipse JDT Language Server** with advanced Java support
- **Automatic project detection** (Maven, Gradle, or plain Java)
- **Code completion** with intelligent suggestions
- **Refactoring tools** (extract method, variable, constant)
- **Import organization** and dependency management
- **JUnit/TestNG integration** through JDTLS for test execution
- **Debugging support** with breakpoints and REPL
- **Maven and Gradle** build system integration
- **Spring Boot** development support
- **Code formatting** with Google Java Style (configurable)
- **JAR creation and execution** tools
- **Auto-indentation** with 4-space tabs
- **Syntax-based code folding**
- **Graceful degradation** - Features only activate when tools are installed

### Prerequisites
Install Java development tools:
```bash
# Install Java (JDK 11 or higher recommended)
# macOS: brew install openjdk@11 or openjdk@17
# Ubuntu: sudo apt install openjdk-11-jdk or openjdk-17-jdk
# Windows: Download from Oracle or use OpenJDK

# Set JAVA_HOME environment variable
export JAVA_HOME=/path/to/your/java/installation

# Install Maven (optional, for Maven projects)
# macOS: brew install maven
# Ubuntu: sudo apt install maven
# Windows: Download from maven.apache.org

# Install Gradle (optional, for Gradle projects)
# macOS: brew install gradle
# Ubuntu: sudo apt install gradle
# Windows: Download from gradle.org

# Verify installation
java --version
javac --version
mvn --version  # if Maven installed
gradle --version  # if Gradle installed
```

## Environment Setup Guide

### Initial Setup
1. **Clone this Neovim configuration** to `~/.config/nvim/`
2. **Install Packer** (plugin manager):
   ```bash
   git clone --depth 1 https://github.com/wbthomason/packer.nvim \
   ~/.local/share/nvim/site/pack/packer/start/packer.nvim
   ```

### Language-Specific Setup

#### Go Development
```bash
# Install Go toolchain (if not already installed)
# Install via official installer or package manager

# In Neovim:
:PackerSync
:GoInstallBinaries
```

#### Haskell Development
```bash
# Install GHCup and Haskell toolchain
curl --proto '=https' --tlsv1.2 -sSf https://get-ghcup.haskell.org | sh

# Install Haskell tools
ghcup install ghc
ghcup install cabal
ghcup install stack
ghcup install hls
cabal install ormolu
cabal install hindent

# In Neovim:
:TSInstall! haskell
```

#### Node.js/JavaScript/TypeScript Development
```bash
# Install Node.js via nvm (if not already installed)
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash
source ~/.bashrc  # or restart terminal
nvm install --lts
nvm use --lts

# Install global development tools
npm install -g typescript eslint prettier @typescript-eslint/parser @typescript-eslint/eslint-plugin
npm install -g ts-node jest @types/node
npm install -g js-debug-adapter  # For debugging support
npm install -g cspell           # Optional: spell checker

# In Neovim:
:PackerSync
:Mason
# Install: typescript-language-server, eslint-lsp (if not auto-installed)
:TSInstall! javascript typescript tsx
```

#### Python Development
```bash
# Install Python development tools
pip install --upgrade pip
pip install debugpy pytest black ruff pyright
pip install jupytext  # Optional: for Jupyter notebook support

# Framework-specific installations (optional)
pip install django      # For Django development
pip install fastapi uvicorn  # For FastAPI development
pip install flask       # For Flask development

# In Neovim:
:PackerSync
:Mason
# Install: pyright, ruff-lsp (if not auto-installed)
:TSInstall! python
```

#### Java Development
```bash
# Install Java JDK (11 or higher recommended)
# macOS: brew install openjdk@17
# Ubuntu: sudo apt install openjdk-17-jdk
# Windows: Download from Oracle or use OpenJDK

# Set JAVA_HOME environment variable
export JAVA_HOME=/path/to/your/java/installation

# Install build tools (optional but recommended)
# Maven:
# macOS: brew install maven
# Ubuntu: sudo apt install maven

# Gradle:
# macOS: brew install gradle
# Ubuntu: sudo apt install gradle

# In Neovim:
:PackerSync
:Mason
# Install: jdtls (Java LSP server will be auto-configured)
:TSInstall! java
```

### Final Setup Steps
1. **Start Neovim** and run `:PackerSync`
2. **Install LSP servers** via `:Mason`
3. **Install Treesitter parsers** as needed
4. **Restart Neovim** to ensure all configurations load properly

### Troubleshooting

#### Common Issues
- **"module not found" errors**: Run `:PackerSync` and restart Neovim
- **LSP not working**: Check `:Mason` for missing language servers
- **Treesitter parser failures**: Run `:TSUpdate` to refresh parsers
- **Features not working**: Some features only activate after installing their corresponding plugins

#### Error-Free Loading
This configuration uses **safe module loading** with `pcall()` to prevent crashes:
- Missing plugins won't break Neovim startup
- Features gracefully degrade when dependencies aren't available
- Keybindings only register for installed plugins
- You can run `:PackerSync` without errors even before plugins are installed

#### Feature Availability
| Feature | Requires Plugin | Auto-detects |
|---------|----------------|--------------|
| Package.json management | `package-info.nvim` | ✅ |
| Prettier formatting | `prettier.nvim` | ✅ |
| Debug support | `nvim-dap` | ✅ |
| Test runners | `neotest-*` | ✅ |
| Linting/formatting | `null-ls.nvim` | ✅ |

## Notes
- The leader key in this configuration is set to `,`
- Some commands may require specific plugins to be installed
- Visual mode keybindings can be used after selecting text (v)
- Run `:PackerSync` after adding new plugins
- Run `:GoInstallBinaries` to install Go development tools
- Run `:TSInstall! haskell` to ensure Haskell treesitter parser
- Run `:TSInstall! javascript typescript tsx` for Node.js development
- Run `:TSInstall! python` for Python development
- Run `:TSInstall! java` for Java development
