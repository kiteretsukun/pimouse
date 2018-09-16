#!/bin/bash -xv

#exec &> /tmp/switch.log
exec &> /dev/null

GPIO=20

#‰ŠúÝ’è
echo "$GPIO" > /sys/class/gpio/export

wait_sw () {
	
	exec 2> /tmp/setup.log

	cd /home/pi/RaspberryPiMouse/src/drivers/
	/sbin/insmod rtmouse.ko

	sleep 1
	chmod 666 /dev/rt*

	echo 0 > /dev/rtmotoren0
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