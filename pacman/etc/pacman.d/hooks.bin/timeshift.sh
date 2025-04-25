#!/usr/bin/env bash

#/etc/pacman.d/hooks.bin/timeshift.sh
find /run/timeshift/backup/timeshift/snapshots-ondemand -mmin -60 | grep $(date +%Y-%m-%d)

if [ $? -eq 0 ]; then
	echo "timeshift backup canceled, time threshold not met"
else
	echo "press any key to cancel timeshift snapshot"
	sleep 1
	for (( i=9; i>0; i--)); do
		echo -n "$i seconds left to cancel snapshot  ... hit any key " $'\r'
		read -s -n 1 -t 1 key
		if [ $? -eq 0 ]; then
			# sudo kill -2 `ps -ef|grep -i timeshift| grep -v grep| awk '{print $2}'`
			echo " "
			echo "aborting timeshift snapshot" 
			echo " "
			exit
		fi
	done

	echo " "
	echo "Initiating Pre-Update Timeshift Snapshot"
	echo " "
	/usr/bin/timeshift --create --comments "timeshift-pacman-hook-snapshot"
fi
exit
