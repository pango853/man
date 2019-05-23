#! /bin/bash

PATH=/bin:/usr/bin:/sbin:/usr/sbin
MYROOT="/home/pango/setting"
MYOWN=`id -un`

FAILCODE=1

echo "You need to be a Super User or root..."
echo "PWD: "`sudo pwd`
sudo su

### BASIC FUNCTIONS ##########################


function func_backup
{
	cp $1 $2 ||{
		echo "func_backup FAILED : $1 $2."; exit "$FAILCODE";
	}
	chown "$MYOWN":"$MYOWN" $2 ||{
		echo "func_backup FAILED : $1 $2."; exit "$FAILCODE";
	}
}

function func_replaceifnew #ARGV(NEW, OLD)
{
	test $(stat -c %Y $1) -gt $(stat -c %Y $2)
	if [ $? ] ; then
		TMEPOWN=`stat -c %U $2`
		TMEPGRP=`stat -c %G $2`
		cp -f $1 $2 ||{
			echo "func_replaceifnew FAILED : $1 $2."; exit "$FAILCODE";
		}
		chown "$TMEPOWN":"$TMEPGRP" $2 ||{
			echo "func_backup FAILED : $1 $2."; exit "$FAILCODE";
		}
	else
		echo " IGNORE : $1 is older than $2."
	fi
}

function func_update
{
	if [ $# -eq 2 ]; then
		# without backup
		func_replaceifnew $2 $1
	fi
	if [ $# -eq 3 ]; then
		# with backup
		func_backup $1 $3
		func_replaceifnew $2 $1
	fi
}

##############################################
function nginx
{
	echo "UPDATE ngnix..."
	func_update /usr/local/nginx/sites-available/pango.conf "$MYROOT"/nginx/pango.conf "$MYROOT"/nginx/pango.conf-bak
	echo "DONE.";echo "PLEASE RUN : # sudo /etc/init.d/nginx reload";echo ""
}
function postfix
{
	echo "UPDATE postfix..."
	func_update /etc/postfix/main.cf   "$MYROOT"/postfix/main.cf   "$MYROOT"/postfix/main.cf-bak
	func_update /etc/postfix/master.cf "$MYROOT"/postfix/master.cf "$MYROOT"/postfix/master.cf-bak
	echo "DONE.";echo "PLEASE RUN : # sudo /etc/init.d/postfix reload";echo ""
}

function dovecot
{
	echo "UPDATE dovecot..."

	echo "DONE.";echo "PLEASE RUN : # sudo /etc/init.d/dovecot reload";echo ""
}

if [ $# -gt 0 ]; then
	for i in "$@"; do
		eval "$i"
	done
else
	echo "Usage: $0 {nginx|postfix|dovecot}"
        exit 1
fi
