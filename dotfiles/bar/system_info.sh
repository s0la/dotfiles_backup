#!/bin/bash

#fg='%{F#909090}'
fg='%{F#999}'

case $1 in
	MAIL*) 
		username="sola931"
		password="sola9090"
		mail_icon="%{A:xfce4-terminal -e mutt:} %{A}"
		mail_count=$(curl -u $username:$password --silent "https://mail.google.com/mail/feed/atom" | xmllint --format - | awk -F '[><]' '/fullcount/ {print $3}')
		[[ $mail_count -gt 0 ]] && mail="$mail_icon $mail_count mail" && space="%{O30}"
		[[ $mail_count -gt 1 ]] && mail+="s"

		#echo -e "%{B#474747}$fg$space$mail$space" ;;
		echo -e "$fg$space$mail$space" ;;
	VOLUME*)
		command="amixer -D pulse sset Master 5%+"
		value=$(amixer -D pulse get Master | sed -n '$s/.*\[\(.*%\).*/\1/p')
		volume="$(~/Desktop/bar/volume.sh SYSTEM "$command" "$value")"

		#echo -e "%{B#3d3d3d}$fg%{O30}$volume%{O30}" ;;
		echo -e "$fg%{O30}$volume%{O30}" ;;
	NETWORK*) echo -e " $(iwgetid -r)" ;;
	#DATE*) echo -e "%{B#323232}$fg%{O30}%{A:orage &:}$(date "+%I:%M")%{A}%{O30}" ;;		#"%{A:orage &:} %{A}$(date "+%d %b, %I:%M")" ;;
	DATE*) echo -e "$fg%{O30}%{A:orage &:}$(date "+%I:%M")%{A}%{O30}" ;;
	#SHUT_DOWN) echo -e "%{B#2a2a2a}$fg%{O15}%{A:~/Desktop/bar/shut_down.sh &:} %{A}%{O7}"
	SHUT_DOWN) echo -e "$fg%{O15}%{A:~/Desktop/bar/shut_down.sh &:} %{A}%{O7}"
esac
