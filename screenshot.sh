#!/bin/bash
#  ____                               _           _
# / ___|  ___ _ __ ___  ___ _ __  ___| |__   ___ | |_
# \___ \ / __| '__/ _ \/ _ \ '_ \/ __| '_ \ / _ \| __|
#  ___) | (__| | |  __/  __/ | | \__ \ | | | (_) | |_
# |____/ \___|_|  \___|\___|_| |_|___/_| |_|\___/ \__|
#
#
# by Stephan Raabe (2023)
# -----------------------------------------------------

DIR="$HOME/Pictures/screenshots/"
NAME="screenshot_$(date +%d%m%Y_%H%M%S).png"

option2="SAVE - Selected area"
option3="SAVE - Fullscreen (3s)"
option4="COPY - Selected area"
option5="COPY - Fullscreen (3s)"

options="$option2\n$option3\n$option4\n$option5"

choice=$(echo -e "$options" | rofi -dmenu -replace -i -no-show-icons -l 4 -width 30 -p "Take Screenshot")

case $choice in
$option2)
	grimshot --notify save area $DIR$NAME
	;;
$option3)
	sleep 3
	grimshot --notify save screen $DIR$NAME
	;;
$option4)
	grimshot --notify copy area 
	;;
$option5)
	sleep 3
	grimshot --notify copy screen 
	;;
esac
