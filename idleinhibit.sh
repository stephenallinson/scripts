#!/bin/bash

# Qtile swayidle toggle
function toggle {
if pgrep "swayidle" > /dev/null
then
	pkill swayidle
	notify-send "  Swayidle Inactive"
else
    swayidle -w timeout 300 'swaylock -f -c 000000' timeout 600 'swaymsg "output * dpms off"' resume 'swaymsg "output * dpms on"' before-sleep 'swaylock -f -c 000000' &
	notify-send "  Swayidle Active"
fi
}

# If called with "toggle", kill or enable swayidle
# If no arguments, return the status of swayidle with icon
case $1 in
	toggle)
		toggle
		;;
	*)
		if pgrep "swayidle" > /dev/null
		then
			icon="󰍁"
		else
			icon="󱙲"
		fi
		printf "%s" "$icon "
		;;
esac
