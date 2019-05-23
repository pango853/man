

PS> Install-PackageProvider -Name NuGet -Force

PS> Find-Module -Name パッケージ名 -Repository PSGallery

PS> Install-Script -Name install-kubectl 

PS> Save-Module パッケージ名 -Path "保存先フォルダパス" #あるいは Save-Script
PS> Install-Module パッケージ名 #あるいは Install-Script

PS> Get-InstalledModule
