#!/bin/bash

percentage=0
[[ $1 ]] && progression_step=$1 || progression_step=4
current_progress=$(mpc | sed -n '/%/ s/.*(\([0-9]*\).*/\1/p')
num_value=`/usr/bin/printf "%.0f" $(bc <<< "scale=1; $current_progress / $progression_step")`

draw() {
	for p in $(seq $2); do
		((percentage += progression_step))
		eval $1+=\"%{A:mpc seek $percentage%:}\$3%{A}\"
	done
}

draw 'elapsed' $num_value "━"
draw 'remaining' $(((100 / progression_step) - num_value)) '━'

echo "%{F#c0c0c0}${elapsed}%{F#a2a2a2}${remaining}%{F#b2b2b2}"	#A3B837	  B3CC33
