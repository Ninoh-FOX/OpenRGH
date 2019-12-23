#!/bin/bash

STATE=`cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor`
counter=0

while [[ $STATE != "userspece" ]]; do
	echo 'userspace' > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
	sleep 1

	STATE=`cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor`
	counter=$((counter+1))
	if [[ $counter -gt 10 ]]; then
		break;
	fi
	echo "counter = $counter"
	echo "state = $STATE"
done

echo "done"
echo "counter = $counter"
echo "state = $STATE"

exit 0
