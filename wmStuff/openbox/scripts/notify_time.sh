#!/bin/bash

state=$(cat /sys/class/power_supply/BAT0/status)
now=$(cat /sys/class/power_supply/BAT0/charge_now)
full=$(cat /sys/class/power_supply/BAT0/charge_full)

m1=$(echo "scale=2; $now / $full" | bc | cut -c 2-3)%
m2=$(echo "scale=2; $now / $full" | bc)%

echo $state;
echo $m1;
echo $m2;

notify-send "`date \"+%A %d - %R\"`" "Bat: $m1" --expire-time=3000  --icon=/usr/share/icons/oxygen/48x48/apps/clock.png
