
https://docs.microsoft.com/en-us/windows/wsl/install-win10

Enable-WindowsOptionalFeature -Online -FeatureName $("VirtualMachinePlatform", "Microsoft-Windows-Subsystem-Linux")
dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart

wsl -l -v

Install Linux kernel update package
https://wslstorestorage.blob.core.windows.net/wslblob/wsl_update_x64.msi
wsl --set-default-version 2


wsl --list --all
wsl --set-version Ubuntu-18.04 2
wsl --set-default Ubuntu-18.04 2
wsl --import <Distro> <InstallLocation> <FileName>
wsl --unregister <Distro>


Invoke-WebRequest -Uri https://aka.ms/wslubuntu2004 -OutFile Ubuntu.appx -UseBasicParsing
Or: https://aka.ms/wsl-ubuntu-1804
Add-AppxPackage .\app_name.appx

wsl --install -d "Ubuntu 20.04 LTS"

Alpine WSL





docker run --name my-redis-container -d redis 
docker run --name my-redis-application --link my-redis-container:redis -d centos
docker run -it --name my-redis-cli --link my-redis-container:redis --rm redis redis-cli -h redis -p 6379

docker run -d -p 6379:6379 --name redis1 redis
docker ps
docker logs redis1
docker exec -it redis1 sh
	# redis-cli
		> ping
		> set name mark
		> get name
		> incr counter
		> incr counter
		> get counter
docker run -it --rm --link redis1:redis --name client1 redis sh
	# redis-cli -h redis
		> get name
		> get counter


docker info

	store Enabled: false

	WARNING: No blkio weight support
	WARNING: No blkio weight_device support
	WARNING: No blkio throttle.read_bps_device support
	WARNING: No blkio throttle.write_bps_device support
	WARNING: No blkio throttle.read_iops_device support
	WARNING: No blkio throttle.write_iops_device support


