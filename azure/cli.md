

# Installation

## Windows

MSI <https://aka.ms/installazurecliwindows> OR install on WSL.

## apt
sudo apt-get update
sudo apt-get install curl apt-transport-https lsb-release gpg
curl -sL https://packages.microsoft.com/keys/microsoft.asc | \
    gpg --dearmor | \
    sudo tee /etc/apt/trusted.gpg.d/microsoft.asc.gpg > /dev/null
AZ_REPO=$(lsb_release -cs)
echo "deb [arch=amd64] https://packages.microsoft.com/repos/azure-cli/ $AZ_REPO main" | \
    sudo tee /etc/apt/sources.list.d/azure-cli.list
sudo apt-get update
sudo apt-get install azure-cli

OR

apt-get update
apt-get upgrade

apt-get install build-essential
apt-get install libncurses5-dev libgdbm-dev libnss3-dev libssl-dev libreadline-dev libffi-dev zlib1g-dev

cd /usr/src
wget https://www.python.org/ftp/python/3.7.3/Python-3.7.3.tgz
sudo tar xzf Python-3.7.3.tgz
cd Python-3.7.3

sudo ./configure --enable-optimizations
sudo make altinstall
python3.7 -V

sudo apt-get install libffi6 openssl

curl -L https://aka.ms/InstallAzureCli | bash

export PATH=$PATH:$HOME/bin

## yum

...TODO...

## Docker

> docker run -it microsoft/azure-cli
> docker run -it -v ${HOME}/.ssh:/root/.ssh microsoft/azure-cli


# Login

> az login

> read -sp "Azure password: " AZ_PASS && echo && az login -u <username> -p $AZ_PASS


> $AzCred = Get-Credential -UserName <username>
> az login -u $AzCred.UserName -p $AzCred.GetNetworkCredential().Password


> az login --service-principal -u <app-url> -p <password-or-cert> --tenant <tenant>

> az account list
> az account set <サブスクリプションName> or <サブスクリプションID>

> az vm list
> az vm start --resource-group myResourceGroup --name myVM
> az vm stop --resource-group myResourceGroup --name myVM


> az vm list-ip-addresses -n myVM --query [0].virtualMachine.network.publicIpAddresses[0].ipAddress -o tsv
> az network public-ip list
