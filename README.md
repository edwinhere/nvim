# Neovim Configuration Keybindings

This document outlines all keybindings and their functionalities in this Neovim configuration.

## LSP (Language Server Protocol)

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
| `<leader>f`  | Normal | Format file              |
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
| `<leader>f`  | Normal | Live grep               |
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
| `<leader>gd` | Normal | Debug continue     |
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

## Notes
- The leader key in this configuration is set to `,`
- Some commands may require specific plugins to be installed
- Visual mode keybindings can be used after selecting text (v)
- Run `:PackerSync` after adding new plugins
- Run `:GoInstallBinaries` to install Go development tools
- Run `:TSInstall! haskell` to ensure Haskell treesitter parser
