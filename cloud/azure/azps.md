
# Install
@ref https://docs.microsoft.com/en-us/powershell/azure/install-az-ps?view=azps-2.1.0

$PSVersionTable.PSVersion.Major -ge 5.0
Install-Module -Name AzureRM -AllowClobber # OLD!

( $PSVersionTable.PSVersion.Major * 10 + $PSVersionTable.PSVersion.Minor ) / 10 -ge 5.1
Install-Module -Name Az -AllowClobber
Install-Module -Name Az -AllowClobber -Scope CurrentUser
Install-Module -Name Az -AllowClobber -Force       # For update
(New-Object System.Net.WebClient).Proxy.Credentials = `
  [System.Net.CredentialCache]::DefaultNetworkCredentials # If use proxy

Get-Command -Verb Get -Noun AzVM* -Module Az.Compute

# Create VM

Connect-AzAccount
New-AzResourceGroup -Name TutorialResources -Location eastus
$cred = Get-Credential -Message "Enter a username and password for the virtual machine."
$vmParams = @{
  ResourceGroupName = 'TutorialResources'
  Name = 'TutorialVM1'
  Location = 'eastus'
  ImageName = 'Win2016Datacenter'
  PublicIpAddressName = 'tutorialPublicIp'
  Credential = $cred
  OpenPorts = 3389
}
$newVM1 = New-AzVM @vmParams
$newVM1
$newVM1.OSProfile | Select-Object ComputerName,AdminUserName
$newVM1 | Get-AzNetworkInterface |
  Select-Object -ExpandProperty IpConfigurations |
    Select-Object Name,PrivateIpAddress
$publicIp = Get-AzPublicIpAddress -Name tutorialPublicIp -ResourceGroupName TutorialResources
$publicIp | Select-Object Name,IpAddress,@{label='FQDN';expression={$_.DnsSettings.Fqdn}}

mstsc.exe /v <PUBLIC_IP_ADDRESS>


$vm2Params = @{
  ResourceGroupName = 'TutorialResources'
  Name = 'TutorialVM2'
  ImageName = 'Win2016Datacenter'
  VirtualNetworkName = 'TutorialVM1'
  SubnetName = 'TutorialVM1'
  PublicIpAddressName = 'tutorialPublicIp2'
  Credential = $cred
  OpenPorts = 3389
}
$newVM2 = New-AzVM @vm2Params
$newVM2

mstsc.exe /v $newVM2.FullyQualifiedDomainName

$job = Remove-AzResourceGroup -Name TutorialResources -Force -AsJob
$job

Wait-Job -Id $job.Id

# Create an Azure service principal with Azure PowerShell
$sp = New-AzADServicePrincipal -DisplayName ServicePrincipalTest01
// $sp = Get-AzADServicePrincipal -DisplayName ServicePrincipalTest01


Import-Module Az.Resources
$credentials = New-Object Microsoft.Azure.Commands.ActiveDirectory.PSADPasswordCredential -Property @{ StartDate=Get-Date; EndDate=Get-Date -Year 2099; Password="OhMyP@ssw0rd"}
$sp = New-AzAdServicePrincipal -DisplayName ServicePrincipalTest02 -PasswordCredential $credentials

$cert = <public certificate as base64-encoded string>
$sp = New-AzADServicePrincipal -DisplayName ServicePrincipalTest03 -CertValue $cert
OR
$cert = <public certificate as base64-encoded string>
$credentials = New-Object Microsoft.Azure.Commands.ActiveDirectory.PSADKeyCredential -Property @{ StartDate=Get-Date; EndDate=Get-Date -Year 2024; KeyId=New-Guid; CertValue=$cert}
$sp = New-AzADServicePrincipal -DisplayName ServicePrincipalTest04 -KeyCredential $credentials

Get-AzADServicePrincipal -DisplayNameBeginsWith ServicePrincipalTest
Get-AzADServicePrincipal -DisplayName ServicePrincipalTest01

New-AzRoleAssignment -ApplicationId <service principal application ID> -RoleDefinitionName "Reader"
Remove-AzRoleAssignment -ApplicationId <service principal application ID> -RoleDefinitionName "Contributor"
Get-AzRoleAssignment -ServicePrincipalName ServicePrincipalTest01

$sp.Id
$sp.ApplicationId
(Get-AzContext).Tenant.Id

## Sign in using a service principal
$credentials = Get-Credential	# Use the service principal's Application ID for the username!
Connect-AzAccount -ServicePrincipal -Credential $credentials -Tenant <tenant ID> 

Get-AzContext


Connect-AzAccount -ServicePrincipal -TenantId $tenantId -CertificateThumbprint <thumbprint>

## Reset credentials
$newCredential = New-AzADSpCredential -ServicePrincipalName ServicePrincipalTest01

Remove-AzADSpCredential -DisplayName ServicePrincipalTest01
Remove-AzADApplication -DisplayName ServicePrincipalTest01


# MISC
## Generate Self-Signed Certificate

```
Install-Module WindowsCompatibility
Import-WinModule PKI
New-SelfSignedCertificate .....
```
OR
dotnet dotnet-dev-certs global tool, designed for generating self-signed certificates for ASP.NET Core development
OR
openssl


# 個人用証明書ストアに生成
$cert = New-SelfSignedCertificate `
            -DnsName "server01", `
                     "server01.honsya.local", `
                     "server.artisan-kogyo.com" `
            -CertStoreLocation "cert:\LocalMachine\My" `
            -NotAfter (Get-Date).AddYears(100) #100年後に期限が切れるので忘れずに更新すること

