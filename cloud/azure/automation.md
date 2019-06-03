

# Configuring Azure for management through Azure Active Directory authentication


# Add authentication
???

Run As credentials

Add-AzureRmAccount



# Credential Asset
1. Add a credential
Azure portal > Automation Accounts > select one > select Credentials under Shared Resources > Add a credential

- Name: MyCredential
- User name: MyDomain\MyUser
- Password: P@ssw0rd
- Confirm password: P@ssw0rd!

Equals to,
```ps
$user = "MyDomain\MyUser"
$pw = ConvertTo-SecureString "P@ssw0rd!" -AsPlainText -Force
$cred = New-Object –TypeName System.Management.Automation.PSCredential –ArgumentList $user, $pw
New-AzureAutomationCredential -AutomationAccountName "MyAutomationAccount" -Name "MyCredential" -Value $cred
```

2. Confirm
Azure portal > Automation Accounts > select one > select a runbook > Overview > Edit > ASSETS > Credentials > Expand and select MyCredential > Click ... > Add to canvas

3. Code it
```ps
$myCred = Get-AutomationPSCredential -Name 'MyCredential'
$userName = $myCred.UserName
$securePassword = $myCred.Password
$password = $myCred.GetNetworkCredential().Password

$myPsCred = New-Object System.Management.Automation.PSCredential ($userName,$password)
//$myPsCred | Select-Object -Property *
//Write-Host ($myPsCred | Format-List | Out-String)

Connect-AzureRmAccount -Credential $myPsCred
```

# MISC
## Using Azure Resource Manager within Azure Automation
1. Create an Azure Automation Integration Module from the AzureResourceManager PowerShell module.
   Navigate to the AzureResourceManager module within the Azure PowerShell directory on a host with Azure PowerShell installed.
   Then zip up the AzureResourceManager folder.
   e.g. C:\Program Files (x86)\Microsoft SDKs\Azure\PowerShell\ResourceManager\AzureResourceManager
2. Import into Azure Automation
   Importing this zip as an integration module into Azure Automation Modules.
3. After all, write a Runbook that uses AzureResourceManager functionalities.
