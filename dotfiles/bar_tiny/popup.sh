#!/bin/bash

kill_popup() {
	kill $(ps -ef | awk '/song_notify/ && !/awk/ {print $2}')
}

if [[ $(pidof lemonbar | wc -w) -gt 1 ]]; then
	kill_popup
	kill $(ps -ef | awk '/bash.*popup.sh/ && !/awk/ {print $2}' | head -n 1)
fi

x=35 

for bar in {1..4}; do
	((x += height))

	case $bar in
		1) display='echo -e "%{O30}%{F#c5c5c5}%{T2}$(~/Desktop/bar/media.sh CONTROLS "$song_info" "$status")%{O65}$volume"' && height=43 && o=7 ;;
		2) display='echo -e "%{O25}%{F#b3b3b3}$song_info"' && height=12 && o=-2 ;;
		3) display='echo -e "%{O25}%{F#b3b3b3}$album_info"' && height=12 && o=-2 ;;
		4) display='echo -e "%{c}%{T2}%{}$(~/Desktop/bar/song_progress.sh 3)"' && height=30 && o=-9 ;;
	esac

	~/Desktop/bar/notification.sh "$display" $height $x $o $bar &
done | wait

sleep 5
kill_popup
