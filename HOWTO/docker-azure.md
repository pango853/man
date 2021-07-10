# CentOS 8.1

$ sudo dnf config-manager --add-repo=https://download.docker.com/linux/centos/docker-ce.repo
//sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo

dnf list docker-ce --showduplicates | sort -r
sudo dnf -y  install docker-ce --nobest

sudo yum install -y docker-ce docker-ce-cli containerd.io

sudo systemctl stop docker
sudo systemctl disable docker


# Azure Collaboration (Not Yet Available)

docker context azure-login
docker context aci-create groupa/az-dev
docker context use groupa/az-dev

docker run paulyuk/pythontcpgame:1.1


docker login azure
docker context create aci-westus aci --aci-subscription-id xxx --aci-resource-group yyy --aci-location westus
docker context
docker context use aci-westus