# "C:\ServerCert.cer" にファイルとしてエクスポート
Export-Certificate -Cert $cert -FilePath "C:\ServerCert.cer"

# 証明書ストアをお掃除
Remove-Item $cert.PSPath


$cert = New-SelfSignedCertificate -Type Custom -KeySpec Signature `
-Subject "CN=P2SRootCert" -KeyExportPolicy Exportable `
-HashAlgorithm sha256 -KeyLength 2048 `
-CertStoreLocation "Cert:\CurrentUser\My" -KeyUsageProperty Sign -KeyUsage CertSign

New-SelfSignedCertificate -Type Custom -DnsName P2SChildCert -KeySpec Signature `
-Subject "CN=P2SChildCert" -KeyExportPolicy Exportable `
-HashAlgorithm sha256 -KeyLength 2048 `
-CertStoreLocation "Cert:\CurrentUser\My" `
-Signer $cert -TextExtension @("2.5.29.37={text}1.3.6.1.5.5.7.3.2")

Get-ChildItem -Path “Cert:\CurrentUser\My”
	Thumbprint                                Subject

	AED812AD883826FF76B4D1D5A77B3C08EFA79F3F  CN=P2SChildCert4
	7181AA8C1B4D34EEDB2F3D3BEC5839F3FE52D655  CN=P2SRootCert

## Generating your Root CA
Create the Root CA private key. https://www.openssl.org/docs/manmaster/apps/genrsa.html
> openssl genrsa -out myRootCA.key 4096

Generate the Root CA certificate signed with the private key. https://www.openssl.org/docs/manmaster/apps/req.html
> openssl req -x509 -new -nodes -key myRootCA.key -days 3650 -out myRootCA.pem
	# Country Name (2 letter code) [AU]:AU
	# State or Province Name (full name) [Some-State]:NSW
	# Locality Name (eg, city) []:Sydney
	# Organization Name (eg, company) [Internet Widgits Pty Ltd]: MY-DEV-CA
	# Organizational Unit Name (eg, section) []: dev
	# Common Name (eg, YOUR name) []: my-dev-ca
	# Email Address []: my@example.com

Pacakge your public and private key in a pkcs12 encripted file (to install with certmgr on windows). https://www.openssl.org/docs/manmaster/apps/pkcs12.html
> openssl pkcs12 -export -inkey myRootCA.key -in myRootCA.pem -out myRootCA.pfx 

## Generating your TLS cert
Create a private key for the ssl cert. https://www.openssl.org/docs/manmaster/apps/genrsa.html
> openssl genrsa -out myTLS.key 2048

Generate the TLS certificate request. https://www.openssl.org/docs/manmaster/apps/req.html
> openssl req -new -key myTLS.key -out myTLS.req
	# Country Name (2 letter code) [AU]:AU
	# State or Province Name (full name) [Some-State]:NSW
	# Locality Name (eg, city) []:Sydney
	# Organization Name (eg, company) [Internet Widgits Pty Ltd]:dev
	# Organizational Unit Name (eg, section) []:dev
	# Common Name (eg, YOUR name) []:sweet-az.azurewebsites.net
	# Email Address []:me@email.com
	# A challenge password []:1234%
	# An optional company name []:Kloud

Sign the request with a previously generated Root CA
> openssl x509 -req -in myTLS.req -CA myRootCA.pem -CAkey myRootCA.key -CAcreateserial -out myTLS.pem -days 3650

Pacakge your public and private key in a pkcs12 encripted file (to install with certmgr on windows). https://www.openssl.org/docs/manmaster/apps/pkcs12.html
> openssl pkcs12 -export -inkey myTLS.key -in myTLS.pem -out myTLS.pfx


# TODO
https://4sysops.com/archives/download-and-install-azure-powershell/