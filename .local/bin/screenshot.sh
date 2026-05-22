#!/bin/bash
mkdir -p ~/Pictures/Screenshots
grim -g "$(slurp)" ~/Pictures/Screenshots/screenshot-$(date +%Y%m%d-%H%M%S).png
