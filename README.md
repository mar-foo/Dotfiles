# dotfiles
This repository holds my personal configuration for a few programs that
I use, and a few scripts that I wrote to automate some simple tasks.

## Screenshot
![Screenshot](./scrot.png)

## Setup:
- OS: [Void Linux](https://voidlinux.org)
- WM: [dwm](https://dwm.suckless.org)
- Terminal: [st](https://st.suckless.org)
- Menu/Application launcher: [dmenu](https://tools.suckless.org/dmenu)
- Editor: [Emacs](https://gnu.org/software/emacs/) ([vis](https://github.com/martanne/vis) / [kakoune](https://github.com/mawww/kakoune))
- Browser: [surf](https://surf.suckless.org)
- Font: IBM Plex Mono Italic

## Suckless builds
I applied a few patches to my builds of st and dwm, and modified some
of the code myself. I have no notes on which patches I applied when,
look through the commit log if you want to know.

## Runit services
I currently manage all of my user level services using
[runsv](http://smarden.org/runit). Scripts are under
[service](./service) directory, all ``sv`` commands can be instructed
to search user scripts using ``usv`` (see [mkshrc](./.mkshrc)).
