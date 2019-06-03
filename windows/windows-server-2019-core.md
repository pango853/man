
# Setup
## Hyper-V NAT
```ps
Get-NetAdapter
New-NetIPAddress -IPAddress 172.16.0.1 -PrefixLength 24 -InterfaceIndex (Get-NetAdapter | Where-Object {$_.Name -Like '*nat*'} ).ifIndex
New-NetNat -Name HyperVNAT -InternalIPInterfaceAddressPrefix 172.16.0.0/24
```

## Install
ISO: https://software-download.microsoft.com/download/sg/17763.379.190312-0539.rs5_release_svc_refresh_SERVER_EVAL_x64FRE_en-us.iso
version:10.0.17763 release on 2018/9/2

## Initial Setup
0. User&Password
   Administartor:Hogehoge24
1. Static IP
   ```cmd
   netsh interface ipv4 show config
   netsh int ip set address "Ethernet" static 172.16.0.2 255.255.255.0 172.16.0.1 1
   netsh int ip set dns "Ethernet" 172.16.0.1 primary
   netsh interface ip set dns "Ethernet" static 172.16.0.1
   // ?: netsh interface ip add dns "Ethernet" 8.8.8.8 index=2
   // ?: netsh interface ip add dns "Ethernet" 192.168.0.1 index=2   # ROUNTER IP?
   ```
   OR
   `New-NetIPAddress –IPAddress 172.16.0.2 -DefaultGateway 172.16.0.1 -PrefixLength 24 -InterfaceIndex (Get-NetAdapter).InterfaceIndex`
2. Set hostname
   ```
   netdom renamecomputer %COMPUTERNAME% /Newname "WSRV2019"
   shutdown /r /t 0
   ```
3. Enable Remote Login
   `Enable-PSRemoting -SkipNetworkProfileCheck -Force`
4. (OPTIONAL) Setting PowerShell as default
   `Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon' -Name Shell -Value 'PowerShell.exe -NoExit'`
5. Connect from host
   ```ps
   Set-Item -Path WSMan:\localhost\Client\TrustedHosts -Value * -Force
   $session = New-PSSession -ComputerName 172.16.0.2 -Credential (Get-Credential)
   // e.g. Copy-Item PowerShell-6.1.0-preview.1-win-x64.msi C:\ -ToSession $session
   //      msiexec /i C:\ PowerShell-6.1.0-preview.1-win-x64.msi
   ```
   OR
   ```
	winrm quickconfig
	winrm get winrm/config
	winrm set winrm/config/client '@{TrustedHosts="*"}'
	OR
	Set-Item WSMan:\localhost\Client\TrustedHosts -Value "*" -Force
	Enter-PSSession -Computername 172.16.0.2
	Enter-PSSession -ComputerName 172.16.0.2 -Credential "Administrator"

	$session = New-PSSession -ComputerName 172.16.0.2 -Credential (Get-Credential)
	Invoke-Command -Session $session -ScriptBlock { Get-Date }

	(OPTIONAL)
	Get-Item WSMan:\localhost\Service\DefaultPorts\*
	New-NetFirewallRule -Name PsRemotingHttp -Direction Inbound -Action Allow -Protocol tcp -LocalPort 5985 -DisplayName PsRemotingHttp

	winrm set winrm/config/client '@{TrustedHosts="172.16.0.2"}'
	```
## sconfig utility
@ref https://4sysops.com/archives/manage-windows-server-2019-with-admin-center-powershell-core-and-sconfig/#install-powershell-core

> sconfig
```
===============================================================================
                         Server Configuration
===============================================================================

1) Domain/Workgroup:                    Workgroup:  WORKGROUP
2) Computer Name:                       WSRV2019
3) Add Local Administrator
4) Configure Remote Management          Enabled

5) Windows Update Settings:             DownloadOnly
6) Download and Install Updates
7) Remote Desktop:                      Disabled

8) Network Settings
9) Date and Time
10) Telemetry settings                  Unknown
11) Windows Activation

12) Log Off User
13) Restart Server
14) Shut Down Server
15) Exit to Command Line

Enter number to select an option: 
```

## Copy file to remote
```
Set-Item -Path WSMan:\localhost\Client\TrustedHosts -Value * -Force
$session = New-PSSession -ComputerName 172.16.0.2 -Credential (Get-Credential)
Copy-Item PowerShell-6.1.0-preview.1-win-x64.msi C:\ -ToSession $session

Enter-PSSession -ComputerName 172.16.0.2 -Credential (Get-Credential)
cmd
msiexec /i C:\ PowerShell-6.1.0-preview.1-win-x64.msi
exit
```

