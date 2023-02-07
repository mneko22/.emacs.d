# .emacs.d

## Reqired
1. emacs v27=<
2. [gopls](https://github.com/golang/tools/tree/master/gopls)
3. [bash-language-server](https://github.com/mads-hartmann/bash-language-server)

## Installation

``` shell
git clone https://github.com/mneko22/.emacs.d.git
cd .emacs.d
git submodule update
emacs --batch -f batch-byte-compile init.el
```
