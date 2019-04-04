

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