## Install Windows Admin Center
https://aka.ms/wacdownload -> WindowsAdminCenter1904.1.msi
```
$session = New-PSSession -ComputerName 172.16.0.2 -Credential (Get-Credential)
Copy-Item WindowsAdminCenter1904.1.msi C:\ -ToSession $session
```
```mstsc # Not work through PSRemoteSession
msiexec /i C:\ WindowsAdminCenter1904.1.msi
```
Access https://172.16.0.2/

(Get-Service | Where { $_.Name -Like 'ServerMan*' }) | Stop-Service
Get-Service | Where { $_.Name -Like 'ServerMan*' }
netstat -nat | findstr 443

## Add WindowsFeature
```
Get-WindowsFeature
Remove-WindowsFeature <feature-name> -Remove
```

## Feature on Demand(FoD)
- イベント ビューアー (Eventvwr.msc)
- パフォーマンス モニター (PerfMon.exe)
- リソース モニター (Resmon.exe)
- デバイス マネージャー (Devmgmt.msc)
- Microsoft 管理コンソール (mmc.exe)
- エクスプローラー (Explorer.exe)
- Windows PowerShell (Powershell_ISE.exe)
- フェールオーバー クラスター マネージャー (CluAdmin.msc)

「Additional Downloads」から、FoD Preview の ISO をダウンロードして DISM でインストールするだけです。
ISOをMountしてから、
> DISM /Online /Add-Capability /CapabilityName:ServerCore.AppCompatibility~~~~0.0.1.0 /Source:D: /LimitAccess
> DISM /Online /Add-Capability /CapabilityName:Browser.InternetExplorer~~~~0.0.11.0 /Source:D: /LimitAccess

## Top

WMIC PATH Win32_PerfFormattedData_PerfProc_Process GET /FORMAT:LIST
WMIC PATH Win32_PerfFormattedData_PerfProc_Process WHERE "PercentUserTime > 10" GET Name,IDProcess,PercentUserTime /FORMAT:LIST
WMIC PATH Win32_PerfFormattedData_PerfProc_Process WHERE "WorkingSet > 200000000 AND Name != '_Total'" GET /FORMAT:LIST
WMIC PATH Win32_PerfFormattedData_PerfProc_Process WHERE "IOWriteOperationsPersec > 10 AND Name != '_Total'" GET Name,IDProcess,IOWriteOperationsPersec /FORMAT:LIST
WMIC PROCESS WHERE "ProcessId = 1234" GET Name,ProcessId,CommandLine /FORMAT:LIST
WMIC PROCESS WHERE "CommandLine LIKE '%hadoop%'" GET Name,ProcessId,CommandLine /FORMAT:LIST
WMIC PATH Win32_PerfFormattedData_PerfDisk_LogicalDisk WHERE "Name = 'C:'" GET /FORMAT:LIST
gwmi Win32_PerfFormattedData_PerfProc_Process | ? Name -LIKE "firefox" | ft Name,IDProcess,PercentProcessorTime,WorkingSet


## Packages
Get-WmiObject -Class Win32_Product
Get-ItemProperty HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\* |  Select-Object DisplayName, DisplayVersion, Publisher, InstallDate | Format-Table –AutoSize
Get-ItemProperty HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\* | Select-Object DisplayName, DisplayVersion, Publisher, InstallDate | Format-Table –AutoSize

# WSL
> Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux

> Invoke-WebRequest -Uri https://aka.ms/wsl-ubuntu-1804 -OutFile wsl-ubuntu-1804.appx -UseBasicParsing
OR
> curl.exe -L -o wsl-ubuntu-1804.appx https://aka.ms/wsl-ubuntu-1604
> Rename-Item wsl-ubuntu-1804.appx Ubuntu1804.zip
> Expand-Archive Ubuntu1804.zip Ubuntu1804
> cd ./Ubuntu1804
> .\ubuntu.exe

```
> wsl
wsl : mesg: ttyname failed: Inappropriate ioctl for device
    + CategoryInfo          : NotSpecified: (mesg: ttyname f...octl for device:String) [], RemoteException
    + FullyQualifiedErrorId : NativeCommandError
```
=> Not works in PSRemoteSession!

# Chocolatey

