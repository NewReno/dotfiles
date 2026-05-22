#!/bin/bash
state=$(swaync-client -D)
if [ "$state" = "true" ]; then
    echo '{"text": "󰂛", "class": "active", "tooltip": "Notifications: DnD ON"}'
else
    echo '{"text": "󰂚", "class": "", "tooltip": "Notifications: ON"}'
fi
