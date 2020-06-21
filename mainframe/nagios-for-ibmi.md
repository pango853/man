
https://www.ibm.com/support/pages/setting-nagios-plug-ibm-i
	ftp://public.dhe.ibm.com/software/ibmi/products/pase/nagios/release/20190620/
	ftp://public.dhe.ibm.com/software/ibmi/products/pase/nagios/release/20190620/nagios-plugin-for-ibm-i_20190620.tar.gz



https://github.com/IBM/nagios-for-i/blob/master/README


ftp://public.dhe.ibm.com/software/ibmi/products/pase/nagios/release/20190620/

1. 監視対象の定義(services.cfg) - 手動で下記サンプルをコピーして、services.cfgを作成する
例：nagios-plugin-for-ibm-i_20190620.tar\etc\objects\services.cfg.sample
	define service{
	use generic-service,srv-pnp
	hostgroup_name group1
	service_description Active job number
	check_command check-ibmi-active-job-num!ActiveJobs
	}
2. コマンドの定義(commands.cfg) - インストール時に自動生成する(ibmi_init.sh)
https://github.com/IBM/nagios-for-i.git
	NagiosServer\com\ibm\nagios\config\Initialization.java
        commands.append("      command_name    check-ibmi-active-job-num\r\n");
        commands.append("      command_line    /bin/bash /usr/local/nagios/libexec/check_ibmi_status.sh -m $ARG1$ -H $HOSTADDRESS$ -w $ARG2$ -c $ARG3$\r\n");

3. 手動で試したい場合、
結局上記は以下に相当する
	java -cp /usr/local/nagios/libexec/jt400.jar:/usr/local/nagios/libexec/nagios4i.jar com.ibm.nagios.client.CheckIBMiStatus -m ActiveJobs -H システム名

※システムは別途profile.csvで定義する必要がる。



NagiosServer\com\ibm\nagios\client\CheckIBMiStatus.j

