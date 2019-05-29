
https://dotnet.github.io/dotnet-web/docs/getting-started/installing-core-windows.html


@powershell -NoProfile -ExecutionPolicy unrestricted -Command "&{$Branch='dev';iex ((new-object net.webclient).DownloadString('https://raw.githubusercontent.com/aspnet/Home/dev/dnvminstall.ps1'))}"

dnvm install -r coreclr -arch x64 latest -u
dnvm list


# Tutorials

## Build a dotnet app

**dotnet**
Prereq:
    - Azure: Windows Server 2019 Datacenter with Containers
	- .NET Core SDK 2.1 or later

@powershell -NoProfile -ExecutionPolicy unrestricted -Command "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; &([scriptblock]::Create((Invoke-WebRequest -useb 'https://dot.net/v1/dotnet-install.ps1'))) ./dotnet-install.ps1 -Channel LTS
OR
Invoke-WebRequest -Uri 'https://dot.net/v1/dotnet-install.ps1' -OutFile dotnet-install.ps1
./dotnet-install.ps1 -Channel LTS
OR
https://dotnetcli.azureedge.net/dotnet/Sdk/2.1.604/dotnet-sdk-2.1.604-win-x64.zip

$Env:Path
Set-Item Env:Path "$Env:Path;$Env:UserProfile\AppData\Local\Microsoft\dotnet\"



dotnet new webApp -o myWebApp --no-https
cd webWebApp
dotnet run
http://localhost:5000

notepad Pages/Index.cshtml
	@page
	@model IndexModel
	@{
		ViewData["Title"] = "Home page";
	}

	<h1>Hello, world!</h1>
	<p>The time on the server is @DateTime.Now</p>
