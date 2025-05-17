#!/usr/bin/env bash

# 1) start Vivaldi (restores your two windows)
vivaldi &

# 2) wait until two Vivaldi windows exist
TIMEOUT=5
start=$SECONDS
while [ "$(hyprctl clients | grep -c 'class: vivaldi-stable')" -lt 2 ]; do
    sleep 0.1
    if [ $(( SECONDS - start )) -ge $TIMEOUT ]; then
        notify-send "Timed out waiting for Vivaldi windows, skipping move." >&2
        exit 0
    fi
done

# helper: grab the Nth window’s address
get_addr() {
    hyprctl clients | awk '/Window /{ addr=$2 }
                           /class: vivaldi-stable/ && NR>0 { addrs[++i]=addr }
                           END{ print addrs['"$1"'] }'
}

# 3) move the first (oldest) window to WS 2
first_addr="$(get_addr 1)"
hyprctl dispatch focuswindow address:"0x$first_addr"
hyprctl dispatch movetoworkspace 2

# 4) move the second window to WS 3
second_addr="$(get_addr 2)"
hyprctl dispatch focuswindow address:"0x$second_addr"
hyprctl dispatch movetoworkspace 3