# http://www.comtekservices.com/os400_sysmgr_details.html
```

-- file: nmserveras400.mib---- This file contains all of the NMServer for AS/400 MIBs.  These MIBs-- were previously contained in the following files: comtek.mib, cmtka4v2.mib,-- comtektp.mib, cmtkcmn.mib and cmtkgenq.mib.  These MIBs were collapsed into-- this single file in order to simplify loading the MIBs, no functional changes-- have been made to the MIBs.---- formerly file: comtek.mib---- COMTEK Services, Inc.-- Date         March 2006-- Author       JS---- Copyright 1994-2006 COMTEK Services, Inc.  All Rights Reserved.---- This COMTEK Services SNMP Management Information Base Specification-- (Specification) embodies COMTEK Services' confidential and-- proprietary intellectual property.  COMTEK Services retains all-- title and ownership in the Specification, including any-- revisions.---- This Specification is supplied "AS IS," and COMTEK Services makes-- no warranty, either express or implied, as to the use,-- operation, condition, or performance of the Specification.--COMTEKA4-MIB DEFINITIONS ::= BEGINIMPORTS     enterprises    FROM RFC1155-SMI     DisplayString  FROM RFC1213-MIB     OBJECT-TYPE    FROM RFC-1212     TRAP-TYPE      FROM RFC-1215;comtek OBJECT IDENTIFIER ::= { enterprises 597 }comtekvosMib OBJECT IDENTIFIER                  ::= { comtek 1 }comtekvosAgent OBJECT IDENTIFIER                ::= { comtek 2 }comtekos400Mib OBJECT IDENTIFIER                ::= { comtek 3 }comtekVms OBJECT IDENTIFIER                     ::= { comtek 4 }comtekos400 OBJECT IDENTIFIER                   ::= { comtek 5 }-- SUBAGENT DEFINITIONScomtekSubagent OBJECT IDENTIFIER                ::= { comtek 100 }sampleMib OBJECT IDENTIFIER                     ::= { comtek 101 }sampleSubagent OBJECT IDENTIFIER                ::= { comtek 102 }-- VOS Subagents:-- OS/400 Subagents:os400cmn OBJECT IDENTIFIER                      ::= { comtekos400 1 }os400genericQmonitor OBJECT IDENTIFIER           ::= { comtekos400 2 }-- OpenVMS Subagents:-- Note:  The following pairs of object identifiers must match the values-- in by the subagent code. These numbers uniquely identify the MIB and-- subagent.  Object identifiers for new subagents and their corresponding-- MIBs should be added to the end of this list.comtekVmsNMMasterMib OBJECT IDENTIFIER          ::= { comtekVms 1 }comtekVmsNMMasterAgent OBJECT IDENTIFIER        ::= { comtekVms 2 }comtekVmsNMSysMgrMib OBJECT IDENTIFIER          ::= { comtekVms 3 }comtekVmsNMSysMgrSubagent OBJECT IDENTIFIER     ::= { comtekVms 4 }comtekVmsNMTrpMgrMib OBJECT IDENTIFIER          ::= { comtekVms 5 }comtekVmsNMTrpMgrSubagent OBJECT IDENTIFIER     ::= { comtekVms 6 }comtekVmsNMConsoleMib OBJECT IDENTIFIER         ::= { comtekVms 7 }comtekVmsNMConsoleSubagent OBJECT IDENTIFIER    ::= { comtekVms 8 }comtekVmsNMOpcomMib OBJECT IDENTIFIER           ::= { comtekVms 13 }comtekVmsNMOpcomSubagent OBJECT IDENTIFIER      ::= { comtekVms 14 }comtekVmsNMVmsMonMib OBJECT IDENTIFIER          ::= { comtekVms 15 }comtekVmsNMVmsMonSubagent OBJECT IDENTIFIER     ::= { comtekVms 16 }
-- formerly file: cmtka4v2.mibresources  OBJECT IDENTIFIER  ::= { comtekos400Mib 1 }os400  OBJECT IDENTIFIER  ::= { resources 1 }os400SysName OBJECT-TYPE     SYNTAX  DisplayString     ACCESS read-only     STATUS  mandatory     DESCRIPTION "OS/400 system name.  "     ::= { os400 1 }os400SysModel OBJECT-TYPE     SYNTAX  DisplayString     ACCESS read-only     STATUS  mandatory     DESCRIPTION "OS/400 system model.  "     ::= { os400 2 }os400NumQHistoryEntries OBJECT-TYPE     SYNTAX  INTEGER     ACCESS read-only     STATUS  mandatory     DESCRIPTION "The number of entries in the subagent's QHST table          (os400QHistoryTable).  The QHST table has a maximum          of 100 entries.  "     ::= { os400 3 }os400QHistoryTable OBJECT-TYPE     SYNTAX  SEQUENCE OF Os400QHistoryTableEntry     ACCESS not-accessible     STATUS  mandatory     DESCRIPTION "A simplified version of what is read from the          QHST file.  The MIB variable qhistWaitTime specifies          how often the QHST file is reread for new entries.          This table contains the most recent 100 entries read          from the QHST file.  "     ::= { os400 4 }os400QHistoryTableEntry OBJECT-TYPE     SYNTAX  Os400QHistoryTableEntry     ACCESS not-accessible     STATUS  mandatory     DESCRIPTION "A row in the QHST table.  "     INDEX {os400QHistoryRowNumber}     ::= { os400QHistoryTable 1 }Os400QHistoryTableEntry ::= SEQUENCE {   os400QHistoryRowNumber       INTEGER,   os400HstMessage      DisplayString          }os400QHistoryRowNumber OBJECT-TYPE     SYNTAX  INTEGER     ACCESS read-only     STATUS  mandatory     DESCRIPTION "The row number of the QHST table. This value is used as          the index into the os400QHistoryTable.  "     ::= { os400QHistoryTableEntry 1 }os400HstMessage OBJECT-TYPE     SYNTAX  DisplayString     ACCESS read-only     STATUS  mandatory     DESCRIPTION "The text of the QHST entry.  "     ::= { os400QHistoryTableEntry 2 }os400UtcOffset OBJECT-TYPE

```


# Alternatives: IBM i SNMP
https://www.ibm.com/support/pages/ibm-i-snmp-overview

https://www.ibm.com/support/knowledgecenter/SSMPHH_9.5.0/com.ibm.guardium95.doc/administer/topics/monitoring_via_snmp.html
