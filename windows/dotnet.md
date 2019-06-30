
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

# Compile
> C:\Windows\Microsoft.NET\Framework\v3.5\csc.exe /reference:System.Data.SQLite.dll /platform:x86 /target:winexe MyProgram.cs


# Tools
- .NET Portability Analyzer
  https://marketplace.visualstudio.com/items?itemName=ConnieYau.NETPortabilityAnalyzer
  @ref https://blogs.msdn.microsoft.com/appconsult/2018/10/29/move-your-first-steps-with-net-core-3-0-for-desktop-development/
- .NET API analyzer (Microsoft.DotNet.Analyzers.Compatibility)
  https://docs.microsoft.com/en-us/dotnet/standard/analyzers/api-analyzer
- Convert your old project files to the new 2017 format
  https://github.com/hvanbakel/CsprojToVs2017


# TODO
- https://docs.microsoft.com/en-us/previous-versions/msp-n-p/ee817674(v=pandp.10)
- https://docs.microsoft.com/en-us/dotnet/api/system.windows.application.startup?view=netframework-4.8
