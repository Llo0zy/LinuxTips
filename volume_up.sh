#!/bin/bash

current_volume=$(amixer -D pulse sget Master | grep -oE '[0-9]+%' | sed -n 1p | tr -d '%')
step=5

new_volume=$((current_volume + step))
if [ "$new_volume" -gt 100 ]; then
    new_volume=100
fi

amixer -D pulse sset Master "${new_volume}%" &>/dev/null
notify-send -i audio-volume-low -h int:value:${new_volume} -t 1000 "Volumen: ${new_volume}%"
