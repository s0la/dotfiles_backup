#!/bin/bash

command() {
	escaped_command=$(echo $2 | sed -e 's/\\/\\\\/g' -e 's/\//\\\//g' -e 's/&/\\&/g')
	sed -i "s/\($1=\"\).*\(\".*\)/\1$escaped_command\2/" ~/Desktop/bar/media.sh
}

fifo="/home/vlada/Desktop/fifo"

#change_command="~/Desktop/bar/popup.sh &"
#music_controls="%{A:mpc prev; $change_command:} %{A}%{A:mpc toggle; $change_command:}\$toggle_icon%{A}\$stop%{A:mpc next; $change_command:} %{A}"

#[[ $1 ]] && extand='%{A:~/Desktop/bar/media_controls.sh \$toggle_icon:}  %{A}' || extand=""
#[[ $1 ]] && controls="$music_controls" || controls=""
#[[ $1 ]] && volume='$(~/Desktop/bar/volume.sh MEDIA "$command" "$value")' || volume=""
#[[ $1 ]] && player='%{O15}$(~/Desktop/bar/player_modes.sh)' || player=""
#[[ $1 ]] && close='%{A:~/Desktop/bar/media_controls.sh:} %{A}' || close=""

if [[ $1 ]]; then
	extand='%{A:~/Desktop/bar/media_controls.sh:}  %{A}'
	#progressbar="\$(~/Desktop/bar/song_progress.sh 4) %{T3}"
	progressbar='%{T5}$(~/Desktop/bar/song_progress.sh)'
	controls="%{T3} %{A:mpc prev:} %{A}%{A:mpc toggle:}\$toggle_icon%{A}\$stop%{A:mpc next:} %{A}%{O15}"
	volume='$(~/Desktop/bar/volume.sh MEDIA "$command" "$value")'
	player='%{O15}$(~/Desktop/bar/player_modes.sh)'
	close='%{A:~/Desktop/bar/media_controls.sh:} %{A}'
else
	extand='%{A:~/Desktop/bar/media_controls.sh ext:}  %{A}'
fi

command extand "$extand"
command progressbar "$progressbar"
command controls "$controls"
command volume "$volume"
command player "$player"
command close "$close"
