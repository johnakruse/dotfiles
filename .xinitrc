xcompmgr -cCf -D5 &

wallpaper=$(ls /home/john/Wallpapers/cycle/ | shuf -n 1)

hsetroot -cover /home/john/Wallpapers/cycle/$wallpaper

xsetroot -cursor_name left_ptr &

synclient VertScrollDelta=-55&

syndaemon -i 0.5 -t -K -R &

xautolock -time 10 -corners 0--- -locker lock &

xrdb -merge /home/john/.Xresources

/usr/bin/ibus-daemon -d --xim

trayer --edge top --align right --SetDockType true --SetPartialStrut true --expand true --width 5 --transparent true --alpha 100 --tint 0x000000 --height 30 &

_curtile=/tmp/.currenttile
[[ -S $_curtile ]] || mkfifo $_curtile

exec xmonad
