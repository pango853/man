
# get OIDs from a MIB files
snmptranslate-command from net-snmp library. Try it with the following paramenters:

snmptranslate
	-M "directory containing your MIB file"
	-m ALL
	-Pu
	-Tso

snmptranslate \
 -M /home/spchan/work/Win2012system32/ \
 -m ALL \
 -Pu \
 -Tso


snmptranslate \
 -M /home/spchan/work/Win2016system32/ \
 -m ALL \
 -Pu \
 -Tso
