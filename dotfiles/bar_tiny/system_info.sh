#!/bin/bash

case $1 in
	MAIL*) 
		username="sola931"
		password="sola9090"
		mail_icon="%{A:xfce4-terminal -e mutt:} %{A}"
		mail_count=$(curl -u $username:$password --silent "https://mail.google.com/mail/feed/atom" | xmllint --format - | awk -F '[><]' '/fullcount/ {print $3}')
		[[ $mail_count -gt 0 ]] && mail="$mail_icon$mail_count unread message" && space="%{O30}"
		[[ $mail_count -gt 1 ]] && mail+="s"

		echo -e "$mail$space" ;;
	VOLUME*)
		command="amixer -D pulse sset Master 5%+"
		value=$(amixer -D pulse get Master | sed -n '$s/.*\[\(.*%\).*/\1/p')
		volume="$(~/Desktop/bar/volume.sh SYSTEM "$command" "$value")"

		echo -e "$volume" ;;
	NETWORK*) echo -e " $(iwgetid -r)" ;;
	DATE*) echo -e "%{A:orage &:}$(date "+%I:%M")%{A}" ;;		#"%{A:orage &:} %{A}$(date "+%d %b, %I:%M")" ;;
	SHUT_DOWN) echo -e "%{O20}%{A:~/Desktop/bar/shut_down.sh &:} %{A}"
esac
