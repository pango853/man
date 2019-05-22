#!/bin/bash

LOG_FILE=/var/log/pango/storehouse.log
ERR_FILE=/var/log/pango/storehouse-err.log
#BEEP_LOG=/var/log/BEEP/BAK-storehouse.on
#BAK_DST=/media/STOREHOUSE/HOMESHARE
DEVICE_PATH=/dev/$1

### Start signal
echo -en "\a" > /dev/tty5
usleep 100000
echo -en "\a" > /dev/tty5
usleep 100000
echo -en "\a" > /dev/tty5

echo "### START ### - `date`" >> $LOG_FILE
echo "Backup to $DEVICE_PATH ..." >> $LOG_FILE

if [ `mount | grep /media/STOREHOUSE | wc -l` -eq 0 ]; then
	mount -o rw -o noatime -o nodev -o nosuid -o noexec $DEVICE_PATH /media/STOREHOUSE >> $LOG_FILE 2>> $ERR_FILE
	if [ $? -eq 0 ]; then
		# Weekly
		rsync -au --omit-dir-times --exclude 'lost+found' --exclude '*~' -e "ssh -T -c arcfour -o Compression=no -x" edger.hom:/media/HOMESHARE/ /media/STOREHOUSE/HOMESHARE >> $LOG_FILE 2>> $ERR_FILE
		# Monthly
		#rsync -au --delete --progress --omit-dir-times /media/HOMESHARE/ /media/STOREHOUSE/HOMESHARE >> $LOG_FILE 2>> $ERR_FILE
	fi

	sync

	umount /media/STOREHOUSE >> $LOG_FILE 2>> $ERR_FILE
	if [ $? -eq 0 ]; then
		for I in `seq 1 3`; do
			echo -en "\a" > /dev/tty5
	        	usleep 100000
		        echo -en "\a" > /dev/tty5
		        usleep 100000
	        	echo -en "\a" > /dev/tty5
		        sleep 1
		done
	fi
fi
echo "### END ### - `date`" >> $LOG_FILE

