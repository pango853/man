
# Commands

> esxcli vm process list
> vim-cmd vmsvc/getallvms

> vmkping –I vmk1 10.10.10.1 – send ICMP request to 10.10.10.1 through vmk1 interface
> nc –z 10.10.10.10 3260 – test connectivity to 10.10.10.10 on port 3260.
> vmkfstools –i test.vmdk testclone.vmdk – clones test.vmdk to testclone.vmdk

> esxtop 
> vscsiStats 

The VMware Direct User Console Interface (DCUI)
> dcui

> esxcli network nic list
> esxcli network nic get -n vmnic6

> esxcli software vib install -d /vmfs/volumes/my_datastore/my_driver.zip
> esxcli software vib list

> vmware -l
> vmware -v

> services.sh


# MISC
> esxcli

Monitors in real time how ESXi hosts use resources. Runs in interactive or batch mode.
> resxtop

Must run against a vCenter Server system.
> svmotion

Performs advanced configuration.
> esxcli system settings advanced

Remotely configures Active Directory settings for an ESXi host.
> vicfg-authconfig

Backs up the configuration data of an ESXi system and restores previously saved configuration data.
> vicfg-cfgbackup

Specifies an ESXi host’s DNS (Domain Name Server) configuration. See Setting the DNS Configuration.
> esxcli network ip dns


Sets both the partition (esxcli system coredump partition) and the network (esxcli system coredump network) to use for core dumps. Use this command to set up ESXi Dump Collector.
> esxcli system coredump

Manages hosts. Stopping, Rebooting, and Examining Hosts with vicfg-hostops.
> vicfg-hostops

Sets up IPsec (Internet Protocol Security), which secures IP communications coming from and arriving at ESXi hosts. ESXi hosts support IPsec using IPv6.
> vicfg-ipsec

Manages hardware and software iSCSI storage.
> esxcli iscsi

Enables VMkernel options. Use this command with the options listed in this document, or as instructed by VMware.
> esxcli system module


Configures storage arrays.
> esxcli storage core path

Manages NAS/NFS filesystems. See Managing NFS/NAS Datastores.
> esxcli storage nfs

Manages the ESXi host’s uplink adapters. See Managing Uplink Adapters.
> esxcli network nic

Defines the NTP (Network Time Protocol) server. See Adding and Starting an NTP Server.
> vicfg-ntp

Rescans the storage configuration. See Scanning Storage Adapters.
> esxcli storage adapter rescan

Manages the ESXi host’s route entry. See Managing the IP Gateway.
> vicfg-route

Finds and examines available LUNs. See Examining LUNs.
> esxcli storage core adapter

Manages the SNMP agent. Managing ESXi SNMP Agents with vicfg-snmp. Using SNMP in a vSphere environment is discussed in detail in the vSphere Monitoring and Performance documentation.
> vicfg-snmp

Specifies log settings for ESXi hosts including local storage policies and server and port information for network logging. See Configuring ESXi Syslog Services.
> esxcli system syslog

Creates, modifies, deletes, and lists local direct access users and groups of users. See Managing Users.
> vicfg-user

Adds, deletes, and modifies VMkernel network interfaces. See Adding and Modifying VMkernel Network Interfaces.
> esxcli network interface .

Supports resignaturing the copy of a VMFS volume, and mounting and unmounting the copy. See Managing Duplicate VMFS Datastores.
> esxcli storage filesystem volume

Adds or removes virtual switches or modifies virtual switch settings. See Setting Up Virtual Switches and Associating a Switch with a Network Interface.
> esxcli network vswitch

Performs file system operations such as retrieving and uploading files on the ESXi system. See Managing the Virtual Machine File System with vmkfstools.
> vifs

Updates ESXi hosts to a different version of the same major release.
> esxcli software vib

Creates and manipulates virtual disks, file systems, logical volumes, and physical storage devices on an ESXi host. See Managing the Virtual Machine File System with vmkfstools.
> vmkfstools

Performs virtual machine operations remotely. This includes, for example, creating a snapshot, powering the virtual machine on or off, and getting information about the virtual machine. See Managing Virtual Machines.
> vmware-cmd
