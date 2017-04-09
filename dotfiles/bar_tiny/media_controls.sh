#!/bin/bash

command() {
	escaped_command=$(echo $2 | sed -e 's/\\/\\\\/g' -e 's/\//\\\//g' -e 's/&/\\&/g')
	sed -i "s/\($1=\"\).*\(\".*\)/\1$escaped_command\2/" ~/Desktop/bar/media.sh
}

fifo="/home/sola/Desktop/fifo"

change_command="~/Desktop/bar/popup.sh &"
music_controls="%{A:mpc prev; $change_command:} %{A}%{A:mpc toggle; $change_command:}\$toggle_icon%{A}\$stop%{A:mpc next; $change_command:} %{A}"
[[ $1 ]] && controls="$music_controls" || controls="%{A:~/Desktop/bar/media_controls.sh \$toggle_icon:}  %{A}"
[[ $1 ]] && volume='$(~/Desktop/bar/volume.sh MEDIA "$command" "$value")' || volume=""
[[ $1 ]] && player='%{O15}$(~/Desktop/bar/player_modes.sh)' || player=""
[[ $1 ]] && close='%{A:~/Desktop/bar/media_controls.sh:} %{A}' || close=""

command controls "$controls"
command volume "$volume"
command player "$player"
command close "$close"
