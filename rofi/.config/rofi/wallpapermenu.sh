#!/bin/bash

# 1. Variables
WALL_DIR="$HOME/.config/rofi/wallpapers/"
TRANSITION_TYPE="grow" # Options: grow, outer, random, wave
TRANSITION_DURATION="2"

# 2. Rofi Logic
if [ -z "$@" ]; then
    # 1. Find files (print with null separators to handle spaces safely)
    find "$WALL_DIR" -type f \( -iname "*.jpg" -o -iname "*.png" -o -iname "*.webp" \) -print0 | \
    sort -z | \
    while IFS= read -r -d '' file; do
        # 2. Get just the filename
        filename=$(basename "$file")
        
        # 3. Echo using -en to interpret the magic codes (\0 and \x1f)
        echo -en "${filename}\0icon\x1f${file}\n"
    done
else
    # 3. Apply Selection
    SELECTED_FILE="$WALL_DIR/$1"
    
    # A. Set Wallpaper
    swww img "$SELECTED_FILE" \
        --transition-type $TRANSITION_TYPE \
        --transition-duration $TRANSITION_DURATION \
        --transition-fps 60
    
    # B. Generate Colors (Matugen)
    # This will overwrite ~/.config/rofi/colors.rasi based on our config.toml
    # matugen image "$SELECTED_FILE"
    
    # C. Optional: Reload Waybar or other apps to pick up colors instantly
    pkill -SIGUSR2 waybar &
    
    # Send a notification
    notify-send "Theme Changed" "Wallpaper: $1"
fi