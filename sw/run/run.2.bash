#!/bin/bash

trap 'exit 0' 1

###�O�i###
echo 400 | tee /dev/rtmotor_raw_?0

###�ǂ��߂Â�����~�߂鏈��###

#/tmp/warning�ɉ��������ꂽ�烋�[�v���o��
: > /tmp/warning
while [ ! -s /tmp/warning ] ; do
	cat /dev/rtlightsensor0		|
	awk '$1+$2+$3+$4>500{print "STOP"}' > /tmp/warning
	sleep 0.2
done

###��N��Ԃ�����###
echo 0 > /dev/rtmotoren0
