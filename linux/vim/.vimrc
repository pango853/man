syntax on

set number
set nowrap
set mouse-=a
set noexpandtab
set tabstop=4
set autoindent
set smartindent

set ai
set pastetoggle=<F2>

set backup

if has("win32")
	" Windows
	set backupdir=%HOMEPATH%\_vim\bak
	set directory=.,%HOMEPATH%\_vim\tmp
else
  if has("unix")
    let s:uname = system("uname")
    if s:uname == "Darwin\n"
      " Mac
    else
		set backupdir=~/.vim/bak
		set directory=~/.vim/tmp
    endif
  endif
endif

if has("autocmd")
	filetype plugin indent on
endif

