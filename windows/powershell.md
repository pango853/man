

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
