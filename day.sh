#!/bin/bash

today=$(date +"%Y-%m-%d")
tomorrow=$(date -d "tomorrow" '+%Y-%m-%d')
yesterday=$(date -d "yesterday" '+%Y-%m-%d')
folder="/home/stephen/Documents/JCA Personal/Daily/"
year=$(date +"%Y")
month="$(date +"%m")-$(date +"%B")"
file="$folder/$year/$month/$(date +"%Y-%m-%d").md"

cd "$folder" || exit

new_note() {
	touch "$file"

	# Format the file with the daily template
	cat <<EOF >"$file"
---
title: $(date +"%Y-%m-%d")
type: daily-note
tags: daily-note
---
# $today

[[$yesterday]] - [[$tomorrow]]

## Habits

- [ ] Mindfulness
- [ ] Exercise
- [ ] Daily Review

## Notes

EOF

}
# If this is the first note of the year, create the year folder
if [ ! -d "$folder/$year" ]; then
    mkdir -p "$folder/$year"
fi
# If the folder does not exist, create it.
if [ ! -d "$folder/$year/$month" ]; then
    mkdir -p "$folder/$year/$month"
fi
# If the daily note does not exist, create a new one.
# this uses the test command with the -f flag.
if [ ! -f "$file" ]; then
	echo "File does not exist, creating new daily note."
	new_note
fi

# Open the daily note at the bottom of the file in insert mode and run NoNeckPain to make it center
nvim '+ normal Gzzo' "$file" -c :NoNeckPain
