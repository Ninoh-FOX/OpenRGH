#!/bin/bash

echo "Checking how to get superuser privileges..."
if (( $UID == 0 ))
then
	echo "running as root"
	SU_CMD="sh -c"
else
	echo -n "sudo: "
	if which sudo
	then
		SU_CMD="sudo sh -c"
	else
		echo 'using "su"'
		SU_CMD="su -c"
	fi
fi
echo
