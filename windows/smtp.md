
# MISC
## HOW TO: Set Up and Configure an SMTP Virtual Server in Windows 2000
https://support.microsoft.com/en-my/help/308161

- How to Enable Transaction Logging
Log files keep a record of all of the messages that are received and sent on your computer. To turn on logging, follow these steps:

    Click Start, point to Programs, point to Administrative Tools, and then click Internet Services Manager.

    Alternatively, start the IIS snap-in.
    Right-click Default SMTP Virtual Server, and then click Properties.
    Click the General tab.
    Click to select the Enable logging check box.
    In the Active log format box, click the log format in which you want to record information. The default log format is W3C Extended Log File Format.
    Click Properties.
    Specify the settings that you want to use. You can specify settings to include log time period and the location and the name of the log file.
    Click OK, and then click OK.


- Troubleshooting
Issue: Messages are not sent to the Drop folder.


This issue can occur because of either of the following conditions:

    The path to the Drop folder is incorrect.


    To troubleshoot this issue, follow these steps:
        Click Start, point to Programs, point to Administrative Tools, and then click Internet Services Manager.

        Alternatively, start the IIS snap-in.
        Double-click Default SMTP Virtual Server, and then click Domains.
        Right-click the default domain, and then click Properties.
        In the Drop directory box, verify that the path to the Drop folder is valid.
    Either the Drop folder or the hard disk in which the Drop folder is located is full.


    To troubleshoot this issue, free hard disk space in either the Drop folder or on the hard disk in which the Drop folder is located.For additional information about how to troubleshoot Microsoft SMTP Service, click the article number below
    to view the article in the Microsoft Knowledge Base:

    297954 HOW TO: Troubleshoot the Web Server in Windows 2000
    For additional information about how to test Microsoft SMTP Service, click the article number below
    to view the article in the Microsoft Knowledge Base:

    286421 HOWTO: Test Windows 2000 IIS SMTP Services Manually


file:\\%systemroot%\help\mail.chm
For additional information about how to create additional SMTP Virtual Servers, click the article number below
to view the article in the Microsoft Knowledge Base:

303707 HOW TO: Create Additional SMTP Virtual Servers
For additional information about how to create or delete a Microsoft SMTP Service domain, click the article number below
to view the article in the Microsoft Knowledge Base:

303708 HOW TO: Create or Delete a Microsoft SMTP Service Domain
For additional information about how to configure Microsoft SMTP Service local domains, click the article number below
to view the article in the Microsoft Knowledge Base:

303537 HOW TO: Configure Microsoft SMTP Service Local Domains
For additional information about how to start, stop, or pause Microsoft SMTP Service, click the article number below
to view the article in the Microsoft Knowledge Base:

303783 HOW TO: Start or Stop or Pause the Microsoft SMTP Service
For additional information about how to start, stop, or pause an SMTP virtual server, click the article number below
to view the article in the Microsoft Knowledge Base:

303812 HOW TO: Start, Stop, and Pause an SMTP Virtual Server
For additional information about how to enable SMTP protocol logging for IIS, click the article number below
to view the article in the Microsoft Knowledge Base:

303738 HOW TO: Enable SMTP Protocol Logging for Internet Information Services
For additional information about how to configure Microsoft SMTP Service on a Windows 2000-Based server cluster, click the article number below
to view the article in the Microsoft Knowledge Base:

280400 How to Configure the SMTP Resource on a Windows 2000-Based Server Cluster



- PROBLEM - SMTP Logs are not written, even if the IIS SMTP W3C Logs are enabled and there is mail flow. 
  CAUSE - The SMTP service logging is dependant to the ODBC Logging module which needs to be installed.

  If there are no log files, then ODBC Logging Module might be missing and needs to be installed:

    Go to Administrative Tools and open the Server Manager 
    Click on Roles and select Web Server (IIS)
    Go to Role Services and clcik on Add Role Services
    In the Wizard select ODBC Logging under Health and Diagnostics
    Click Next and Install
    On the Results page, click Close


