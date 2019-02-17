# Basics

```sh
$ screen -S MyApple
$ screen -ls
$ screen -r MyA
$ screen -d -r MyA
$ screen -rx MyA
```

# Ctrl + a
- d detach
- s/l	horizontal split
- l	vertical spilt
- TAB	move
- c	new	window
- x	remove	window
- C-a	swap window
- n	next window
- p	previous window
- "jk	list and select window
- A	name a window
- k	close window
- [	copy
- ]	paste


# ~/.screenrc
```
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
