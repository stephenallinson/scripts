#!/bin/bash

# Obsidian Directory
SEARCH_DIR="/home/stephen/Documents/JCA Personal/"

search_term=$(rofi -dmenu -i -p "Search Obsidian:")

# If no search term provided, exit the script
if [[ -z $search_term ]]; then
  echo "No search term provided."
  exit 1
fi

search_results=$(rg --smart-case -l "$search_term" "$SEARCH_DIR")

# If no files match the search term, exit the script
if [[ -z $search_results ]]; then
  echo "No matching markdown files found."
  exit 1
fi

# Display the search results in rofi
selected_document=$(echo "$search_results" | rofi -dmenu -i -p "Select Document:")

# Open the document
if [[ -n $selected_document ]]; then
  nvim "$selected_document"
fi
