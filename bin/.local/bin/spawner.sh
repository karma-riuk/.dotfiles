#!/usr/bin/env bash
set -euo pipefail

if [ "$#" -lt 3 ]; then
    echo "Usage: $0 <workspace> <cmd…>" >&2
    exit 1
fi

ws="$1"; shift 1

PCT_W="${PCT_W:-70}"   # 70% width by default
PCT_H="${PCT_H:-70}"   # 70% height by default

# split cond into jq key and value
cmd=( "$@" )

# If no window exists matching our condition
if !  hyprctl clients -j | jq -e ".[] | select(.workspace.name==\"special:$ws\")"
then
    hyprctl dispatch exec "[workspace special:$ws silent] ${cmd[*]}"
    sleep 0.05
fi

# toggle it into view...
hyprctl dispatch togglespecialworkspace "$ws"

# if it’s now the active special workspace, re‐center it
active=$(hyprctl -j monitors \
    | jq -r '.[] | select(.focused==true).specialWorkspace.name')

if [[ "$active" == "special:$ws" ]]; then
    hyprctl dispatch resizeactive exact "${PCT_W}%" "${PCT_H}%" 
    hyprctl dispatch centerwindow
fi
