#!/bin/bash

current_workspace=$(wmctrl -d | awk '/ \* / {print $NF}')
workspaces=" "

for workspace in $(seq 1 $1); do
	[ $workspace -eq $current_workspace ] && icon=" " || icon=" "
	workspaces+="%{A:wmctrl -s $((workspace - 1)):}$icon%{A}"
done

echo -e "%{F#c2c2c2}$workspaces%{F#c2c2c2}"
