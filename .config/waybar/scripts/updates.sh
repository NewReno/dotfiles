#!/bin/bash
count=$(checkupdates 2>/dev/null | wc -l)
if [ "$count" -gt 0 ]; then
    echo "{\"text\": \"󰏖 $count\", \"class\": \"has-updates\", \"tooltip\": \"$count updates available\"}"
else
    echo '{"text": "", "class": "updated", "tooltip": "System up to date"}'
fi
