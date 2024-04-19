#!/bin/bash
#                _ _
# __      ____ _| | |_ __   __ _ _ __   ___ _ __
# \ \ /\ / / _` | | | '_ \ / _` | '_ \ / _ \ '__|
#  \ V  V / (_| | | | |_) | (_| | |_) |  __/ |
#   \_/\_/ \__,_|_|_| .__/ \__,_| .__/ \___|_|
#                   |_|         |_|
#
# by Stephan Raabe (2023)
# -----------------------------------------------------

if [ -z "$1" ]; then
	echo "Usage: $0 [init|select|random]"
	exit 1
fi
case $1 in

# Load wallpaper from .cache of last session
"init")
	if [ -f ~/.cache/current_wallpaper.jpg ]; then
		wal -q -i ~/.cache/current_wallpaper.jpg
	else
		wal -q -i ~/wallpaper/
	fi
	;;

# Select wallpaper with rofi
"select")
	selected=$(ls -1 ~/wallpaper | grep "jpg" | rofi -dmenu -replace)
	if [ ! "$selected" ]; then
		echo "No wallpaper selected"
		exit
	fi
	wal -q -i ~/wallpaper/$selected
	;;

# Randomly select wallpaper
"random")
	wal -q -i ~/wallpaper/
	;;

esac

# -----------------------------------------------------
# Load current pywal color scheme
# -----------------------------------------------------
source "$HOME/.cache/wal/colors.sh"
echo "Wallpaper: $wallpaper"

# -----------------------------------------------------
# Copy selected wallpaper into .cache folder
# -----------------------------------------------------
cp $wallpaper ~/.cache/current_wallpaper.jpg

# -----------------------------------------------------
# get wallpaper iamge name
# -----------------------------------------------------
newwall=$(echo $wallpaper | sed "s|$HOME/wallpaper/||g")

# -----------------------------------------------------
# Set the new wallpaper
# -----------------------------------------------------
swww kill
swww init

transition_type="wipe"
# transition_type="outer"
# transition_type="random"

swww img $wallpaper \
	--transition-bezier .43,1.19,1,.4 \
	--transition-fps=60 \
	--transition-type=$transition_type \
	--transition-duration=0.7

# qtile cmd-obj -o cmd -f reload_config

# -----------------------------------------------------
# Send notification
# -----------------------------------------------------
notify-send "Colors and Wallpaper updated" "with image $newwall"

echo "DONE!"
exit
