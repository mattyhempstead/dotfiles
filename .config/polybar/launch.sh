#!/bin/bash

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Launch Polybar, using default config location ~/.config/polybar/config
polybar bar & polybar bar-right & polybar bar-left & polybar bar-top
#polybar bar & polybar bar-left
#polybar bar & polybar bar-right

