#!/bin/bash

fifo="/home/sola/Desktop/fifo"

case $1 in
	SONG)
		song_info=$2
		song_info_index=$3
		display_area=25
		delay=3

		if [[ ${#song_info} -gt $display_area ]]; then
			song_info_index=$(($song_info_index % (${#song_info} + delay + 1 - display_area)))
			((song_info_index = song_info_index > delay ? song_info_index - delay : 0))

			fg="%{F#c5c5c5}"
			ofg="%{F#b3b3b3}" 	# previous color #aaa

			song_info="$fg$ofg ${song_info:$song_info_index:$display_area} $fg"
		fi

		echo -e "%{T1}$song_info" ;;
	CONTROLS) 
		[[ "$3" == "playing" && "$2" ]] && toggle_icon=" " || toggle_icon=" "
		[[ "$4" ]] && stop="%{A:mpc stop; echo 'PROGRESSBAR ' > $fifo; echo 'SONG not playing' > $fifo:} %{A}"
		controls="%{A:mpc prev; ~/Desktop/bar/popup.sh &:} %{A}%{A:mpc toggle; ~/Desktop/bar/popup.sh &:}$toggle_icon%{A}$stop%{A:mpc next; ~/Desktop/bar/popup.sh &:} %{A}"
		echo -e "$controls" ;;
	VOLUME) 
		command="mpc volume +5"
		value=$(mpc volume | sed 's/.*: \([0-9%]*\).*/\1/')
		volume="$(~/Desktop/bar/volume.sh MEDIA "$command" "$value")"
		echo -e "$volume" ;; 
	BUTTONS)
		player="%{O15}$(~/Desktop/bar/player_modes.sh)"
		close="%{A:~/Desktop/bar/media_controls.sh:} %{A}"
		buttons="$player$close"
		echo -e "$buttons" ;;
esac
