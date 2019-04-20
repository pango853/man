
# OS X
curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/darwin/amd64/kubectl

# Linux
curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl

# Windows
curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/windows/amd64/kubectl.exe

OR

https://storage.googleapis.com/kubernetes-release/release/stable.txt
https://storage.googleapis.com/kubernetes-release/release/v1.8.2/bin/windows/amd64/kubectl.exe

OR

https://cloud.google.com/sdk/
> gcloud components install kubectl


https://github.com/kubernetes/minikube/releases

$ minikube start --vm-driver=hyperv --hyperv-virtual-switch="vSwitch0" --show-libmachine-logs --v=3

$ minikube status

$ kubectl get nodes

# minikubeの削除
$ minikube delete

# minikubeの作成
$ minikube start --vm-driver=hyperv --hyperv-virtual-switch="vSwitch0" --show-libmachine-logs --v=3

> minikube ssh -- sudo ln -sf /usr/share/zoneinfo/Asia/Tokyo /etc/localtime
Fix time lap.
> minikube ssh -- docker run -i --rm --privileged --pid=host debian nsenter -t 1 -m -u -n -i date -u $(date -u +%m%d%H%M%Y)


# MISC

kubectl configは~/.kube/にあります
