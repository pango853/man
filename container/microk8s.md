

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


# CentOS

sudo yum install epel-release
sudo yum install snapd
sudo systemctl enable --now snapd.socket
sudo ln -s /var/lib/snapd/snap /snap

sudo systemctl enable --now snapd.socket
sudo systemctl restart snapd.socket	???

sudo snap info microk8s
!IMPORTANT!: Do not prepend sudo to the snapdinstallation commands. 
snap install microk8s --classic
snap install microk8s --classic --channel=1.18/stable


sudo usermod -a -G microk8s $USER
sudo chown -f -R $USER ~/.kube
su - $USER
microk8s status --wait-ready



kubectl create deployment nginx --image=nginx
microk8s.kubectl run nginx --replicas 2 --image nginx
kubectl get deployments
kubectl get pods
kubectl get all --all-namespaces

microk8s.kubectl expose deployment nginx --port 80 --target-port 80 --type ClusterIP --selector=run=nginx --name nginx
microk8s.kubectl get services
microk8s.kubectl delete deployment nginx
microk8s.kubectl delete service nginx



microk8s kubectl get nodes
microk8s kubectl get services

echo "alias kubectl='microk8s.kubectl'" >>~/.bashrc
source ~/.bashrc
OR
~/.bash_aliases
	alias kubectl='microk8s kubectl'
OR
sudo snap alias microk8s.kubectl kubectl
microk8s.enable ingress
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/nginx-0.30.0/deploy/static/mandatory.yaml

```deployment.yml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: personal-website-deployment
  labels:
    uri: example.com
spec:
  selector:
    matchLabels:
      uri: example.com
  template:
    metadata:
      labels:
        uri: example.com
    spec:
      containers:
        - name: personal-website
          image: heroku/nodejs-hello-world
          ports:
            - containerPort: 5000
```
```service.yml
apiVersion: v1
kind: Service
metadata:
  name: personal-website-service
spec:
  selector:
    uri: example.com
  type: ClusterIP
  ports:
    - name: http
      protocol: TCP
      port: 80
      targetPort: 5000
```
```ingress.yml
apiVersion: networking.k8s.io/v1beta1
kind: Ingress
metadata:
  name: personal-website-ingress
  annotations:
    nginx.ingress.kubernetes.io/rewrite-target: /
spec:
  rules:
    - host: example.com
      http:
        paths:
          - backend:
              serviceName: personal-website-service
              servicePort: 80
```
kubectl create -f deployment.yml -f service.yml -f ingress.yml



microk8s kubectl create deployment
microk8s enable dns storage

microk8s stop
microk8s start


microk8s.kubectl cluster-info
microk8s.kubectl get nodes
kubectl  get nodes -o wide
microk8s.config
microk8s.status
microk8s.enable dns
microk8s.enable dashboard dns				curl https://CLUSTER_IP/ to see the dashboard
microk8s.enable storage
microk8s.enable istio
microk8s.status
microk8s.kubectl config current-context
sudo snap alias microk8s.kubectl kubectl


docker save fluentd-node-sample:latest > fluentd-node-sample.tar
microk8s.ctr -n k8s.io image import ./fluentd-node-sample.tar
microk8s.ctr -n k8s.io images ls | grep sample

```node-deployment.yaml
apiVersion: extensions/v1beta1
kind: Deployment
metadata:
  name: node
  labels:
    name: node
spec:
  replicas: 1
  template:
    metadata:
      labels:
        app: node
    spec:
      containers:
      - name: node
        image: fluentd-node-sample:latest
        imagePullPolicy: IfNotPresent
```
kubectl apply -f node-deployment.yaml

kubectl  get pod --all-namespaces -w


microk8s.reset
sudo snap remove microk8s



# Local Docker Registry

docker build -t localhost:32000/myimagename /path/to/dockerfile
docker push localhost:32000/myimagename

List image:
	REPO_URL=localhost:32000
	curl -k -s -X GET http://$REPO_URL/v2/_catalog \
	 | jq '.repositories[]'
	 | sort \
	 | xargs -I _ curl -s -k -X GET http://$REPO_URL/v2/_/tags/list
 

