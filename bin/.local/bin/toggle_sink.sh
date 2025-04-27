#!/bin/bash

# Get the default sink
CURRENT_SINK=$(pactl info | grep "Default Sink" | awk '{print $3}')

# Get list of sinks
SINKS=($(pactl list short sinks | awk '{print $2}'))

# Find the index of the current sink
for i in "${!SINKS[@]}"; do
    if [[ "${SINKS[$i]}" == "$CURRENT_SINK" ]]; then
        CURRENT_INDEX=$i
        break
    fi
done

# Calculate next sink index
NEXT_INDEX=$(( (CURRENT_INDEX + 1) % ${#SINKS[@]} ))

# Set the next sink as default
pactl set-default-sink "${SINKS[$NEXT_INDEX]}"

# Move all playing streams to the new sink
for INPUT in $(pactl list short sink-inputs | awk '{print $1}'); do
    pactl move-sink-input "$INPUT" "${SINKS[$NEXT_INDEX]}"
done
