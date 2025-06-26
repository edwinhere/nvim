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

## Notes
- The leader key in this configuration is set to `,`
- Some commands may require specific plugins to be installed
- Visual mode keybindings can be used after selecting text (v)
