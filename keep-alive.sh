#!/bin/bash
# Bash script to persist connection (while afk)
# Script uses xdotool because Bash cannot access OS native hardware
# So you will need to run the below line to install:
# sudo apt-get install xdotool

# Delay for 10 seconds to record initial mouse position
sleep 10

# Record initial mouse position
eval "$(xdotool getmouselocation --shell)"
initial_X="$X"
initial_Y="$Y"

while true; do
    sleep 900 # Sleep for 15 minutes

    echo "working . . ."

    # Move mouse to initial position and click
    xdotool mousemove $initial_X $initial_Y click 1

    # Restore mouse to initial position
    xdotool mousemove $initial_X $initial_Y
done