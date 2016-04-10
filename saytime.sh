#!/bin/env bash

#To enable debugging mode
#set -o xtrace

foo()
{
	while true
	do
		hour=$(date +"%l")
		minute=$(date +"%M")
		seconds=$(date +"%S")
		meridiem=$(date +"%p")
		if [[ $minute -eq '00' ]]; then
			#Do here
			echo "Do something! It is $hour $meridiem now!"|festival --tts
			#print "$hour $meridiem"
			sleep 60;
		fi
		sleep 1;
	done;
}

foo
