
@ref https://docs.microsoft.com/en-us/virtualization/windowscontainers/about/

# Windows container types

- Windows Server Containers
  - with application isolation
  - containers shares a kernel with the container host and all containers running on the host
  - containers require the same kernel version and configuration
- Hyper-V Isolation
  - run a container in a highly optimized VM
  - the kernel of the container host is not shared with other containers on the same host
  - can run kernels with different versions and configurations


# Azure
- Azure Kubernetes Service (AKS)

- Service Fabric


# Kubernetes

https://docs.docker.com/docker-for-windows/install

kubernetesの有効化: Tray icon > Settings > Kubernetes > Enable Kubernetes


OR:
> @"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoProfile -InputFormat None -ExecutionPolicy Bypass -Command "iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))" && SET "PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin"
OR
PS> Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString(‘https://chocolatey.org/install.ps1'))
> choco install docker-for-windows -pre
> Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V -All

> kubectrl get nodes
> kubectl config view

> kubectl config get-contexts
> kubectl config use-context docker-for-desktop

OR:
https://kubernetes.io/docs/tasks/tools/install-kubectl/

https://storage.googleapis.com/kubernetes-release/release/stable.txt
curl -LO https://storage.googleapis.com/kubernetes-release/release/v1.14.0/bin/windows/amd64/kubectl.exe
kubectl version

OR:
Install-Script -Name install-kubectl 
//Install-Script -Name install-kubectl -Scope CurrentUser -Force install-kubectl.ps1 [-DownloadLocation <path>]



## Try commands
> kubectl cluster-info
> kubectl get node -o wide
> kubectl get pod -o wide --all-namespaces
> kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/master/src/deploy/recommended/kubernetes-dashboard.yaml
OR
> kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/master/src/deploy/alternative/kubernetes-dashboard.yaml
> kubectl proxy

http://localhost:8001/api/v1/namespaces/kube-system/services/https:kubernetes-dashboard:/proxy/


> kubectl run nginx — image nginx
> kubectl expose deployment nginx — port 80 — target-port 80 — name nginx/master/deploy/mandatory
> kubectl get pods


**Service Account 作成と、ClusterRoleのバインディング**
@ref https://github.com/kubernetes/dashboard/wiki/Creating-sample-user

```admin-user.yaml
apiVersion: v1
kind: ServiceAccount
metadata:
  name: admin-user
  namespace: kube-system
```

> kubectl apply -f .\admin-user.yaml

``` clusterrolebind.yaml
apiVersion: rbac.authorization.k8s.io/v1beta1
kind: ClusterRoleBinding
metadata:
  name: admin-user
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: ClusterRole
  name: cluster-admin
subjects:
- kind: ServiceAccount
  name: admin-user
  namespace: kube-system
```

> kubectl apply -f .\clusterrolebind.yaml

> kubectl -n kube-system describe secret admin-user-token-4pcz5




## Try deploying
> git clone -b openjdk11 https://github.com/h-r-k-matsumoto/spring-boot-sample.git
> cd spring-boot-sample
> mvn -Dgcp.project.name=sample-project  compile jib:dockerBuild

>docker images |findstr spring-boot
gcr.io/sample-project/spring-boot-sample   0.1.0-SNAPSHOT      4cc738f189da        46 seconds ago      997MB


変更前：imagePullPolicy: Always
変更後：imagePullPolicy: IfNotPresent

> kubectl apply -f kubernetesの有効化

http://localhost:30000/sample/hello


## Try Ingress also

Ingress Controllerの作成

kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/master/deploy/mandatory.yaml
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/master/deploy/provider/cloud-generic.yaml

Ingress作成

``` 040_ingress.yaml
apiVersion: extensions/v1beta1
kind: Ingress
metadata:
  name: samplelb
spec:
  backend:
    serviceName: spring-boot-sample
    servicePort: 30000
  rules:
  - http:
      paths:
      - path: /*
        backend:
          serviceName: spring-boot-sample
          servicePort: 30000
```
> kubectl apply -f kubernetes\040_ingress.yaml

> kubectl get ingress

http://localhost:30000/sample/hello



# Troubleshooting

- Kubernetes fails to start (hangs in starting phase)
  https://github.com/docker/for-win/issues/1962

  1. firewallのoutboundルール追加: Allow %ProgramFiles%\Docker\Docker\resources\vpnkit.exe
  2. Remove ~/.kube
  3. Tray icon > Settings > Reset > Reset to factory defaults
  4. (OPTIONAL) Tray icon > Settings > General > check Expose daemon on tcp://localhost:2375 without TLS
  5. (OPTIONAL) Tray icon > Settings > Network > DNS Server: Fixed: 8.8.8.8