> @powershell -NoProfile -ExecutionPolicy Bypass -Command "iex ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1'))" && SET PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin
// By default, install to %systemdrive%\chocolatey\bin
> cinst -y neovim
OR
> Install-PackageProvider ChocolateyGet
> Install-Package -Name neovim -Provider ChocolateyGet

Set-Alias nvim C:\tools\neovim\Neovim\bin\nvim.exe


# .NET Core
@ref https://docs.microsoft.com/en-us/dotnet/core/tools/dotnet-install-script

> Invoke-WebRequest 'https://dot.net/v1/dotnet-install.ps1' -Proxy $env:HTTP_PROXY -ProxyUseDefaultCredentials -OutFile 'dotnet-install.ps1';
> ./dotnet-install.ps1 -InstallDir '~/.dotnet' -Version '2.2.300' -ProxyAddress $env:HTTP_PROXY -ProxyUseDefaultCredentials;
// -> C:\Users\Administrator\.dotnet\

> ./dotnet-install.ps1 -Channel LTS -InstallDir C:\DEV\dotnet									# Currently dotnet-sdk-2.1.604-win-x64.zip
> ./dotnet-install.ps1 -Runtime dotnet -Version 2.1.300 -InstallDir C:\DEV\dotnet-runtime		# 

> (gcm dotnet).Definition

> $oldPath = [System.Environment]::GetEnvironmentVariable("Path", "User")
> [System.Environment]::SetEnvironmentVariable("Path", $oldPath + ";C:\DEV\dotnet", "User")

> dotnet new -l
> dotnet new web
> dotnet run

NOTE:
> New-NetFirewallRule -DisplayName "Allow Web 5000" -Direction inbound -LocalPort 5000 -Protocol TCP -Action Allow
OR
> Set-NetFirewallProfile -Profile Domain,Public,Private -Enabled False

# Install Node.js

choco list -lo
choco search nvm
choco install nvm -y
// !!! Not work without -y in PSRemoteSession
RefreshEnv
nvm list available
nvm install 10.16.0
nvm use 10.16.0

node --version
npm --version

choco install yarn -y
npm install -g vue-cli
choco install git -y
vue init nuxt-community/starter-template myvue01		# FAILED!!! Becoz of tty. Maybe will be fixed in PowerShell 6.0 Plan #3046
cd myvue01
npm install   # Or yarn
vim nuxt.config.js
	export default {
	  server: { port: 3333, host: '0.0.0.0'}, // その他の設定
	}
npm run dev


> dotnet new angular -l
> dotnet new angular
> dotnet run


