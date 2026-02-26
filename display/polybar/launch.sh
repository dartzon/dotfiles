#!/bin/bash

# Terminate already running bar instances
# If all your bars have ipc enabled, you can use
polybar-msg cmd quit
# Otherwise you can use the nuclear option:
# killall -q polybar

# Identify the primary and secondary monitors
# Look for a monitor that's connected and is marked as primary.
export PRIMARY_MON=$(xrandr --query | awk '/connected/ && /primary/ {print $1}')
# Look for a monitor that's connected but is not primary nor is located on the left of the primary one.
export SECONDARY_MON=$(xrandr --query | awk '$2 == "connected" && $3 != "primary" && $4 != "left" {print $1}')

# Check the laptop's lid status. If the laptop is closed we should not display the screen brightness icon in the bar.
LAPTOP_LID=$(cat /proc/acpi/button/lid/LID/state | awk '{print $2}')
if [ "$LAPTOP_LID" = "closed" ]; then
    # Polybar's brightness script won't find a display card called "No card" and thus,
    # won't display the brightness icon.
    export DISPLAY_CARD="No card"
else
    # Unsetting $DISPLAY_CARD will force Polybar's brightness script to pick the first
    # usable card in /sys/class/backlight.
    unset DISPLAY_CARD
fi

# Launch bar
echo "---" | tee -a /tmp/polybar-primary.log /tmp/polybar-secondary.log
polybar primary 2>&1 | tee -a /tmp/polybar-primary.log & disown

if [ ! -z "${SECONDARY_MON}" ]
then
    polybar secondary 2>&1 | tee -a /tmp/polybar-secondary.log & disown
fi

echo "Polybar launched..."
