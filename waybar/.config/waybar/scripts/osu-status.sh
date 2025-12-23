#!/bin/bash

WINDOW=$(hyprctl activewindow -j)

CLASS=$(echo "$WINDOW" | jq -r '.class')
TITLE=$(echo "$WINDOW" | jq -r '.title')

if [[ "$CLASS" =~ "osu" ]]; then
    CLEAN_TITLE=$(echo "$TITLE" | sed 's/ - osu!$//;s/^osu! - //')
    if [ "$CLEAN_TITLE" = "osu!" ]; then
        echo " Selecting Beatmaps..."
    else
        echo " $CLEAN_TITLE"
    fi  
else
    echo ""
fi
