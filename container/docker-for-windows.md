
# Install methods
1. Docker for Windows installer. @ref https://gist.github.com/Jaykul/15a6982aad9b6197a537f1ce5a786723
   @ref https://docs.microsoft.com/ja-jp/virtualization/windowscontainers/quick-start/quick-start-windows-server
   @ref https://docs.docker.com/docker-for-windows/install/
2. 
3. Using DSC
4. *OPTIONAL* On Azure, https://github.com/Microsoft/Virtualization-Documentation/tree/master/windows-server-container-tools/containers-azure-template


# Install on Windows Server 2016 or above

## Install
```ps
> Install-Module -Name DockerMsftProvider -Repository PSGallery -Force
> Install-Package -Name docker -ProviderName DockerMsftProvider
> Restart-Computer -Force
```
OR
```ps
> Install-Script -Name Install-DockerOnWs2016UsingDSC
> Install-DockerOnWS2016UsingDSC.ps1
```

## Update
```ps
> Get-Package -Name Docker -ProviderName DockerMsftProvider
> Find-Package -Name Docker -ProviderName DockerMsftProvider
> Install-Package -Name Docker -ProviderName DockerMsftProvider -Update -Force
> Start-Service Docker
```

## Try it

> docker run microsoft/dotnet-samples:dotnetapp-nanoserver-1809

> powershell new-item c:\Build\Dockerfile -Force
> notepad c:\Build\Dockerfile
	FROM microsoft/iis
	RUN echo "Hello World - Dockerfile" > c:\inetpub\wwwroot\index.html
> docker build -t <user>/iis-dockerfile c:\Build
> docker images
> docker run -d -p 80:80 <user>/iis-dockerfile ping -t localhost
Access http://127.0.0.1

> docker ps
> docker stop <container name>
> docker rm <container name>

> docker login
> docker push <user>/iis-dockerfile
> docker rmi <user>/iis-dockerfile
> docker pull <user>/iis-dockerfile


> docker run --rm mcr.microsoft.com/dotnet/core/sdk:3.0 pwsh -c Write-Host "Hello Powershell"


### Build seme web app

TODO: docker run --rm -d --name dotnetapp microsoft/dotnet-samples:dotnetapp-nanoserver-1809 ping -t localhost
FAILED!!! See https://github.com/dotnet/dotnet-docker/tree/master/samples/dotnetapp

> docker run --rm -it mcr.microsoft.com/dotnet/core/sdk:3.0 pwsh


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

