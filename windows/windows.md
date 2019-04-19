
# MISC

## Measure temperature
wmic /namespace:\\root\WMI path MSAcpi_ThermalZoneTemperature

perfmon
	Thermal Zone Information > Temperature


## How to map a local folder to a drive letter in Windows

- Map a drive with subst

  subst x: C:\Folder\Example
  subst x: /D

- Map a drive with net use
  net use x: \\localhost\c$\Folder\Example

  \\localhost\[Drive]$\Pathtofolder

- Map a Folder to a Drive Letter Directly in the Registry

1. Open Regedit and navigate to the following key:

    HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\DOS Devices

This key will associate virtual drive names with paths and it does so very early in the boot process.

2. Right click on DOS Devices > New > String value, enter the drive letter to map the folder to, including the colon.

3. Double click on the drive letter and enter the following as a path:

    \??\[Fullpathtofolder]

blockquote>

For example:

    \??\D:\Downloads\Work\MyFiles

blockquote>

4. Close the registry editor and reboot the computer as this key is only read during startup. Upon rebooting, the mapping will show in Explorer in the list of hard drives.

If you decide to create a .REG file to add or edit Dos devices, add a second backslash to every backslash in the folder path. It won’t work otherwise. An example .REG file of the above would be:

    Windows Registry Editor Version 5.00

    [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\DOS Devices]
    “X:”=”\\??\\D:\\Downloads\\Work\\MyFiles”
    Read More: https://www.raymond.cc/blog/map-folder-or-directory-to-drive-letter-for-quick-and-easy-access/

## Set task schedular on cmd

> SchTasks /Create /SC DAILY /TN "MyTestTask001" /TR "C:\test.bat" /ST 01:00
> SchTasks /Change /TN "MyTestTask001" /ST 02:00
> SchTasks /Query | findstr MyTestTask001

## Remove files older than N days
> FORFILES /P C:\Temp /D -30 /M *.txt /C "cmd /c echo @path 0x09 was changed 30 days ago"
> FORFILES /P C:\Temp /D -30 /M *.txt /C "cmd /c del @path"


## Flush Memory Cache

> %windir%\system32\rundll32.exe advapi32.dll,ProcessIdleTasks

## How does Run dialog locate executables?
> HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths
