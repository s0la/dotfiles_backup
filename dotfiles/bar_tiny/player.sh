#!/bin/bash

properties=( $(wmctrl -l -G | awk '/music$/ {print $1" "$5" "$6}') )

bottom=""
[[ $(tmux list-panes -t music:0 -F '#F') =~ Z ]] && set_zoom="resizep -t music:0 -Z \;"

case $1 in
	OPEN*)
		if ! wmctrl -i -a ${properties[0]}; then
			[ $3 ] && vis_bar='━━━' || vis_bar='   '
			[ $3 ] && vis_status="yes" || vis_status="no"
			[ $3 ] && list_bar='   ' || list_bar='━━━'
			[ $3 ] && list_status="no" || list_status="yes"
			[ $3 ] && order="ncmpcpp \; splitw -p 15 ncmpcpp -c ~/.ncmpcpp/config_visualizer \; selectp -U" || \
				    order="ncmpcpp -c ~/.ncmpcpp/config_visualizer \; splitw -p 85 ncmpcpp"

			sed -i "/^progressbar_look/ s/\".*/\"$list_bar\"/" ~/.ncmpcpp/config
			sed -i "/^statusbar_visibility/ s/\".*/\"$list_status\"/" ~/.ncmpcpp/config
			sed -i "/^progressbar_look/ s/\".*/\"$vis_bar\"/" ~/.ncmpcpp/config_visualizer
			sed -i "/^statusbar_visibility/ s/\".*/\"$vis_status\"/" ~/.ncmpcpp/config_visualizer
			sed -i "s/\(bottom=\"\).*\(\"\)/\1$3\2/" ~/Desktop/bar/player.sh

			if [[ $2 =~ VERT ]]; then
				xfce4-terminal --geometry=60x45 -T music -e "/usr/bin/tmux -f Desktop/tmux_ncmp new -A -s music $order" &
			else
				#xfce4-terminal -T music -e "/usr/bin/tmux -f Desktop/tmux_ncmp new -A -s music $order"  &
				xfce4-terminal -T music -e "/usr/bin/tmux -f Desktop/tmux_ncmp new -A -s music ncmpcpp" &
			fi
		fi ;;
	VIS*) eval "/usr/bin/tmux $set_zoom resizep -t music:0.0 -Z \; send 8" ;;
	LIST*) eval "/usr/bin/tmux $set_zoom resizep -t music:0.1 -Z \; send 1" ;;
	DEFAULT*)
		if [ "$bottom" ]; then
			list_pane=0 && vis_pane=1
		else
			list_pane=1 && vis_pane=0
		fi

		eval "/usr/bin/tmux $set_zoom send -t music:0.$list_pane 1 \; send -t music:0.$vis_pane 8 \; selectp -t music:0.$list_pane" ;;
esac
