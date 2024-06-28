#!/bin/bash
#   ____ _                              _____ _
#  / ___| |__   __ _ _ __   __ _  ___  |_   _| |__   ___ _ __ ___   ___
# | |   | '_ \ / _` | '_ \ / _` |/ _ \   | | | '_ \ / _ \ '_ ` _ \ / _ \
# | |___| | | | (_| | | | | (_| |  __/   | | | | | |  __/ | | | | |  __/
#  \____|_| |_|\__,_|_| |_|\__, |\___|   |_| |_| |_|\___|_| |_| |_|\___|
#                          |___/
#
# by Stephan Raabe (2023)
# -----------------------------------------------------

# -----------------------------------------------------
# Update Wallpaper with pywal
# -----------------------------------------------------
wal -s -q -i ~/wallpaper/

# -----------------------------------------------------
# Wait for 1 sec
# -----------------------------------------------------
sleep 1

# -----------------------------------------------------
# Get new theme
# -----------------------------------------------------
source "$HOME/.cache/wal/colors.sh"
newwall=$(echo $wallpaper | sed "s|$HOME/wallpaper/||g")
cp $wallpaper ~/.cache/current_wallpaper.jpg
sleep 1
swww img $wallpaper \
	--transition-bezier .43,1.19,1,.4 \
	--transition-fps=60 \
	--transition-type="wipe" \
	--transition-duration=1.5
# -----------------------------------------------------
# Reload qtile to color bar
# -----------------------------------------------------
qtile cmd-obj -o cmd -f reload_config

# -----------------------------------------------------
# Send notification
# -----------------------------------------------------
notify-send --expire-time=2000 "Colors and Wallpaper updated" "with image $newwall"

echo "Done."
