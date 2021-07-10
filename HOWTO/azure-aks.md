

Cloud Shell
	az aks get-credentials --resource-group myResourceGroup --name myAKSCluster

kubectl get nodes
```azure-vote.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: azure-vote-back
spec:
  replicas: 1
  selector:
    matchLabels:
      app: azure-vote-back
  template:
    metadata:
      labels:
        app: azure-vote-back
    spec:
      nodeSelector:
        "beta.kubernetes.io/os": linux
      containers:
      - name: azure-vote-back
        image: redis
        resources:
          requests:
            cpu: 100m
            memory: 128Mi
          limits:
            cpu: 250m
            memory: 256Mi
        ports:
        - containerPort: 6379
          name: redis
---
apiVersion: v1
kind: Service
metadata:
  name: azure-vote-back
spec:
  ports:
  - port: 6379
  selector:
    app: azure-vote-back
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: azure-vote-front
spec:
  replicas: 1
  selector:
    matchLabels:
      app: azure-vote-front
  template:
    metadata:
      labels:
        app: azure-vote-front
    spec:
      nodeSelector:
        "beta.kubernetes.io/os": linux
      containers:
      - name: azure-vote-front
        image: microsoft/azure-vote-front:v1
        resources:
          requests:
            cpu: 100m
            memory: 128Mi
          limits:
            cpu: 250m
            memory: 256Mi
        ports:
        - containerPort: 80
        env:
        - name: REDIS
          value: "azure-vote-back"
---
apiVersion: v1
kind: Service
metadata:
  name: azure-vote-front
spec:
  type: LoadBalancer
  ports:
  - port: 80
  selector:
    app: azure-vote-front

```

kubectl apply -f azure-vote.yaml
kubectl get service azure-vote-front --watch

az aks show --resource-group myResourceGroup --name myAKSCluster --query kubernetesVersion --output table
AKS cluster version < 1.10 
	kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/download/v0.3.6/components.yaml

kubectl autoscale deployment azure-vote-front --cpu-percent=50 --min=3 --max=10
OR
```yml
resources:
  requests:
     cpu: 250m
  limits:
     cpu: 500m
```
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
az aks scale --resource-group myResourceGroup --name myAKSCluster --node-count 1






git clone https://github.com/Azure-Samples/azure-voting-app-redis.git
cd azure-voting-app-redis
docker-compose up -d
docker ps

az group create --name myResourceGroup --location eastus
az acr create --resource-group myResourceGroup --name <acrName> --sku Basic
az acr login --name <acrName>

docker images
az acr list --resource-group myResourceGroup --query "[].{acrLoginServer:loginServer}" --output table
docker tag azure-vote-front <acrLoginServer>/azure-vote-front:v1
docker push <acrLoginServer>/azure-vote-front:v1

az acr repository list --name <acrName> --output table
az acr repository show-tags --name <acrName> --repository azure-vote-front --output table


# AKS
az aks create \
    --resource-group myResourceGroup \
    --name myAKSCluster \
    --node-count 2 \
    --generate-ssh-keys \
    --attach-acr <acrName>
az aks install-cli
az aks get-credentials --resource-group myResourceGroup --name myAKSCluster

az group delete --name myResourceGroup --yes --no-wait

# Update an App

vi azure-vote/azure-vote/config_file.cfg
docker-compose up --build -d

az acr list --resource-group myResourceGroup --query "[].{acrLoginServer:loginServer}" --output table
docker tag azure-vote-front <acrLoginServer>/azure-vote-front:v2
docker push <acrLoginServer>/azure-vote-front:v2

kubectl get pods
kubectl scale --replicas=3 deployment/azure-vote-front
kubectl set image deployment azure-vote-front azure-vote-front=<acrLoginServer>/azure-vote-front:v2
kubectl get pods

kubectl get service azure-vote-front

# Kubernetes dashboard

kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.0.0/aio/deploy/recommended.yaml
kubectl proxy

az aks browse --resource-group myResourceGroup --name myAKSCluster
http://127.0.0.1:8001
http://127.0.0.1:8001/api/v1/namespaces/kube-system/services/https:kubernetes-dashboard:/proxy
http://127.0.0.1:8001/api/v1/namespaces/kube-system/services/kubernetes-dashboard:/proxy

az aks get-credentials -a --resource-group <RG_NAME> --name <CLUSTER_NAME>
OR
kubectl config view
	kubectl config view -o jsonpath='{.users[?(@.name == "clusterUser_<RESOURCE GROUP>_<AKS_NAME>")].user.auth-provider.config.access-token}'

+ CREATE > Create an app: nginx:1.15.5
Deployments > Edit "spec.replica" : 3
Replica Sets > choose nginx



TODO:
https://docs.microsoft.com/en-us/azure/aks/ssh
