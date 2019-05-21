
# minikube

TODO


# Istio

kubernetes-bootcampアプリケーションを使います。
ここでは、リクエスト・ルーティングの制御を行う前に、
このアプリケーションをIstioのSidecarなしでデプロイし、動作を確認しておきます。



# Research

- Pod
  kubectl get pods
- Namespace
  kubectl create namespace xxx
- Context
  kubectl config curent-context


# Build a Kubernetes cluster on Azure Container Service

- There's a big difference between running containers in development vs. production
- Docker Swarm, DC/OS or Kubernetes



- Azure Container Service


Create service
> az acs create --name kubecluster \
	--dns-prefix k8scluster2017 \
	--resource-group ACSRG \
	--orchestrator-type kubernetes \
	--generate-ssh-keys \

Install Kubernetes CLI
> az acs kubernetes install-cli

Try to use kubectrl command
> kubectl get nodes

Create a service
> kubectl run nginx --image nginx
> kubectl expose deployments nginx --port=80 --type=LoadBalancer

Create a proxy to the k8s master node
> kubectl proxy
> open http://localhost:8001/ui
	Workloads > Deployments
	View/edit YAML > edit "replicas" to 2 > Update





# Docker Swarm vs. Kubernetes: Comparison of the Two Giants in Container Orchestration

kubectl create -f pod-nginx.yaml
```pod-nginx.yaml
	apiVersion: v1
	kind: Pod
	metadata:
	  name: nginx-pod
	spec:
	  containers:
	    - name: nginx-container
	      image: nginx
	      ports:
	      - containerPort: 80
```
$ kubectl get pod
$ kubectl describe pods nginx-pod
$ ssh -i ~/.ssh/kube_aws_rsa ubuntu@52.68.181.10
(*) 作業用インスタンスと Kubernetes のクラスターが異なるVPCに配置されているので、Private IP ではなく Public IP 経由で接続
	sudo docker ps
$ kubectl describe pods nginx-pod
$ ssh -i ~/.ssh/kube_aws_rsa ubuntu@MASTER_PublicIP
	$ curl http://POD_PRIVATE_IP

	$ sudo docker exec 8797453df689 ip addr show eth0
	$ sudo docker exec ff67e24c8bce ip addr show eth0


```owncloud.yml Podのマニュフェストの例
	apiVersion: v1
	kind: Pod
	metadata:
	  name: owncloud-pod
	spec:
	  # MariaDBのデータストア
	  volumes:
	    - name: maria-vol
	      # Podが動作するホストの/tmp/mysqlを指定
	      hostPath:
	        path: /tmp/mysql/
	  # コンテナ設定
	  containers:
	    # OwnCloudのコンテナ(Apache/PHP含む)
	    - name: owncloud-container
	      image: owncloud
	      ports:
	      - containerPort: 80
	    # MariaDBのコンテナ
	    - name: maria-container
	      image: mariadb:5.5
	      ports:
	      - containerPort: 3306
	      # データストアを/var/lib/mysqlにマウント
	      volumeMounts:
	      - name: maria-vol
	        mountPath: /var/lib/mysql
	      # 環境変数
	      env:
	      - name: MYSQL_ROOT_PASSWORD
	        value: example
```

> kubectl run busybox --image=busybox --restart=Never --tty -i --generator=run-pod/v1 --env "POD_IP=$(kubectl get pod nginx -o go-template='{{.status.podIP}}')"
	> wget -qO- http://$POD_IP
	> exit
> kubectl delete pods busybox

> kubectl exec -it nginx --container nginx  -- /bin/sh

> kubectl delete -f simple-pod.yaml
OR
> kubectl delete pods nginx


# TODO
@inspect Pod
The pods in Kubernetes are the agent nodes that run as VMs in Azure
Dockerコンテナをまとめてサービス単位で管理する機能です
サービスの起動や停止をまとめて行うことができます



プロセステーブル

