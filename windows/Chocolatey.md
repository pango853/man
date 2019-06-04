
> @"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoProfile -InputFormat None -ExecutionPolicy Bypass -Command "iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))" && SET "PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin"

move %ALLUSERSPROFILE%\chocolatey D:\DEV\



cmd>
	@"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoProfile -InputFormat None -ExecutionPolicy Bypass -Command "iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))"
	//&&
	//SET "PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin"

move C:\ProgramData\chocolatey D:\DEV\



> choco install cmder
The Cmder package shines “big time” because it installs for us a portable release of the latest Git for Windows tools (https://git-for-windows.github.io). 
And which contains the openssl.

Create the Root CA private key ## ref> https://www.openssl.org/docs/manmaster/apps/genrsa.html
> openssl genrsa -out myRootCA.key 4096

Generate the Root CA certificate signed with the private key ## ref> https://www.openssl.org/docs/manmaster/apps/req.html
> openssl req -x509 -new -nodes -key myRootCA.key -days 3650 -out myRootCA.pem
	# Country Name (2 letter code) [AU]:AU
	# State or Province Name (full name) [Some-State]:NSW
	# Locality Name (eg, city) []:Sydney
	# Organization Name (eg, company) [Internet Widgits Pty Ltd]: MY-DEV-CA
	# Organizational Unit Name (eg, section) []: dev
	# Common Name (eg, YOUR name) []: my-dev-ca
	# Email Address []: my@email.com

Pacakge your public and private key in a pkcs12 encripted file (to install with certmgr on windows) ## ref> https://www.openssl.org/docs/manmaster/apps/pkcs12.html
> openssl pkcs12 -export -inkey myRootCA.key -in myRootCA.pem -out myRootCA.pfx 
