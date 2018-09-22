#!/bin/bash -xv

#exec &> /run/shm/shutdown.log
exec &> /dev/null

GPIO=21

#‰ŠúÝ’è
echo "$GPIO" > /sys/class/gpio/export

wait_sw () {
	
	exec 2> /run/shm/shutdown_sw.log
	sudo shutdown -h now
}

while :
do
	#data=`cat /sys/class/gpio/gpio$GPIO/value`
	#if [ $data -eq 0 ]; then
	
	if grep -q 0 /sys/class/gpio/gpio$GPIO/value ; then
		sleep 0.1
		
		wait_sw
		
		sleep 0.1
		break;
	fi
done