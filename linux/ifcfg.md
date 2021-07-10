
# MISC

## Predictable Network Interface Device Names
eth1
eth2


enp0s3
enp0s8
enp0s9

enp1s0

eno1
eno2


https://www.freedesktop.org/wiki/Software/systemd/PredictableNetworkInterfaceNames/
    Names incorporating Firmware/BIOS provided index numbers for on-board devices (example: eno1)
    Names incorporating Firmware/BIOS provided PCI Express hotplug slot index numbers (example: ens1)
    Names incorporating physical/geographical location of the connector of the hardware (example: enp2s0)
    Names incorporating the interfaces's MAC address (example: enx78e7d1ea46da)
    Classic, unpredictable kernel-native ethX naming (example: eth0)


    Two character prefixes based on the type of interface:

    *   en -- ethernet
    *   sl -- serial line IP (slip)
    *   wl -- wlan
    *   ww -- wwan
    *   ib -- Infiniband

    Type of names:

    *   b<number>                             -- BCMA bus core number
    *   ccw<name>                             -- CCW bus group name
    *   o<index>                              -- on-board device index number
    *   s<slot>[f<function>][d<dev_port>]     -- hotplug slot index number
    *   x<MAC>                                -- MAC address
    *   [P<domain>]p<bus>s<slot>[f<function>][d<dev_port>]
                                              -- PCI geographical location
    *   [P<domain>]p<bus>s<slot>[f<function>][u<port>][..]1[i<interface>]
                                              -- USB port number chain




# Configure NIC bonding in CentOS 7 / RHEL 7

modprobe --first-time bonding
Or
modprobe bonding
modinfo bonding

```/etc/modules-load.d/bonding.conf
# Load the bonding kernel module at boot" > 
bonding
```
```/etc/modprobe.d/bonding.conf
alias bond0 bonding
#Or? alias netdev-bond0 bonding
options bond0 miimon=100 mode=4 lacp_rate=1
```
lsmod | fgrep bonding


```/etc/sysconfig/network-scripts/ifcfg-bond0
DEVICE=bond0
TYPE=Bond
NAME=bond0
BONDING_MASTER=yes
BOOTPROTO=none
ONBOOT=yes
IPADDR=192.168.1.70
NETMASK=255.255.255.0
GATEWAY=192.168.1.1
BONDING_OPTS="mode=5 miimon=100"
```

- mode=5
	to provide fault tolerance and load balancing
	@see https://www.linuxtechi.com/network-bonding-centos-6-rhel-6/
	0 or balance-rr		round-robin mode, for fault tolerance and load balancing
    1 active-backup		for fault tolerance
    2 balance-xor		XOR(exclusive-or) mode, for fault tolerance and load balancing
    3 broadcast			for fault tolerance. All transmissions are sent on all slave interfaces.
    4 802.3ad			IEEE 802.3ad dynamic link aggregation mode, creates aggregation groups that share the same speed & duplex settings
    5 balance-tlb		Transmit Load Balancing (TLB) mode for fault tolerance & load balancing
    6 balance-alb		Active Load Balancing (ALB) mode for fault tolerance & load balancing


```/etc/sysconfig/network-scripts/ifcfg-enp0s3
TYPE=Ethernet
BOOTPROTO=none
DEVICE=enp0s3
ONBOOT=yes
HWADDR="08:00:27:69:60:c9"
MASTER=bond0
SLAVE=yes
```

```/etc/sysconfig/network-scripts/ifcfg-enp0s8
TYPE=Ethernet
BOOTPROTO=none
DEVICE=enp0s8
ONBOOT=yes
HWADDR="08:00:27:ea:71:8d"
MASTER=bond0
SLAVE=yes
```

systemctl restart network.service

cat /proc/net/bonding/bond0

ifdown enp0s8
cat /proc/net/bonding/bond0
ifup enp0s8



# Misc
ip link set dev bond0 up
ip addr show bond0
watch -d -n1 netstat -i

ip link set dev bond0 down



echo 1000 > /sys/class/net/bond0/bonding/miimon
echo 6 > /sys/class/net/bond0/bonding/mode
OR
echo balance-alb > /sys/class/net/bond0/bonding/mode

ethtool interface_name | grep "Link detected:"
If MII is supported, the command returns: "Link detected: yes"



## Configure multiple IP addresses for bond0
cp /etc/sysconfig/network-scripts/ifcfg-bond0 /etc/sysconfig/network-scripts/ifcfg-bond0:1
```/etc/sysconfig/network-scripts/ifcfg-bond0:1
DEVICE=bond0:1
BOOTPROTO=none
ONBOOT=yes
IPADDR=192.168.1.201
NETWORK=192.168.1.0
NETMASK=255.255.255.0
USERCTL=no
BONDING_OPTS="mode=1 miimon=100"
```

## 

cat /sys/class/net/bonding_masters
	bond0
cat /sys/class/net/bond0/bonding/slaves

ls /sys/class/net/bond{N}/bonding/
echo 1000 > /sys/class/net/bond0/bonding/miimon
echo 6 > /sys/class/net/bond0/bonding/mode
echo balance-alb > /sys/class/net/bond0/bonding/mode
