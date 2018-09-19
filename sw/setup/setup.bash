#!/bin/bash -xv

#exec &> /tmp/switch.log
exec &> /dev/null

GPIO=20

#èâä˙ê›íË
echo "$GPIO" > /sys/class/gpio/export

wait_sw () {
	
	exec 2> /tmp/setup.log

	cd /home/pi/RaspberryPiMouse/src/drivers/
	/sbin/insmod rtmouse.ko

	sleep 1
	chmod 666 /dev/rt*

	### run the main script ###
	chmod a+x /home/pi/pimouse/sw/run/main.bash
	sudo -u pi /home/pi/pimouse/sw/run/main.bash > /dev/null 2> /dev/null &
	
	###LEDÇè¡Ç∑###
	echo 0 | tee /dev/rtled?
	###ÉÇÅ[É^Å[Çé~ÇﬂÇÈ###
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