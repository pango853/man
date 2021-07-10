
https://github.com/PowerShell/Win32-OpenSSH/releases

OpenSSH-Win64.zip
C:\Program Files\OpenSSH-Win64

Add to PATH:
	C:\Program Files\OpenSSH-Win64

Powershell
	.\install-sshd.ps1


.\ssh-keygen.exe

Services
	Start, Set as Automative
Firewall
	New Rule > Custom > All programs > TCP 22







ssh --% username@domain.com powershell -c $ConfirmPreference = 'None'; Repair-AuthorizedKeyPermission C:\Users\spchan\.ssh\authorized_keys

Be your company's Microsoft insider by reading these Windows a



$acl = Get-Acl C:\ProgramData\ssh\administrators_authorized_keys
//$acl = Get-Acl C:\Users\spchan\.ssh\authorized_keys
$acl.SetAccessRuleProtection($true, $false)
$administratorsRule = New-Object system.security.accesscontrol.filesystemaccessrule("Administrators","FullControl","Allow")
$systemRule = New-Object system.security.accesscontrol.filesystemaccessrule("SYSTEM","FullControl","Allow")
$acl.SetAccessRule($administratorsRule)
$acl.SetAccessRule($systemRule)
$acl | Set-Acl


# Solution to use .ssh\\authorized_keys for user

For sshd-config do the following changes:

    Comment this one:

```
#Match Group administrators
#      AuthorizedKeysFile __PROGRAMDATA__/ssh/administrators_authorized_keys
```
    Uncomment these two:

```
PubkeyAuthentication yes
PasswordAuthentication no
```

Then open PowerShell as Admin and restart service:
Restart-Service sshd

Then through GUI.
For .ssh folder and authorized_keys file do the following:

    Properties -> Security -> Advanced -> Disable inheritance -> Convert inherited permissions into explicit permissions on this object.
    Then delete all users(groups) except:

    System
    Administrators
    current user

REF: https://github.com/PowerShell/Win32-OpenSSH/issues/1306