# Install IIS
```ps1
Set-ExecutionPolicy Bypass -Scope Process

# To list all Windows Features: dism /online /Get-Features
# Get-WindowsOptionalFeature -Online 
# LIST All IIS FEATURES: 
# Get-WindowsOptionalFeature -Online | where FeatureName -like 'IIS-*'

Enable-WindowsOptionalFeature -Online -FeatureName IIS-WebServerRole
Enable-WindowsOptionalFeature -Online -FeatureName IIS-WebServer
Enable-WindowsOptionalFeature -Online -FeatureName IIS-CommonHttpFeatures
Enable-WindowsOptionalFeature -Online -FeatureName IIS-HttpErrors
Enable-WindowsOptionalFeature -Online -FeatureName IIS-HttpRedirect
Enable-WindowsOptionalFeature -Online -FeatureName IIS-ApplicationDevelopment

Enable-WindowsOptionalFeature -online -FeatureName NetFx4Extended-ASPNET45
Enable-WindowsOptionalFeature -Online -FeatureName IIS-NetFxExtensibility45

Enable-WindowsOptionalFeature -Online -FeatureName IIS-HealthAndDiagnostics
Enable-WindowsOptionalFeature -Online -FeatureName IIS-HttpLogging
Enable-WindowsOptionalFeature -Online -FeatureName IIS-LoggingLibraries
Enable-WindowsOptionalFeature -Online -FeatureName IIS-RequestMonitor
Enable-WindowsOptionalFeature -Online -FeatureName IIS-HttpTracing
Enable-WindowsOptionalFeature -Online -FeatureName IIS-Security
Enable-WindowsOptionalFeature -Online -FeatureName IIS-RequestFiltering
Enable-WindowsOptionalFeature -Online -FeatureName IIS-Performance
Enable-WindowsOptionalFeature -Online -FeatureName IIS-WebServerManagementTools
Enable-WindowsOptionalFeature -Online -FeatureName IIS-IIS6ManagementCompatibility
Enable-WindowsOptionalFeature -Online -FeatureName IIS-Metabase
Enable-WindowsOptionalFeature -Online -FeatureName IIS-ManagementConsole
Enable-WindowsOptionalFeature -Online -FeatureName IIS-BasicAuthentication
Enable-WindowsOptionalFeature -Online -FeatureName IIS-WindowsAuthentication
Enable-WindowsOptionalFeature -Online -FeatureName IIS-StaticContent
Enable-WindowsOptionalFeature -Online -FeatureName IIS-DefaultDocument
Enable-WindowsOptionalFeature -Online -FeatureName IIS-WebSockets
Enable-WindowsOptionalFeature -Online -FeatureName IIS-ApplicationInit
Enable-WindowsOptionalFeature -Online -FeatureName IIS-ISAPIExtensions
Enable-WindowsOptionalFeature -Online -FeatureName IIS-ISAPIFilter
Enable-WindowsOptionalFeature -Online -FeatureName IIS-HttpCompressionStatic

Enable-WindowsOptionalFeature -Online -FeatureName IIS-ASPNET45

# If you need classic ASP (not recommended)
#Enable-WindowsOptionalFeature -Online -FeatureName IIS-ASP


# The following optional components require 
# Chocolatey OR Web Platform Installer to install


# Install UrlRewrite Module for Extensionless Urls (optional)
###  & "C:\Program Files\Microsoft\Web Platform Installer\WebpiCmd-x64.exe" /install /Products:UrlRewrite2 /AcceptEULA /SuppressPostFinish
#choco install urlrewrite -y
    
# Install WebDeploy for Deploying to IIS (optional)
### & "C:\Program Files\Microsoft\Web Platform Installer\WebpiCmd-x64.exe" /install /Products:WDeployNoSMO /AcceptEULA /SuppressPostFinish
# choco install webdeploy -y

# Disable Loopback Check on a Server - to get around no local Logins on Windows Server
# New-ItemProperty HKLM:\System\CurrentControlSet\Control\Lsa -Name "DisableLoopbackCheck" -Value "1" -PropertyType dword
```

OR Just simply:
> Get-WindowsFeature -Name Web-Server | Format-List -Property *
> Get-WindowsFeature -Name Web-*
> Install-WindowsFeature -name Web-Server -IncludeManagementTools
OR
> Install-WindowsFeature Web-Server -IncludeAllSubFeature???

Server ManagerからIIS Managerを立ち上げて
> $IIS = New-Object Microsoft.Web.Administration.ServerManager
> Foreach ( $site in $IIS.Sites ){
	$site.Name
}
=> NOT WORKS!

Import-Module WebAdministration
New-WebAppPool -name "NewWebSiteAppPool" -force
$appPool = Get-Item -name "NewWebSiteAppPool"
$appPool.processModel.identityType = "NetworkService"
$appPool.enable32BitAppOnWin64 = 1
$appPool | Set-Item
=> NOT WORKS!

Import-Module WebAdministration
Get-ItemProperty -Path 'IIS:\Sites\*'
cd $Env:SystemDrive\inetpub\wwwroot
OR
cd iis:\; ls

Set-ItemProperty -Path 'IIS:\Sites\Default Web Site\sampleDir' -Name physicalPath -Value C:\inetpub\sample2

@ref https://weblog.west-wind.com/posts/2017/may/25/automating-iis-feature-installation-with-powershell
@ref https://docs.microsoft.com/en-us/iis/get-started/whats-new-in-iis-10/iisadministration-powershell-cmdlets
@ref https://weblog.west-wind.com/posts/2019/Mar/16/ASPNET-Core-Hosting-on-IIS-with-ASPNET-Core-22

## WebPI
@ref http://www.iis.net/learn/install/web-platform-installer/web-platform-installer-v4-command-line-webpicmdexe-rtw-release
Invoke-WebRequest "http://download.microsoft.com/download/7/0/4/704CEB4C-9F42-4962-A2B0-5C84B0682C7A/WebPlatformInstaller_amd64_en-US.msi" -OutFile "C:¥WebPI.msi"
C:¥WebPI.msi /quiet
cd 'C:¥Program Files¥Microsoft¥Web Platform Installer'
.¥WebpiCmd.exe /List /ListOption:All
.¥WebpiCmd.exe /Install /Products:WHP_Recommended
.¥WebpiCmd.exe /Install /Products:WHP_Recommended /AcceptEula



# Desktop
> Install-WindowsFeature Desktop-Experience

