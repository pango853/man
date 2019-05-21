
- https://helm.sh/

# Tutorials

## 

### Env
- virtualbox
- minikube
- kubectl

### Setup
$ brew cask install virtualbo
$ curl -Lo minikube https://storage.googleapis.com/minikube/releases/v0.12.2/minikube-darwin-amd64 && chmod +x minikube && sudo mv minikube /usr/local/bin/
$ brew install kubectl


$ minikube start
$ eval $(minikube docker-env)

Search Charts
$ helm search

View parameters
$ helm inspect stable/mysql

Config and start
```config.yaml
mysqlUser: user1
mysqlPassword: password1
```

$ helm install -f config.yaml stable/mysql
$ helm ls

$ kubectl get svc

```
$ kubectl run -i --tty ubuntu02 --image=ubuntu:16.04 --restart=Never -- bash -il
	# apt-get update; apt-get install -y mysql-client
	# mysql -h dealing-ladybug-mysql -u user1 -ppassword1
```

TODO: Create your own charts
https://github.com/kubernetes/helm/blob/master/docs/charts.md

