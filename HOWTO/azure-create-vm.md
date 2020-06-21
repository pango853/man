
az account show
az account list-locations --output table
az configure --defaults location=XXXXXXXXXX

az group create --tags type=poc pj=MYPROJECT --location=XXXXXX --name PREFIX-PURPOSE
az configure --defaults group=PREFIX-PURPOSE

az configure --list-defaults


az vm image list -f CentOS
az vm image list -f windows-7 --all
az vm image list -p microsoftwindowsdesktop --all --output table

az vm create \
    --resource-group PREFIX-PURPOSE \
    --name my-win7 \
	--size Standard_DS2_v2 \
    --image win7-enterprise \
    --admin-username azureuser
az vm create \
    --resource-group PREFIX-PURPOSE \
    --name my-win10 \
	--size Standard_DS2_v2 \
    --image MicrosoftWindowsDesktop:Windows-10:19h2-pron-g2:18363.778.2004101604 \
	--auto-shutdown "UTC+10:00" 24 19:00:00 \
    --admin-username azureuser


az vm create \
    --resource-group PREFIX-PURPOSE \
    --name my-centos7 \
	--size Standard_B1ms \
    --image OpenLogic:CentOS:7.5:latest \
    --admin-username azureuser



az vm list --output table
az vm list-ip-addresses
az vm list-sizes


az group delete --name PREFIX-PURPOSE
