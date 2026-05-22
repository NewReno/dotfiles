#!/bin/bash

CTP="$HOME/.config/catppuccin"
WALLUST_DIR="$HOME/.config/wallust/generated"
FLAVOR_FILE="$CTP/flavor.txt"
WALLPAPER_DIR="$HOME/Pictures/wallpapers"

ln_sf() { ln -sf "$1" "$2"; }

reload_apps() {
  pkill -SIGUSR2 waybar 2>/dev/null || true
  swaync-client -R 2>/dev/null || true
  hyprctl reload 2>/dev/null || true
  pkill -SIGUSR2 btop 2>/dev/null || true
}

apply_static() {
  local index="$1"
  case "$index" in
    0) flavor="latte" ;;
    1) flavor="frappe" ;;
    2) flavor="macchiato" ;;
    3) flavor="mocha" ;;
    *) return 1 ;;
  esac

  echo "$flavor" > "$FLAVOR_FILE"

  ln_sf "$CTP/catppuccin-$flavor.css" "$CTP/current.css"
  ln_sf "$CTP/hyprland/catppuccin-$flavor.conf" "$HOME/.config/hypr/colors.conf"
  ln_sf "$CTP/alacritty/catppuccin-$flavor.toml" "$HOME/.config/alacritty/themes/current.toml"
  ln_sf "$CTP/rofi/catppuccin-$flavor.rasi" "$HOME/.config/rofi/colors.rasi"
  ln_sf "$CTP/swaync/catppuccin-$flavor.css" "$HOME/.config/swaync/colors.css"
  ln_sf "$CTP/btop/catppuccin-$flavor.theme" "$HOME/.config/btop/themes/current.theme"

  reload_apps

  local wallpaper="$CTP/wallpapers/catppuccin-$flavor.jpg"
  if [ -f "$wallpaper" ]; then
    swww img "$wallpaper" --transition-type outer --transition-pos top-right --transition-fps 60 2>/dev/null || true
  fi

  notify-send -t 2000 "Catppuccin" "Switched to $flavor" 2>/dev/null || true
  echo "$flavor"
}

apply_wallust() {
  local wallpaper="$1"

  echo "wallust" > "$FLAVOR_FILE"

  if [ -n "$wallpaper" ] && [ -f "$wallpaper" ]; then
    wallust run -s "$wallpaper"
  else
    swww img --transition-type fade --transition-fps 60 2>/dev/null || true
    sleep 1
    wallpaper=$(awk -F'=' '/^Lockscreen path/ {sub(/\[.*\]/, ""); print $2}' "$HOME/.cache/swww/.cache" 2>/dev/null | head -1 | tr -d ' ')
    if [ -n "$wallpaper" ] && [ -f "$wallpaper" ]; then
      wallust run -s "$wallpaper"
    else
      notify-send -t 2000 "Wallust" "No wallpaper found" 2>/dev/null || true
      return 1
    fi
  fi

  ln_sf "$WALLUST_DIR/colors-hyprland.conf" "$HOME/.config/hypr/colors.conf"
  ln_sf "$WALLUST_DIR/colors-waybar.css" "$CTP/current.css"
  ln_sf "$WALLUST_DIR/colors-rofi.rasi" "$HOME/.config/rofi/colors.rasi"
  ln_sf "$WALLUST_DIR/colors-swaync.css" "$HOME/.config/swaync/colors.css"
  ln_sf "$WALLUST_DIR/colors-btop.theme" "$HOME/.config/btop/themes/current.theme"

  reload_apps

  notify-send -t 2000 "Wallust" "Dynamic theme applied" 2>/dev/null || true
  echo "wallust"
}

select_wallpaper() {
  [ ! -d "$WALLPAPER_DIR" ] && mkdir -p "$WALLPAPER_DIR"

  local choice
  choice=$(find "$WALLPAPER_DIR" -type f \( -iname "*.jpg" -o -iname "*.png" -o -iname "*.jpeg" -o -iname "*.webp" \) -printf "%f\n" | sort | walker -d -N -p "Select wallpaper" 2>/dev/null)

  [ -z "$choice" ] && return 1

  local wallpaper="$WALLPAPER_DIR/$choice"
  swww img "$wallpaper" --transition-type outer --transition-pos top-right --transition-fps 60 2>/dev/null || true
  sleep 0.5
  apply_wallust "$wallpaper"
}

show_static_menu() {
  echo -e "🌅 Latte\n🌆 Frappé\n🌃 Macchiato\n🌌 Mocha" | walker -d -i -N -p "Select Catppuccin flavor" 2>/dev/null
}

main() {
  local index

  if [ "$1" = "wallust" ]; then
    apply_wallust ""
  elif [ "$1" = "wallpaper" ]; then
    select_wallpaper
  elif [ -n "$1" ]; then
    case "$(echo "$1" | tr '[:upper:]' '[:lower:]')" in
      latte)     index=0 ;;
      frappe)    index=1 ;;
      macchiato) index=2 ;;
      mocha)     index=3 ;;
      *)         echo "Unknown: $1"; exit 1 ;;
    esac
    apply_static "$index"
  else
    local choice
    choice=$(echo -e "🎨 Catppuccin Flavors\n🖼️ Wallpapers + Wallust" | walker -d -i -N -p "Theme mode" 2>/dev/null)

    case "$choice" in
      0)
        index=$(show_static_menu)
        [ -z "$index" ] && exit 0
        apply_static "$index"
        ;;
      1)
        select_wallpaper
        ;;
      *)
        index=$(show_static_menu)
        [ -z "$index" ] && exit 0
        apply_static "$index"
        ;;
    esac
  fi
}

[ ! -f "$FLAVOR_FILE" ] || [ ! -s "$FLAVOR_FILE" ] && echo "mocha" > "$FLAVOR_FILE"

main "$@"
