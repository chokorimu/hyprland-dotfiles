#!/bin/bash

# 1. Defined Options
lock="Lock"
logout="Logout"
suspend="Suspend"
reboot="Reboot"
shutdown="Shutdown"

# 2. Check if a button was clicked
# "$@" is what Rofi passes back to us when we select an item
if [ -z "$@" ]; then
    # If nothing is selected, SHOW the menu
    echo "$lock"
    echo "$logout"
    echo "$suspend"
    echo "$reboot"
    echo "$shutdown"
else
    # If something was selected, DO the action
    # We use ( ... ) & to run the command in the background
    # We redirect output to /dev/null so Rofi doesn't think we are printing more menu items
    case "$1" in
        "$lock") 
            (sleep 0.5; hyprlock) >/dev/null 2>&1 & 
            ;;
        "$logout") 
            (sleep 0.5; hyprctl dispatch exit) >/dev/null 2>&1 & 
            ;;
        "$suspend") 
            (sleep 0.5; systemctl suspend) >/dev/null 2>&1 & 
            ;;
        "$reboot") 
            (sleep 0.5; systemctl reboot) >/dev/null 2>&1 & 
            ;;
        "$shutdown") 
            (sleep 0.5; systemctl poweroff) >/dev/null 2>&1 & 
            ;;
    esac
    # Explicitly tell the script to finish successfully
    exit 0
fi