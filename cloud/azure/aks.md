
az login
az account set --subscription "SUBSCRIPTION-NAME"


# Prepare container registry
az group create --name myResourceGroup --location eastus
az acr create --resource-group myResourceGroup --name <acrName> --sku Basic
az acr login --name <acrName>
docker images
az acr list --resource-group myResourceGroup --query "[].{acrLoginServer:loginServer}" --output table

docker tag azure-vote-front <acrLoginServer>/azure-vote-front:v1
docker push <acrLoginServer>/azure-vote-front:v1

az acr repository list --name <acrName> --output table
az acr repository show-tags --name <acrName> --repository azure-vote-front --output table



# Create a Cluster
az group create --name myResourceGroup --location eastus
//az aks create --name myAKSCluster --resource-group myResourceGroup --node-count 3 --generate-ssh-keys
az aks create \
    --resource-group myResourceGroup \
    --name myAKSCluster \
    --node-count 2 \
    --generate-ssh-keys \
    --attach-acr <acrName>
	@see https://docs.microsoft.com/en-us/azure/aks/cluster-container-registry-integration

az aks install-cli
az aks get-credentials --resource-group myResourceGroup --name myAKSCluster
kubectl get nodes

# Deploy an Application
git clone https://github.com/Azure-Samples/azure-voting-app-redis.git

az acr list --resource-group myResourceGroup --query "[].{acrLoginServer:loginServer}" --output table
vi azure-vote-all-in-one-redis.yaml
```azure-vote-all-in-one-redis.yaml
containers:
- name: azure-vote-front
  image: microsoft/azure-vote-front:v1
```
Or
```
containers:
- name: azure-vote-front
  image: <acrName>.azurecr.io/azure-vote-front:v1

```

kubectl apply -f azure-vote-all-in-one-redis.yaml

kubectl get service azure-vote-front --watch

curl http://<EXTERNAL-IP>


# Scaling
kubectl get pods
kubectl scale --replicas=5 deployment/azure-vote-front
az aks show --resource-group myResourceGroup --name myAKSCluster --query kubernetesVersion --output table

//kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/download/v0.3.6/components.yaml

```azure-vote-all-in-one-redis.yaml
resources:
  requests:
     cpu: 250m
  limits:
     cpu: 500m
```
OR
kubectl autoscale deployment azure-vote-front --cpu-percent=50 --min=3 --max=10
OR
```azure-vote-hpa.yaml
apiVersion: autoscaling/v1
kind: HorizontalPodAutoscaler
metadata:
  name: azure-vote-back-hpa
spec:
  maxReplicas: 10 # define max replica count
  minReplicas: 3  # define min replica count
  scaleTargetRef:
    apiVersion: apps/v1
    kind: Deployment
    name: azure-vote-back
  targetCPUUtilizationPercentage: 50 # target CPU utilization

---

apiVersion: autoscaling/v1
kind: HorizontalPodAutoscaler
metadata:
  name: azure-vote-front-hpa
spec:
  maxReplicas: 10 # define max replica count
  minReplicas: 3  # define min replica count
  scaleTargetRef:
    apiVersion: apps/v1
    kind: Deployment
    name: azure-vote-front
  targetCPUUtilizationPercentage: 50 # target CPU utilization
```
kubectl apply -f azure-vote-hpa.yaml

kubectl get hpa

az aks scale --resource-group myResourceGroup --name myAKSCluster --node-count 3


# Update a Application
vi azure-vote/azure-vote/config_file.cfg
```
# UI Configurations
TITLE = 'Azure Voting App'
VOTE1VALUE = 'Blue'
VOTE2VALUE = 'Purple'
SHOWHOST = 'false'
```
docker-compose up --build -d
curl http://localhost:8080
az acr list --resource-group myResourceGroup --query "[].{acrLoginServer:loginServer}" --output table
docker tag azure-vote-front <acrLoginServer>/azure-vote-front:v2
docker push <acrLoginServer>/azure-vote-front:v2

kubectl get pods
kubectl scale --replicas=3 deployment/azure-vote-front
kubectl set image deployment azure-vote-front azure-vote-front=<acrLoginServer>/azure-vote-front:v2

kubectl get pods
kubectl get service azure-vote-front


# Upgrade kubernetes
az aks get-upgrades --resource-group myResourceGroup --name myAKSCluster
az aks upgrade \
    --resource-group myResourceGroup \
    --name myAKSCluster \
    --kubernetes-version KUBERNETES_VERSION
az aks show --resource-group myResourceGroup --name myAKSCluster --output table


# Delete a Cluster
az group delete --name myResourceGroup --yes --no-wait


