#!/bin/bash

_activePort=$(pactl list sinks | grep "Active Port" | cut -d' ' -f3)
if [ $_activePort == "analog-output-speaker" ]; then
    echo  > ~/.config/conky/outfiles/sounddevice.out
elif [ $_activePort == "analog-output-headphones:" ]; then
    echo  > $HOME/.config/conky/outfiles/sounddevice.out
fi

_switchPort=$1
if [ $_switchPort -e 1 ]; then
    echo "Not yet implemented"
fi
