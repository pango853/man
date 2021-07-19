

# MISC

## Set-ExecutionPolicy
Set-ExecutionPolicy Remote-signed -Scope Process
Set-Executionpolicy -Scope CurrentUser -ExecutionPolicy UnRestricted
HKEY_CURRENT_USER\Software\MicrosoftPowerShell\1\ShellIds\Microsoft.PowerShel  
	ExecutionPolicy

## Bypass the PowerShell Execution Policy

Use the Invoke-Expression Command
> Get-Content .runme.ps1 | Invoke-Expression

Use the “Bypass” Execution Policy Flag
> PowerShell.exe -ExecutionPolicy Bypass -File .runme.ps1

Or even better with
> PowerShell.exe -ExecutionPolicy Remote-signed -File .runme.ps1

Disable ExecutionPolicy by Swapping out the AuthorizationManager
function Disable-ExecutionPolicy {($ctx = $executioncontext.gettype().getfield("_context","nonpublic,instance").getvalue( $executioncontext)).gettype().getfield("_authorizationManager","nonpublic,instance").setvalue($ctx, (new-object System.Management.Automation.AuthorizationManager "Microsoft.PowerShell"))}  Disable-ExecutionPolicy  .runme.ps1

# Tutorials

## Integrate with Outlook

```ps
$olFolderCalendar = 9
$ol = New-Object -ComObject Outlook.Application
$ns = $ol.GetNamespace('MAPI')
$Start = (Get-Date).AddDays(-1).ToShortDateString()
$End = (Get-Date).ToShortDateString()

$Filter = "[MessageClass]='IPM.Appointment' AND [Start] > '$Start' AND [End] < '$End'"
$ns.GetDefaultFolder($olFolderCalendar).Items.Restrict($Filter) 
```

TODO: https://devblogs.microsoft.com/scripting/use-powershell-to-export-outlook-calendar-information/
TODO: https://github.com/umezy12/myscript/blob/master/calendar.ps1


## Get Hash

Get-ChildItem -Path H:\MUSIC\ –Recurse -File | %{ $_.FullName }
Get-ChildItem -Path D:\tmp\MUSIC\ –Recurse -File -Name | ForEach-Object {
	echo "$_"
	CertUtil -hashfile "D:\tmp\MUSIC\$_" SHA1
} >> test.txt


CertUtil -hashfile <path to file> SHA1

# Find empty directories

(gci .\ -r | ? {$_.PSIsContainer -eq $True}) | ? {$_.GetFiles().Count -eq 0} | select FullName

Get-ChildItem -Directory -Recurse | Where-Object { $_.GetFileSystemInfos().Count -eq 0 }

## MSIX PowerShell Cmdlets

To install an MSIX or MSIX bundles.
	Add-AppPackage -path "C:\Caphyon\MyApp.msix"
	Add-AppPackage -path “C:\Caphyon\MyBundle.msixbundle”

Check information
	Get-AppPackage -name “Caphyon.MyApp”
	Get-AppPackage -User “Domain\Username” // to get all the packages installed for a specific user

	Get-AppxPackage -allusers *Microsoft.VCLibs.140.00* | Select Name, PackageFullName
	Get-AppxPackage microsoft.windowsterminal

Remove. The removable package name is composed like Vendor.AppName_Version_Build_Hash, where Build can be neutral or X64.
	Remove-AppPackage -Package "Caphyon.MyApp_1.0.0.0_neutral__8wekyb3d8bbwe"
To remove the MSIX from all users.
	Remove-AppPackage -Package "Caphyon.MyApp_1.0.0.0_neutral__8wekyb3d8bbwe" -AllUsers .

You can add a new Appx volume and then set it as default. By default, all the MSIX/Appx packages are installed in %ProgramFiles%\WindowsApps.
	Add-AppxVolume -Path "E:\WindowsApps"		// It’s necessary to specify \WindowsApps after the volume you choose.
	Set-AppxDefaultVolume -Volume E:\
Move installed MSIX package to new place.
	Move-AppPackage -Package "Caphyon.MyApp_1.0.0.0_neutral__8wekyb3d8bbwe" -Volume E:\

To dismount a volume or To remove a volume.
	Dismount-AppxVolume -Volume E:\
	Remove-AppxVolume -Volume E:\

To run an application inside the MSIX container you can use the Invoke-CommandInDesktopPackage cmdlet.
For example, launch cmd or view the merged registry hive, you can open up commands inside the MSIX.
	Invoke-CommandInDesktopPackage -PackageFamilyName "Caphyon.SampleMSIXPackage_r21n0w1rc5s2y" -appid "SampleMSIXPackage" -command "cmd.exe" -preventbreakaway
	Invoke-CommandInDesktopPackage -PackageFamilyName "Caphyon.SampleMSIXPackage_r21n0w1rc5s2y" -appid "SampleMSIXPackage" -command "regedit.exe" -preventbreakaway

// To find out your MSIX AppID, check out here: https://www.advancedinstaller.com/msix-packagename-app-id.html.

