# Stephen's Dotfiles

A collections of dotfiles, mostly for my own use.

## What's Here?

Configuration files for:

- Bash
- Vim and Neovim
- Tmux
- Git
- Mercurial

...and one or two other things.

## Configuration

### Vim and Neovim

Vim and Neovim share the Vimscript settings in `vimrc` and the plugins in
`vim/`. Neovim's entry point is `config/nvim/init.vim`, which adds `~/.vim`
to its runtime path and sources `~/.vimrc`. Vim-specific terminal overrides
are skipped in Neovim.

### Bash

- `.bash/internals`

  This lets you store internal configuration, be that corporate proxy
  configuration or something else entirely
