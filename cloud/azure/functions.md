
@ref https://docs.microsoft.com/en-us/azure/azure-functions/

# Installations

## .NET Core 2.x SDK for Debian

```
	wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.asc.gpg
	sudo cp microsoft.asc.gpg /etc/apt/trusted.gpg.d/
	wget -q https://packages.microsoft.com/config/debian/9/prod.list
	sudo cp prod.list /etc/apt/sources.list.d/microsoft-prod.list
```
OR
```
	sudo apt-get install lsb-release

	curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
	sudo mv microsoft.gpg /etc/apt/trusted.gpg.d/microsoft.gpg

	sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/microsoft-debian-$(lsb_release -cs)-prod $(lsb_release -cs) main" > /etc/apt/sources.list.d/dotnetdev.list'
	sudo apt-get update
```

```
	sudo apt-get install apt-transport-https
	sudo apt-get update
	sudo apt-get install dotnet-sdk-2.2
```

## Azure Functions Core Tools with APT

First add apt source as `## .NET Core 2.x SDK for Debian`.

```
	sudo apt-get install azure-functions-core-tools
```

# Tutorials


## Work with Azure Functions Core Tools

1. First install `## Azure Functions Core Tools with APT`.
```
	func init MyFunctionProj

	
	After you have updated your function.json file, run
	func extensions install

	Install before updating function.josn. Valid versions are listed on https://nuget.org/.
	func extensions install --package Microsoft.Azure.WebJobs.ServiceBus --version 3.0.0-beta8
```

If you are using Node.js for language.
```
	curl -sL https://deb.nodesource.com/setup_10.x | sudo -E bash -
	OR
	curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -
	sudo apt-get install nodejs

	curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.34.0/install.sh | bash
	command -v nvm
	nvm install node
	nvm install v10.15.3	# Dubnium
	nvm install v8.15.1	# Carbon
	nvm use v 8.15.1
```
2. Get your storage connection strings.

> Azure portal > Storage accounts > select storage account > Settings: Access keys > copy Connection string

OR

> Azure Storage Explorer > Explorer > expand your subscription > select your storage account > copy the primary or secondary connection string

Azure Storage Explorer: https://storageexplorer.com/

OR

func azure functionapp fetch-app-settings <FunctionAppName>
func azure storage fetch-connection-string <StorageAccountName>

3. Create a function.
func new
OR
func new --template "Azure Queue Storage trigger" --name MyQueueTrigger
func new --template "Http trigger" --name MyHttpTrigger


## Create function - Python

- REF: https://docs.microsoft.com/en-us/azure/azure-functions/functions-run-local#v2
- REF: https://docs.microsoft.com/en-us/azure/azure-functions/functions-create-first-function-python

### Prerequisites
python3.7 -m venv py-az-env
source py-az-env/bin/activate

    Install Azure Functions Core Tools version 2.2.70 or later (requires .NET Core 2.x SDK).

To publish and run in Azure:

    Install the Azure CLI version 2.x or later.

    You need an active Azure subscription.

    If you don't have an Azure subscription, create a free account before you begin.



func init MyFunctionProj

# In Bash
python3.6 -m venv .env
source .env/bin/activate

# In PowerShell
py -3.6 -m venv .env
.env\scripts\activate
