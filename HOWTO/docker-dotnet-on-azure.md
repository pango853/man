
# Create VM and Login via SSH

# Ubuntu 18

lsb_release -a

sudo apt update
sudo apt install apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable"

sudo apt update
apt-cache policy docker-ce
sudo apt install docker-ce


sudo systemctl status docker
sudo usermod -aG docker ${USER}
su - ${USER}
id -nG

docker info

# Create Group
sudo addgroup --gid 888 developer
sudo usermod -g developer ${USER}
sudo chgrp -R developer "$HOME"
sudo delgroup ${USER}

# Create Users
for i in userA userB userC userD; do \
sudo useradd -m -g developer -G developer,docker "$i"; done

for i in userA userB userC userD; do \
sudo su "$i"; done

ssh-keygen -o -a 100 -t ed25519 -f ~/.ssh/etikas-shared_ed25519 -C "Welcome to AZ! This SSH key is shared by your team so please consider update it to your own key."
for i in userA userB userC userD; do \
sudo mkdir -pv /home/$i/.ssh/; sudo chown 700 /home/$i/.ssh/; \
sudo cp ~/.ssh/etikas-shared_ed25519 /home/$i/.ssh/authorized_keys; \
sudo chmod 400 /home/$i/.ssh/authorized_keys; \
done


# Install dotnet

wget -q https://packages.microsoft.com/config/ubuntu/18.04/packages-microsoft-prod.deb
sudo dpkg -i packages-microsoft-prod.deb

sudo add-apt-repository universe
sudo apt-get install apt-transport-https

sudo apt-get update
apt search dotnet
apt-cache search dotnet
sudo apt-get install dotnet-sdk-3.1

dotnet new console -o HelloWorld
cd HelloWorld
```Program.cs
using System;

namespace HelloWorld
{
	class Program
	{
		static void Main(string[] args)
		{
			Console.WriteLine("Hello World!");
		}
	}
}
```
dotnet run


# dotnet API

<https://docs.microsoft.com/en-us/aspnet/core/tutorials/first-web-api?view=aspnetcore-3.1&tabs=visual-studio>

dotnet new webapi -o TodoApi
//dotnet new webapi -o TodoApi --no-https
cd TodoApi
dotnet add package Microsoft.EntityFrameworkCore.SqlServer
dotnet add package Microsoft.EntityFrameworkCore.InMemory
//code -r ../TodoApi

dotnet run
curl https://localhost:5001/WeatherForecast
curl http://localhost:5000/WeatherForecast


curl http://localhost:5000/api/Todoitems

