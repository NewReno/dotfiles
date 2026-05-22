#!/bin/bash
set -e

reload_waybar() {
  pkill -SIGUSR2 waybar 2>/dev/null || true
}

reload_swaync() {
  swaync-client -R 2>/dev/null || true
}

reload_hyprland() {
  hyprctl reload 2>/dev/null || true
}

reload_alacritty() {
  for socket in /tmp/alacritty-*; do
    [ -S "$socket" ] && alacritty msg -s "$socket" config reload 2>/dev/null || true
  done
}

reload_btop() {
  pkill -SIGUSR2 btop 2>/dev/null || true
}

echo "[wallust] Reloading apps..."

reload_waybar &
reload_swaync &
reload_hyprland &
reload_alacritty &
reload_btop &

wait
echo "[wallust] Done."
