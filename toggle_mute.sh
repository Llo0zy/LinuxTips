#!/bin/bash

mute_status=$(amixer -D pulse get Master | grep -oE '\[o?n\]')

if [ "$mute_status" == "[on]" ]; then
    amixer -D pulse sset Master mute &>/dev/null
else
    amixer -D pulse sset Master unmute &>/dev/null
fi

if [ "$mute_status" == "[on]" ]; then
    notify-send "Mute" "Volumen desmuteado"
else
    notify-send "Mute" "Volumen muteado"
fi



