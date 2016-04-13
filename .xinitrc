xrandr --output eDP-1 --mode 1366x768
xrandr --output VGA-1 --right-of eDP-1 --mode 1440x900 & 

sleep 1

xcompmgr -cf -D5 &

hsetroot -fill /home/john/wallpapers/wallpaper2.jpg &

xsetroot -cursor_name left_ptr &

xautolock -time 10 -locker slock &

xrdb -merge /home/john/.Xresources

/usr/bin/ibus-daemon -d &

trayer --edge top --align right --SetDockType true --SetPartialStrut true --expand true --width 5 --transparent true --alpha 100 --tint 0x000000 --height 18 &

exec xmonad

