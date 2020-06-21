

# Ubuntu 18.04
sudo apt update
sudo apt install snapd

sudo apt-get install docker.io
sudo snap install microk8s --classic
microk8s.enable dns dashboard registry

Disable localhost:32000 registry:
	microk8s.disable registry

Enabling “dashboard” to deploy the Kubernetes dashboard:
	???

Enabling the DNS addon to deploy Kube DNS Pod and Service on the cluster:
	???



microk8s.stop
microk8s.start

microk8s.kubectl get all --namespace kube-system

microk8s.kubectl get services --all-namespaces


curl https://YOURCLUSTERIP:443

# Local Docker Registry

docker build -t localhost:32000/myimagename /path/to/dockerfile
docker push localhost:32000/myimagename

List image:
	REPO_URL=localhost:32000
	curl -k -s -X GET http://$REPO_URL/v2/_catalog \
	 | jq '.repositories[]'
	 | sort \
	 | xargs -I _ curl -s -k -X GET http://$REPO_URL/v2/_/tags/list
 

