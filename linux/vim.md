
# NeoVim

REF: https://github.com/neovim/neovim/releases

vimrcのシンボリックリンクとして作成するとVimと共有できます。

> mklink %USERPROFILE%\AppData\Local\nvim\init.vim %HOMEPATH%\.vimrc
> mklink %USERPROFILE%\AppData\Local\nvim\ginit.vim %HOMEPATH%\.gvimrc

g:python3_host_progを指定する
```init.vim
	let g:python3_host_prog = 'python'
```

PythonのNeoVimクライアントをインストールする
> pip uninstall neovim
> pip install pynvim
 
Fix buffer problem on v0.3.1(nvim-qt -- -- foo.txt)

```ginit.vim
if has('nvim') && @% == ""
  bd
endif
```

```init.vim
if has('win32') && has('nvim')
  set termguicolors
  colorscheme koehler
endif
```

TODO: deoplete, https://github.com/onivim/oni, https://github.com/neovim/neovim/wiki/Related-projects

## Usages
> nvim-qt  --qwindowgeometry 1280x720

TODO: https://github.com/pepo-le/win-ime-con.nvim


# MISC

## show the current buffer's encoding
> :help fileencoding
> :set fileencoding
> :set encoding

> :write ++enc=utf-8 test.txt


> vim --cmd "set encoding=utf-8" file.txt

