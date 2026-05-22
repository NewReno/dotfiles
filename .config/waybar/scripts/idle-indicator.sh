#!/bin/bash
if pgrep -x hypridle > /dev/null; then
    echo '{"text": "󰍛", "class": "active", "tooltip": "Hypridle: ON"}'
else
    echo '{"text": "󰾫", "class": "", "tooltip": "Hypridle: OFF"}'
fi
