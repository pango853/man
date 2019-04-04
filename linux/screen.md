# Basics

```sh
$ screen -S MyApple
$ screen -ls
$ screen -r MyA
$ screen -d -r MyA
$ screen -rx MyA

# Automatic output logging(screenlog.#) for the windows
$ screen -L -S testscreen
```


# Ctrl + a
- d		detach
- S		horizontal split
  - |		vertical spilt
  - TAB		move
  - Q		unsplit(only 現在の領域を全体表示)
  - X		unsplit(remove 現在の領域削除)
- c		new	window
  - A		name a window
  - Ctrl-a	swap window
    - n			next window
    - p			previous window
    - "/j/k		list and select window
    - w			list windows
  - k		close window
- x		lock screen
- [		copy mode
- ]		paste
- :resize -h +5
- ESC	scroll, hit q/ESC to quit, hit ENTER to select
- s		hardcopy/screenshot

# ~/.screenrc
```sh:.screenrc
# Encoding
defencodig utf-8

# Prefix Key
escape ^Tt

# set scrollback
defscrollback 3000

# Delete sartt up screen
startup_message off

# Enable Auto detach
autodetach on

# logging
log on
deflog on
logfile "$HOME/screen/log/%Y%m%d-%n.log"

# Show date and screen list
hardstatus alwayslastline "%{= rw} %H %{= wk}%-Lw%{= bw}%n%f* %t%{= wk}%+Lw %{= wk}%=%{= gk} %y/%m/%d %c "
```

# Tutorial
Ctrl-a S
Ctrl-a |
Ctrl-a Q
Ctrl-a TAB
Ctrl-a c
Ctrl-a SPACE
Ctrl-a BKSPACE
Ctrl-a 2
Ctrl-a "
Ctrl-a a	or Ctrl-t t

