iptables-save > 05_iptables/iptables.bak.rules
cp 05_iptables/iptables.test.rules /etc/iptables.up.rules

iptables-restore < /etc/iptables.up.rules
#/sbin/iptables-save > /etc/iptables.up.rules

#cat /etc/network/interfaces > 05_iptables/interfaces.bak
#cat /etc/network/interfaces | sed -f 05_iptables/append.cmd  > /etc/network/interfaces

echo "#!/bin/sh" > /etc/network/if-up.d/iptables 
echo "iptables-restore < /etc/iptables.up.rules" >> /etc/network/if-up.d/iptables 
chmod +x /etc/network/if-up.d/iptables 