xcompmgr -cCf -D5 &

sleep 1

hsetroot -cover /home/john/Wallpapers/cycle/$wallpaper

xsetroot -cursor_name left_ptr &

xautolock -time 10 -locker slock &

xrdb -merge /home/john/.Xresources

/usr/bin/ibus-daemon -d --xim

trayer --edge top --align right --SetDockType true --SetPartialStrut true --expand true --width 5 --transparent true --alpha 100 --tint 0x000000 --height 30 &

_curtile=/tmp/.currenttile
[[ -S $_curtile ]] || mkfifo $_curtile

exec xmonad
