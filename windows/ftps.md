

# Setup on Windows Server 2019

1. Go to Server Manager > Open Add roles and Features Wizard
	Add Role
	- Web Server (IIS)
	Add Features
	- Web Server Role (IIS)
		- FTP Server
		  - FTP Service
3. Go to Windows Defender Firewall > Click allow an app or feature through Windows Defender Firewall > Allow another app, add svchost.exe (Host Process for Windows Services) and allow it along with FTP server.
4. Open powershell and create a self-signed certificate
	PS> New-SelfSignedCertificate -FriendlyName "selfsigned-localhost" -CertStoreLocation cert:\localmachine\my -DnsName localhost
5. Create a folder to store files and a separate sub-folder for each user.
	- C:\FTPS\user001
	- C:\FTPS\user002
6. Go to Computer Management > Local users and groups > create a new group.
	FTPSUsers
7. Create users who need access to FTPS and add to the group created.
	user001
	user002
8. Open IIS manager and go to FTP Firewall Support.
9. Add data channel port range41200-41300 Add server public IP to the External IP field and click Apply.
10. Delete the Default Web Site first, then right-click on Sites and select Add FTP Site. 
	- Give a meaning name to the site, set the physical path to: C:\inetpub\ftproot, set other settings as follows.
	IP: All Unassigned
	Port: 990
	Check: Start FTP site automatically
	SSL: Require SSL
	SSL Certificate: The certificate we created/installed previously.

11. Hit the next button and use the following settings.
	Authentication: Basic
	Authorization: Specified roles or user groups
	Group: FTPSUsers
	Permissions: Read. Write
12. Select the site you just created and Add Virtual Directory.
	Alias: LocalUser
	Physical path: C:\FTPS or the folder you created to store files.
13. Select the site once again and go to FTP User Isolation.
	Select: "User name directory (disable global virtual directories)" and click Apply.
14. Open windows services and restart Microsoft FTP windows server.


# Setup on Windows Server 2016
- Add Roles and Features
	- Web Server Role(IIS)
		- FTP Server
			- FTP Service
		- Management Tools
			- IIS Management Console
- In IIS Manager, open IIS > Server Certificates.
	Click on Create Self-Signed Certificate action.
	Specify a certificate name (e.g. “FTP Server”) and submit with OK.
	OR
	New-SelfSignedCertificate -FriendlyName "FTP Server" -CertStoreLocation cert:\localmachine\my -DnsName ftp.example.com
- Control Panel > System and Security > Windows Firewall4 > Advanced Settings > Inbound Rules and locate three “FTP server” rules. If the rules are not enabled, click on Actions > Enable Rule. 
- Control Panel > System and Security > Administrative Tools and open Services. Locate Microsoft FTP Service and click Restart service.5



netstat -nat | fgrep 21
netstat -nat | fgrep 990


# Test with lftp


:~$ lftp
lftp :~> set ssl:verify-certificate false; open -u user001,YOURPASSWORD ftps://10.0.0.4:990
lftp user001@10.0.0.4:~> ls
drwxrwxrwx   1 owner    group               0 Nov 16  6:52 LocalUser
drwxrwxrwx   1 owner    group               0 Nov 16  6:48 user001
drwxrwxrwx   1 owner    group               0 Nov 16  6:48 user002
lftp user001@10.0.0.4:/>





lftp ftp://$(FTP_USER)@$(FTP_HOST) -e "mirror -R $(OUTPUTDIR) $(FTP_TARGET_DIR) ; quit"
lftp ftp://username@blogname.com -e "mirror -R /Volumes/HD/Users/me/Test/output /myblog_directory ; quit"

lftp ftp://$(FTP_USER)@$(FTP_HOST) -e "set ftp:ssl-allow no" "mirror -R $(OUTPUTDIR) $(FTP_TARGET_DIR) ; quit"


lftp
	set ssl:verify-certificate/ftp.myblog.com no
	set ssl:verify-certificate false


lftp ftp://$(FTP_USER)@$(FTP_HOST) -e "set ftp:ssl-allow no; mirror -R $(OUTPUTDIR) $(FTP_TARGET_DIR) ; quit"


```~/.lftprc
set ssl:verify-certificate/ftp.myblog.com no
```

```~/.lftp/rc
set ssl:verify-certificate no
set ftp:ssl-allow no
set ssl:check-hostname false;
set ssl:verify-certificate/FI:NG:ER:PR:IN:T:HE:RE no
```

lftp -u username,password host -e "set ftp:ssl-allow no" 

openssl s_client -connect <ftp_hostname>:21 -starttls ftp
copy that -----BEGIN CERTIFICATE-----...-----END CERTIFICATE----- into /etc/ssl/certs/ca-certificates.crt
set ssl:ca-file "/etc/ssl/certs/ca-certificates.crt"

lftp -u "${FTP_USER},${FTP_PWD}" ${FTP_HOST} -e "set net:timeout 10;mirror ${EXCLUDES} -R ${LOCAL_SOURCE_PATH} ${REMOTE_DEST_PATH} ; quit"




