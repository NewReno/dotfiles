#!/bin/bash
DEV="/dev/input/by-id/usb-_Akko_2.4G_Wireless_Keyboard-if01-event-mouse"
[ ! -e "$DEV" ] && exit 1

stdbuf -oL sudo evtest "$DEV" 2>/dev/null | stdbuf -oL grep --line-buffered "REL_WHEEL" | while read -r line; do
    if echo "$line" | grep -q "value 1"; then
        wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+
    elif echo "$line" | grep -q "value -1"; then
        wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%-
    fi
done
