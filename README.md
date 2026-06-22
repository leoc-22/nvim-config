# My Neovim Config

## Install

### Dependencies

- Neovim 0.12 or newer
- `tree-sitter-cli` for `nvim-treesitter` parser installs and updates

On macOS:

```bash
brew install neovim tree-sitter-cli
```

Neovim's configurations are located under the following paths

| OS | PATH |
| :- | :--- |
| Linux, MacOS | `$XDG_CONFIG_HOME/nvim`, `~/.config/nvim` |

Run

```bash
git clone git@github.com:leoc-22/nvim-config.git "${XDG_CONFIG_HOME:-$HOME/.config}"/nvim
```
