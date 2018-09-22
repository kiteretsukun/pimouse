#!/bin/bash

trap 'exit 0' 1

abort() {
	###Ž~‚ß‚é###
	echo 0 | tee /dev/rtmotoren0 /dev/rtled?
	echo ABORT >&2
	exit 1
}

###•Ç‚ª‹ß‚Ã‚¢‚½‚çŽ~‚ß‚éˆ—###
: > /tmp/warning
while sleep 0.1; do
	cat /dev/rtlightsensor0		|
	awk '$1+$2+$3+$4>300{print "STOP"}' > /tmp/warning
	[ -s /tmp/warning ] && abort
done &

###‰Á‘¬###
seq 1 20					|
awk '{print $1*100;system("sleep 0.1")}'	|
tee /dev/rtmotor_raw_?0
