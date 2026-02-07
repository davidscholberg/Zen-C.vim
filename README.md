# Zen-C.vim

This is a syntax highlighting plugin for the [Zen C](https://github.com/z-libs/Zen-C) programming language, supporting [Vim](https://www.vim.org/) and [Neovim](https://neovim.io/).

NOTE: This plugin should work fine for most Zen C code that you'll write/encounter, but there may still be unhandled edge cases. Please open an issue for any broken syntax highlighting you encounter.

### Installation

#### Plugin Manager Install

If you use a plugin manager, please consult your plugin manager's docs for installation instructions. Generally you shouldn't need to specify anything beyond the plugin source (e.g. `davidscholberg/Zen-C.vim`).

For users of [lazy.nvim](https://github.com/folke/lazy.nvim), note that this plugin already does its own lazy loading (it will only be loaded when you open a `.zc` file). As such, you don't need to set any additional lazy loading options for this plugin.

#### Manual Install

Vim:

```bash
# Replace "manual" with whatever namespace you prefer:
git clone https://github.com/davidscholberg/Zen-C.vim.git ~/.vim/pack/manual/start/Zen-C.vim
```

Neovim:

```bash
# Replace "manual" with whatever namespace you prefer:
git clone https://github.com/davidscholberg/Zen-C.vim.git ~/.local/share/nvim/site/pack/manual/start/Zen-C.vim
```

### Configuration

In addition to syntax highlighting, this plugin sets a few convenience options related to comment editing/formatting. To ensure these options are loaded, make sure the following options are set in your config (some or all of these may be enabled by default, but it won't hurt to explicitly enable them regardless).

Vim:

```vim
filetype indent plugin on
packadd comment
```

Neovim:

```lua
vim.cmd("filetype indent plugin on")
```
