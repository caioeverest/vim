# everest.nvim

This is my personal Neovim configuration. If you're interested, feel free to try it out. I strongly recommend checking out the [nvim-lua/kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim) project, which has greatly influenced this configuration.

### Installation

**Requirements**:
* Review the READMEs of the plugins if you encounter any errors. Specifically:
  * [ripgrep](https://github.com/BurntSushi/ripgrep#installation) is required for several [telescope](https://github.com/nvim-telescope/telescope.nvim#suggested-dependencies) pickers.
* For Windows-specific issues with `telescope-fzf-native`, see [Windows Installation](#Windows-Installation).

Neovim configurations are located in the following paths based on your OS:

| OS | PATH |
| :- | :--- |
| Linux | `$XDG_CONFIG_HOME/nvim` or `~/.config/nvim` |
| MacOS | `$XDG_CONFIG_HOME/nvim` or `~/.config/nvim` |
| Windows | `%userprofile%\AppData\Local\nvim\` |

To clone everest.nvim:

```sh
# on Linux and Mac
git clone https://github.com/caioeverest/vim.git "${XDG_CONFIG_HOME:-$HOME/.config}"/nvim

# on Windows
git clone https://github.com/caioeverest/vim.git %userprofile%\AppData\Local\nvim\
```

### Post Installation

Run the following command and then **you are ready to go**!

```sh
nvim --headless "+Lazy! sync" +qa
```

### Special Thanks

This configuration is heavily inspired by [nvim-lua/kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim). While I've made significant modifications, I'd like to acknowledge the foundational work provided by the kickstart project. Instead of forking, I've extracted the essentials and built upon them to suit my needs.

### Windows Installation

Installation may require installing build tools, and updating the run command for `telescope-fzf-native`

See `telescope-fzf-native` documentation for [more details](https://github.com/nvim-telescope/telescope-fzf-native.nvim#installation)

This requires:

- Install CMake, and the Microsoft C++ Build Tools on Windows

```lua
{'nvim-telescope/telescope-fzf-native.nvim', build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' }
```

