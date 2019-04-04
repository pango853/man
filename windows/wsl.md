
# Windows Subsystem for Linux Installation Guide for Windows 10

## Enable the Windows Subsystem for Linux (WSL)

Before installing any Linux distros for WSL, you must ensure that the "Windows Subsystem for Linux" optional feature is enabled:

> Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux

Restart your computer when prompted.

## Windows Server Installation Guide

First make sure WSL is enabled and you're running Windows build 16215 or later.

REF: https://docs.microsoft.com/en-us/windows/wsl/install-manual

> Invoke-WebRequest -Uri https://aka.ms/wsl-ubuntu-1604 -OutFile Ubuntu.appx -UseBasicParsing

REF: https://docs.microsoft.com/en-us/windows/wsl/troubleshooting#check-your-build-number
	- Ubuntu 18.04
	- Ubuntu 18.04 ARM
	- Ubuntu 16.04
	- Debian GNU/Linux
	- Kali Linux
	- OpenSUSE
	- SLES

> Rename-Item ~/Ubuntu.appx ~/Ubuntu.zip
> Expand-Archive ~/Ubuntu.zip ~/Ubuntu

> $userenv = [System.Environment]::GetEnvironmentVariable("Path", "User")
> [System.Environment]::SetEnvironmentVariable("PATH", $userenv + "C:\Users\Administrator\Ubuntu", "User")
