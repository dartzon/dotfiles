#!/bin/bash

I3_XRESOURCES=~/.dotfiles/display/i3/i3-xresources
COUNT_MONITORS=$(xrandr | grep -w connected | wc -l)
case ${COUNT_MONITORS} in

    1)
        PRIMARY_MON=$(xrandr --query | awk '/connected/ && /primary/' | cut -d" " -f1)
        echo "i3wm*primary_monitor: ${PRIMARY_MON}" > ${I3_XRESOURCES}
        ;;

    2)
        PRIMARY_MON=$(xrandr --query | awk '/connected/ && /primary/' | cut -d" " -f1)
        SECONDARY_MON=$(xrandr --query | grep -w "connected" | grep -v -e "primary" -e "left (" | cut -d" " -f1)
        echo "i3wm*primary_monitor: ${PRIMARY_MON}" > ${I3_XRESOURCES}
        echo "i3wm*secondary_monitor: ${SECONDARY_MON}" >> ${I3_XRESOURCES}
        ;;

    3)
        PRIMARY_MON=$(xrandr --query | awk '/connected/ && /primary/' | cut -d" " -f1)
        SECONDARY_MON=$(xrandr --query | grep -w "connected" | grep -v -e "primary" -e "left (" | cut -d" " -f1)
        VERTICAL_MON=$(xrandr --query | awk '/connected/ && /left \(/' | cut -d" " -f1)
        echo "i3wm*primary_monitor: ${PRIMARY_MON}" > ${I3_XRESOURCES}
        echo "i3wm*secondary_monitor: ${SECONDARY_MON}" >> ${I3_XRESOURCES}
        echo "i3wm*vertical_monitor: ${VERTICAL_MON}" >> ${I3_XRESOURCES}
        ;;
esac

/usr/bin/xrdb -load -I/home/dartzon/.dotfiles/display/i3/ /home/dartzon/.Xresources
