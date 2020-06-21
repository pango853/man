
# Misc

## How to Extend Office 2016 / Office 365 Trial to 180 Days

1. Sign out microsoft account from Office
2. Start cmd.exe as Administrator and run as below.
```bat
C:\Windows\system32>cd C:\Program Files\Microsoft Office\Office16

C:\Program Files\Microsoft Office\Office16>OSPPREARM.EXE
Microsoft Office rearm successful.

C:\Program Files\Microsoft Office\Office16>cscript OSPP.VBS /dstatus

```
