#!/bin/bash

selected=$(rofi -dmenu -l 0 -p "Add Task >")
if [ ! "$selected" ]; then
    echo "No Task Created"
    exit
fi
vja add "$selected"
notify-send "Vikunja Task Added" "$selected"