OR
$env:ASPNETCORE_URLS="http://*:5123" ; dotnet run	=> NOT work!
dotnet run --server.urls "http://*:5000"			=> NOT work!

    public class Program
    {
        public static void Main(string[] args)
        {
            //CreateWebHostBuilder(args).Build().Run();
            CreateWebHostBuilder(args).UseUrls("http://localhost:5050").Build().Run();
        }


notepad Pages/Index.cshtml
	@page
	@model IndexModel
	@{
		ViewData["Title"] = "Home page";
	}

	<h1>Hello, world!</h1>
	<p>The time on the server is @DateTime.Now</p>


TODO: Conterize this steps


**.NET Pet Shop 4**
http://download.microsoft.com/download/8/0/1/801ff297-aea6-46b9-8e11-810df5df1032/Microsoft%20.NET%20Pet%20Shop%204.0.msi
https://msdn.microsoft.com/en-us/library/aa479070.aspx
http://www.gotdotnet.com/team/compare/petshop.aspx


** Modern Apps **
- Visual Studio Tools for Docker と ASP.NET Core | Microsoft Docs
  https://docs.microsoft.com/ja-jp/...and-deploy/docker/visual-studio-tools-for-docker

- Visual Studio Tools for Windows 上の Docker | Microsoft Docs
  https://docs.microsoft.com/ja-jp/dotnet/standard/.../visual-studio-tools-for-docker

- Docker アプリの開発ワークフロー | Microsoft Docs
  https://docs.microsoft.com/ja-jp/.../docker.../docker-app-development-workflow
- Windows コンテナーへの ASP.NET MVC アプリケーションの移行 ...
  https://docs.microsoft.com/ja-jp/aspnet/mvc/overview/deployment/docker-aspnetmvc

- Visual Studio Tools for Docker - マイクロソフト系技術情報 Wiki
  https://techinfoofmicrosofttech.osscons.jp/index.php?Visual%20Studio%20Tools%20f...

- .NET Core App を Docker コンテナとして公開する - tech.guitarrapc.cóm
  https://tech.guitarrapc.com › .NETCore

- Visual Studio 2017 による ASP.NET Core アプリの Docker コンテナーの ...
https://qiita.com › C#

- https://docs.microsoft.com/ja-jp/visualstudio/ide/quickstart-aspnet-core?view=vs-2019


### docker-compose
TODO


## Images
- Windows Server 2019: microsoft/dotnet-samples:dotnetapp-nanoserver-1809
- Windows Server 2016: microsoft/dotnet-samples:dotnetapp-nanoserver-sac2016
- IIS: microsoft/iis
- mcr.microsoft.com/windows/nanoserver:1809

- docker run -it --rm -p 8000:80 --name aspnet_sample mcr.microsoft.com/dotnet/framework/samples:aspnetapp

- .NET Framework:
  - dotnet/framework/sdk: .NET Framework SDK
  - dotnet/framework/runtime: .NET Framework Runtime
  - dotnet/framework/wcf: Windows Communication Framework (WCF)
  - dotnet/framework/samples: .NET Framework, ASP.NET and WCF Samples
- .NET Core:
  - dotnet/core: .NET Core
  - dotnet/core-nightly: .NET Core (Preview)
  - dotnet/core/samples: .NET Core Samples
- Windows:
  - windows/servercore/iis: IIS images
- ASP.NET Core Runtime
  - mcr.microsoft.com/dotnet/core/aspnet

TODO:
microsoft/aspnet	microsoft	Microsoft IIS images	5M+	823
microsoft/aspnetcore	microsoft	Official images for running compiled ASP.NET Core applications.	10M+	600
microsoft/aspnetcore*

microsoft/dotnet	microsoft	Official images for .NET Core and ASP.NET Core for Linux and Windows Nano Server	10M+	1.4K
microsoft/dotnet-buildtools-prereqs	microsoft	Images for building the various components of the https://github.com/dotnet/ project.	5M+	17
microsoft/dotnet-framework	microsoft	Official images for running .NET Framework applications on Windows Server Core	5M+	247
microsoft/dotnet-framework-build	microsoft	The .NET Framework build images have moved to microsoft/dotnet-framework.	1M+	17
microsoft/dotnet-framework-samples	microsoft	.NET Framework Docker Samples	1M+	41
microsoft/dotnet-nightly	microsoft	Preview images for the .NET Core SDK	10M+	23
microsoft/dotnet-samples	microsoft	.NET Core Docker Samples	1M+	77


microsoft/iis	microsoft	Microsoft IIS images	10M+	360
microsoft/iis-insider	microsoft	Microsoft IIS Insider images	-	2

microsoft/java	microsoft		-	-
microsoft/java*

microsoft/mssql-monitoring*
microsoft/mssql-server*
microsoft/mssql-tools

microsoft/nanoserver*	microsoft	The official Nano Server base image	10M+	479
microsoft/powershell*
microsoft/wcf	microsoft	Microsoft WCF images	1M+	29
microsoft/windows	microsoft	The official Windows base image	9	7
microsoft/windowsiotcore	microsoft	The official Windows IoT Core base image	-	-
microsoft/windowsservercore	microsoft	The official Windows Server Core base image	10M+	653




# MISC
Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.201 -Force
Install-Module -Name DockerMsftProvider -Force
Install-Package -Name docker -ProviderName DockerMsftProvider -Force
Restart-Computer -Force


$ENV:PSModulePath
Install-PackageProvider Nuget –Force
Install-Module –Name PowerShellGet –Force
Install-Module -Name SqlServer

Get-Module -ListAvailable
Import-Module -Name PowerNet
Set-ExecutionPolicy Unrestricted
Set-ExecutionPolicy Restricted


Install without PSGallery
```ps
Install-Module -Name xPSDesiredStateConfiguration
Install-Module -Name xPendingReboot
Invoke-WebRequest -Uri 'https://gist.githubusercontent.com/PlagueHO/d9595cae1788f436b97bd4c90d50d72e/raw/1146baa2b1e0c8b3869004074b4c97bf71ce9c3c/Install-DockerOnWS2016ByDSC.ps1' -OutFile 'Install-DockerOnWS2016ByDSC.ps1'
.\Install-DockerOnWS2016ByDSC.ps1
```

# TODO

https://docs.microsoft.com/ja-jp/virtualization/windowscontainers/quick-start/quick-start-windows-10
https://blog.docker.com/2016/09/build-your-first-docker-windows-server-container/
https://www.outsystems.com/blog/posts/deploying-kubernetes-to-run-windows-containers/