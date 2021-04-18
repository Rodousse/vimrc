# Install



## Neovim >= 0.5  

https://neovim.io/

(Nightly : https://github.com/neovim/neovim/releases/tag/nightly)



## Vim-plug

https://github.com/junegunn/vim-plug

Linux:

```bash
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
```

Windows:

```bash
iwr -useb https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim |`
    ni "$(@($env:XDG_DATA_HOME, $env:LOCALAPPDATA)[$null -eq $env:XDG_DATA_HOME])/nvim-data/site/autoload/plug.vim" -Force
```



## Plugin dependencies

### Clang

Needs clang-format 9.0 and clangd >= 9.0: https://clang.llvm.org/

### cmake

cmake : https://cmake.org/download/

### cmake-language server

cmake-language-server: https://pypi.org/project/cmake-language-server/

```bash
pip install cmake-language-server
```

### Ninja

https://ninja-build.org/

Linux : 

```bash
apt install ninja-build
```

### Treesitter

In nvim : 

```
:TSInstall cpp
```

