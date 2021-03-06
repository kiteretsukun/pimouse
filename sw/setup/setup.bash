#!/bin/bash -xv

#exec &> /run/shm/setup.log
exec &> /dev/null

GPIO=20

#初期設定
echo "$GPIO" > /sys/class/gpio/export

wait_sw () {
	
	exec 2> /run/shm/setup.log

	cd /home/pi/RaspberryPiMouse/src/drivers/
	/sbin/insmod rtmouse.ko

	sleep 1
	chmod 666 /dev/rt*

	### run the main script ###
	chmod a+x /home/pi/pimouse/sw/run/main.bash
	sudo -u pi /home/pi/pimouse/sw/run/main.bash > /dev/null 2> /dev/null &
	
	###LEDを消す###
	echo 0 | tee /dev/rtled?
	###モーターを止める###
	echo 0 | tee /dev/rtmotor[_e]*
	
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