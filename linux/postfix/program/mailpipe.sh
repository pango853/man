#!/bin/sh

# Simple shell-based filter. It is meant to be invoked as follows:
#       /path/to/script -f sender recipients < mail.txt

# Localize these. The -G option does nothing before Postfix 2.3.
INSPECT_DIR="/home/postman/.filter"
SENDMAIL="/usr/sbin/sendmail -G -i" # NEVER NEVER NEVER use "-t" here.

# Exit codes from <sysexits.h>
EX_TEMPFAIL=75
EX_UNAVAILABLE=69

# Clean up when done or when aborting.
trap "rm -f filter.$$" 0 1 2 3 15

# Start processing.
cd $INSPECT_DIR || {
echo $INSPECT_DIR does not exist; exit $EX_TEMPFAIL; }

cat >filter.$$ || { 
echo Cannot save mail to file; exit $EX_TEMPFAIL; }

$SENDMAIL "$@" <filter.$$

# catch mail and dump to mysql
#/usr/bin/php /var/www/mailmanager/program/mailman.php < in.$$ ||{
#echo Cannot catch and store email!; exit 0; }

exit $?
