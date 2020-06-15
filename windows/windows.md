

# Core Server

## Signout or Open Task Manager
    Ctrl + Alt + End

## Setting PowerShell as the Default Shell in Server Core
> powershell
PS> Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon' -Name Shell -Value 'PowerShell.exe -NoExit'


# Storage Replica

1. Preparation
   Create AD
   MD c:\temp
   Test-SRTopology -SourceComputerName NODE01 -SourceVolumeName D: -SourceLogVolumeName E: -DestinationComputerName NODE02 -DestinationVolumeName D: -DestinationLogVolumeName E: -DurationInMinutes 3 -ResultPath c:\temp
2. Configuration
   New-SRPartnership -SourceComputerName NODE01 -SourceRGName N1G1 -SourceVolumeName D: -SourceLogVolumeName E: -DestinationComputerName NODE02 -DestinationRGName N2G1 -DestinationVolumeName D: -DestinationLogVolumeName E: -LogSizeInBytes 1GB -Verbose
Set-SRPartnership –NewSourceComputerName NODE02 –SourceRGName N2G1 –DestinationComputerName NODE01 –DestinationRGName N1G1
Set-SRPartnership –NewSourceComputerName NODE02 –SourceRGName N2G1 –DestinationComputerName NODE01 –DestinationRGName N1G1 –Confirm:$false
Set-SRPartnership –NewSourceComputerName NODE01 –SourceRGName N1G1 –DestinationComputerName NODE02 –DestinationRGName N2G1 –Confirm:$false

$env:COMPUTERNAME
Get-SRGroup
Get-SRPartnerShip
3. Failover
Mount-SRDestination -Name N2G1 -Computername NODE02 -TemporaryPath T:\
Dismount-SRDestination -Name RG2 -Computername SRV2
4. Failback
   TODO...
5. Remove
Get-SRPartnership | Remove-SRPartnership –confirm:$false
Remove-SRGroup –Name FCNode2ReplGrp1
Remove-SRGroup –Name FCNode1ReplGrp1

## Prerequisites
Active Directory VM with a proper forest/domain
Two Windows Server 2016 Datacenter edition domain joined VMs with specs 2vCPU, 4GB RAM, 1vNIC (connected to Internal/Private switch), OS Disk (60GB Dynamically Expanding), 1x Disk of 100GB (Dynamically expanding) and 1x Disk of 50GB (Dynamically expanding)

diskutil GPT disks


$Server01 = "SR01"
$Server02 = "SR02"
$Servers = $Server01,$Server02
$Servers | ForEach { Install-WindowsFeature –ComputerName $_ –Name Storage-Replica,FS-FileServer –IncludeManagementTools -restart }

MD c:\temp
Test-SRTopology -SourceComputerName $Server01 -SourceVolumeName D: -SourceLogVolumeName L: -DestinationComputerName $Server02 -DestinationVolumeName D: -DestinationLogVolumeName L: -DurationInMinutes 3 -ResultPath c:\temp

Review the results in the HTML report generated and fix issues if any.

Step 3:Run the below commands to create a Storage Replica partnership between the two VMs and verify the partership as well as the replication status.

#Create Replica Partnership

New-SRPartnership -SourceComputerName $Server01 -SourceRGName RG01 -SourceVolumeName D: -SourceLogVolumeName L: -DestinationComputerName $Server02 -DestinationRGName RG02 -DestinationVolumeName D: -DestinationLogVolumeName L:

#Verify partnership

Get-SRGroup 

Get-SRPartnership 

(Get-SRGroup).replicas

#Verify Replication - Source

Get-WinEvent -ProviderName Microsoft-Windows-StorageReplica -max 20

#Verify Replication - Destination

Get-WinEvent -ComputerName $Server02 -ProviderName Microsoft-Windows-StorageReplica | Where-Object {$_.ID -eq "1215"} | fl

#View Replication Progress

(Get-SRGroup).Replicas | Select-Object numofbytesremaining

Step 4: Once you have setup the replication, you can test the replication process by copying a large file on to the source Data disk. You can use the above commands to verify the replication progress and status.

NOTE: While replication partnership is active, you can only perform read/write operation on the source data disk. The destination data disk will be locked and unmounted by Storage Replica and will be unavailable.

Step 5: The final step in the lab is to reverse the replication direction and verify the data has been replicated properly. In my case, i replicated a Windows Server 2016 ISO from source to destination. After the below command, I was able to mount the ISO successfully to prove the replication.

You can also remove the replication partnership using the below commands.

#Switch Replication Direction

Set-SRPartnership -NewSourceComputerName $Server02 -SourceRGName RG02 -DestinationComputerName $Server01 -DestinationRGName RG01

#Remove Partnership

Get-SRPartnership 

Get-SRPartnership -ComputerName $Server01 | Remove-SRPartnership 

Get-SRPartnership -ComputerName $Server02 | Remove-SRPartnership 

Get-SRGroup -ComputerName $Server01 | Remove-SRGroup

Get-SRGroup -ComputerName $Server02 | Remove-SRGroup

Storage replica is one of the easiest demo scenario to setup and showcase. The whole setup, switching direction and removing the setup process takes less than 15 minutes to execute.

Until next time, happy learning!


# MISC

## Right click folder in Windows Explorer and Search with Total Commander?
	Windows Registry Editor Version 5.00

	[HKEY_CLASSES_ROOT\Folder\shell\Total_Commander]
	@="Search file contents here"
	"Icon"="imageres.dll,-177"

	[HKEY_CLASSES_ROOT\Folder\shell\Total_Commander\command]
	@="\"C:\\TotalCmd\\TOTALCMD.EXE\" /S=F \"%1\""



# Management tools
- Install dsa.msc for Windows Server 2016
  Import-Module ServerManager
  Install-WindowsFeature RSAT-ADDS


## Useful Commands
- Control Panel   
  > control.exe
- Proxy setting   
  > control Inetcpl.cpl,Connections,4
- Administrative Tools   
  %windir%\system32\control.exe /name Microsoft.AdministrativeTools
- Services
  %WINDIR%\system32\svchost.exe -k LocalServiceAndNoImpersonation

- Combine multiple files into one using Windows Command Prompt
    > copy /b *.txt combined.txt
    OR
    PS> gc File1.bin,File2.bin -Enc Byte -Read 512 | sc new.bin -Enc Byte

- Start file explorer from cmd
	> start .
	> start shell:startup




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

- Turn off Adaptive Brightness   
  Remove SensrSvc.dll from \HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Svchost\LocalServiceAndNoImpersonation

## Flush Memory Cache

> %windir%\system32\rundll32.exe advapi32.dll,ProcessIdleTasks

## How does Run dialog locate executables?
> HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths

## Enable Hyper-V
> bcdedit /set hypervisorlaunchtype auto

## コントロールパネル￥ネットワークとインターネット￥ネットワーク接続
> ncpa.cpl

## Users and Groups, Group Policy & Security Policy
> lusrmgr.msc 
> gpedit.msc
> secpol.msc

## Open browser
> start /min iexplore http://www.bing.com
> start /min microsoft-edge:http://www.bing.com

From Run...
> cmd /c start /min microsoft-edge:http://www.bing.com

## Create Shortcut for Store app in Windows 10
> explorer shell:AppsFolder
> shell:AppsFolder

## icons
ms-appdata:///roaming/git-bash_32px.ico	From %LOCALAPPDATA%\packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\RoamingState

"icon" : "ms-appx:///ProfileIcons/{0caa0dad-35be-5f56-a8ff-afceeeaa6101}.png",
