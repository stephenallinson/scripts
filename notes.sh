#!/bin/bash

# Directory to search in. Customize this directory
SEARCH_DIR="/home/stephen/Documents/JCA Personal/"

# Find markdown files and store the list
documents=$(find "$SEARCH_DIR" -type f -name '*.md' -printf '%f\n')

# If no documents found, exit the script
if [[ -z $documents ]]; then
  echo "No markdown files found in $SEARCH_DIR"
  exit 1
fi

# Use rofi to select a file from the list
selected_document=$(echo "$documents" | rofi -dmenu -i -p "📖 Open:")

# If a document was selected, open it
if [[ -n $selected_document ]]; then
  # Find the full path of the selected document
  selected_path=$(find "$SEARCH_DIR" -type f -name "$selected_document")
  # Open the selected file with nvim
  alacritty -e nvim "$selected_path"
fi
