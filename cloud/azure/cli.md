

# Installation

## Windows

MSI <https://aka.ms/installazurecliwindows> OR install on WSL.

## PowerShell
@ref https://docs.microsoft.com/en-us/powershell/azure/install-az-ps?view=azps-2.1.0

$PSVersionTable.PSVersion > 5.0
Install-Module -Name AzureRM -AllowClobber # OLD!

$PSVersionTable.PSVersion > 5.1
Install-Module -Name Az -AllowClobber
Install-Module -Name Az -AllowClobber -Scope CurrentUser
Install-Module -Name Az -AllowClobber -Force       # For update
(New-Object System.Net.WebClient).Proxy.Credentials = `
  [System.Net.CredentialCache]::DefaultNetworkCredentials

Get-Command -Verb Get -Noun AzVM* -Module Az.Compute

Connect-AzAccount


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

## CLI

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

# Usage and Quota/Limit
https://docs.microsoft.com/en-us/azure/virtual-machines/windows/quotas

> Get-AzVMUsage -Location "East US"




# Deployment

```azuredeploy.json
{
  "$schema": "https://schema.management.azure.com/schemas/2019-04-01/deploymentTemplate.json#",
  "contentVersion": "1.0.0.0",
  "resources": []
}
```

az deployment group create \
  --name blanktemplate \
  --resource-group myResourceGroup \
  --template-file azuredeploy.json

az deployment group create \
  --name blanktemplate \
  --resource-group myResourceGroup \
  --template-file azuredeploy.json \
  --parameters @params.json \
  --no-prompt --no-wait


az deployment group create --resource-group "chan-bom-demo" \
 --verbose --debug \
 --template-file "/tmp/ansible_file/azuredeploy-hdxx96.json" \
 --parameters @myparameters.json

az deployment group create --resource-group "chan-bom-demo" \
 --verbose --debug \
 --template-file "/tmp/ansible_file/azuredeploy-hdxx96.json" \
 --parameters \



# List VMs and their images
az vm list --query '[].{ Name:name, offer:storageProfile.imageReference.offer, publisher:storageProfile.imageReference.publisher, sku:storageProfile.imageReference.sku, version:storageProfile.imageReference.version}' -o table

