# Zen-C.vim

This is a syntax highlighting plugin for the [Zen C](https://github.com/z-libs/Zen-C) programming language, supporting [Vim](https://www.vim.org/) and [Neovim](https://neovim.io/).

NOTE: This plugin is a work in progress, and while it is usable, it is still rough around the edges. Please open an issue for any broken syntax highlighting you encounter.

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
