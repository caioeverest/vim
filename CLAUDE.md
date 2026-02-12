# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

**everest.nvim** — Personal Neovim configuration based on kickstart.nvim. All configuration is in Lua, managed by the lazy.nvim plugin manager. Targets macOS and WSL environments.

## Key Commands

```bash
# Sync all plugins (headless, useful after config changes)
nvim --headless "+Lazy! sync" +qa

# Auto-sync script (stages all changes, generates commit message via OpenAI, pushes)
./sync.sh

# Update plugins from within Neovim
:Lazy update
```

## Architecture

### Entry Point & Loading Order

`init.lua` is the entry point. It:
1. Sets leader key to `,` (comma) and configures clipboard (with WSL detection)
2. Bootstraps lazy.nvim package manager
3. Loads inline plugins (fugitive, rhubarb, sleuth, which-key, catppuccin, indent-blankline, Comment, telescope)
4. Auto-imports all files from `lua/plugins/` via `{ import = 'plugins' }`
5. Configures Telescope defaults and loads fzf extension
6. Requires `config.options` then `config.keymaps`

### Directory Layout

- `init.lua` — Entry point, lazy.nvim bootstrap, inline plugin specs, Telescope config
- `lua/config/options.lua` — Vim options (search, line numbers, clipboard, undo, etc.)
- `lua/config/keymaps.lua` — Core keymaps (Telescope pickers, diagnostics, tabs, base64 encode/decode)
- `lua/plugins/*.lua` — Each file returns a lazy.nvim plugin spec (auto-imported)

### Plugin Conventions

Each file in `lua/plugins/` returns a single lazy.nvim plugin spec table. To add a new plugin, create a new `.lua` file in that directory — lazy.nvim will auto-discover it.

### LSP & Tooling Setup

LSP is configured in `lua/plugins/lsp.lua` using mason + mason-lspconfig + mason-tool-installer. Currently configured servers:
- `gopls` (Go)
- `lua_ls` (Lua, with callSnippet completion)

Mason auto-installs: `stylua`, `goimports`

### Autoformatting (conform.nvim)

Format-on-save is enabled by default (500ms timeout). Formatter chain:
- **Lua**: `stylua`
- **Go**: `golines` (max 130 chars) → `goimports` (local imports: `github.com/NSXBet`) → `gofumpt`
- **Proto**: `buf`
- **YAML**: `yamlfmt`
- C/C++ format-on-save is explicitly disabled (LSP fallback skipped)

### Completion

Uses `blink.cmp` with `LuaSnip` snippets engine. Sources: LSP, path, buffer, snippets, lazydev. Keymap preset is `default` (`<c-y>` to accept).

### Debugging (DAP)

Configured for Go (delve) and JavaScript (via dap-vscode-js). Keymaps: `F5` continue, `F1` step into, `F2` step over, `F3` step out, `<leader>b` toggle breakpoint, `F7` toggle DAP UI.

### ToggleTerm Terminals

- `<leader>g` — lazygit (float)
- `<leader>d` — ctop (float, container monitoring)
- `<leader>c` — Claude Code (vertical split, 40% width)
- `<C-]>` — Session-scoped horizontal terminal
- Terminal mode: `<esc>` or `jk` exits to normal mode, `<C-h/j/k/l>` for window navigation

### Notable Keymaps

Leader is `,`. Key bindings to be aware of:
- `<C-p>` / `<leader>sf` — Find files (Telescope)
- `<leader>sg` — Live grep
- `<leader><space>` — Switch buffer
- `<C-\>` — Toggle NeoTree file explorer (right side)
- `LG` — NeoTree git status (float)
- `<Tab>` / `<S-Tab>` — Next/previous tab
- `nt` — New tab
- `<leader>f` — Format buffer
- `<leader>th` — Toggle inlay hints
- LSP: `grd` definition, `grr` references, `gri` implementation, `grn` rename, `gra` code action

## Important Notes

- Colorscheme is **catppuccin-mocha**
- Bufferline is configured in `tabs` mode (shows tabpages, not buffers)
- Gitsigns enables current-line blame by default on attach
- The `sync.sh` script uses env vars: `PERSONAL_GIT_EMAIL`, `PERSONAL_GIT_SSH_KEY`, `OPENAI_API_KEY`
- WSL clipboard integration uses custom `nvim_copy`/`nvim_paste` scripts in `scripts/`
- Line 19 in `init.lua` has mise shims PATH prepend commented out
