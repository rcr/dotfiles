#!/bin/bash

alarm=$(cat /sys/class/power_supply/BAT0/alarm)

A=$(echo "scale=2; `cat /sys/class/power_supply/BAT0/charge_now` / `cat /sys/class/power_supply/BAT0/charge_full`" | bc | cut -c 2-3)
if (($A < 79)); then
	notify-send "Warning:" "Battery charge: $A" --icon=/usr/share/icons/oxygen/48x48/status/task-attention.png
fi
