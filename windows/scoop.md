
# Installation

```powershell

	Set-ExecutionPolicy RemoteSigned -scope CurrentUser

	$env:SCOOP='D:\DEV\Scoop'
	[Environment]::SetEnvironmentVariable('SCOOP', $env:SCOOP, 'User')
	$env:SCOOP_GLOBAL='D:\DEV\Scoop\GlobalScoopApps'
	[Environment]::SetEnvironmentVariable('SCOOP_GLOBAL', $env:SCOOP_GLOBAL, 'Machine')

	Invoke-Expression (New-Object System.Net.WebClient).DownloadString('https://get.scoop.sh')

	# or shorter
	iex (new-object net.webclient).downloadstring('https://get.scoop.sh')
	# or
	iwr -useb get.scoop.sh | iex
```

# Usage

```powershell
	scoop install <Package Name>
	scoop search <Keyword>
	scoop help

	scoop list
```

# Extras

```powershell
	scoop bucket add extras
```