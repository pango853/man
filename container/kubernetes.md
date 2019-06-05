
# Ways to Use
- ローカルKubernetes環境を立ち上げる
	- Minikube
	- Docker for Desktop
- Kubernetes構築ツールを使ってクラスタを構築する
	- kubeadm
	- Rancher
- パブリッククラウド上のマネージドKubernetesを直接利用する
	- Google Kubernetes Engine（GKE）
	- Azure Container Service（AKS）
	- Elastic Container Service for Kubernetes（EKS）


# Setup a local k8s

$ brew update
$ brew install kubectl
$ brew cask install virtualbox
$ brew install minikube
OR
$ curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-darwin-amd64
$ chmod 755 minikube

$ minikube start --kubernetes-version v1.8.0
$ minikube status
これ以降は、kubectlでMinikubeのクラスタを操作することが可能です。

$ minikube delete

# Docker for Desktop
REF: https://docs.docker.com/docker-for-windows/install/
TODO...


$ kubectl config use-context docker-for-desktop
$ kubectl get nodes

Check k8s components
$ docker ps --format 'table {{.Image}}\t{{.Command}}' | grep -v pause


# kubeadm
```
apt-get update && apt-get install -y apt-transport-https
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
cat <<EOF >/etc/apt/sources.list.d/kubernetes.list
deb http://apt.kubernetes.io/ kubernetes-xenial main
EOF
apt-get update
apt-get install -y kubelet=1.8.5-00 kubeadm=1.8.5-00 kubectl=1.8.5-00 docker.io
sysctl net.bridge.bridge-nf-call-iptables=1

$ kubeadm init --pod-network-cidr=10.244.0.0/16

$ kubeadm join --token 69e02a.b5cfe76e3394b3d3 10.240.0.7:6443 --discovery-token-ca-cert-hash sha256:e1f762f2534ae11dcb174a3f9b4495888103dbd65f3e7bcdc5252b0d9b27cd15

$ mkdir -p $HOME/.kube
$ sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
$ sudo chown $(id -u):$(id -g) $HOME/.kube/config
```

Flannelデーモンを含むコンテナの起動
$ kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/v0.9.1/Documentation/kube-flannel.yml

# Rancher

> docker run -d --restart=unless-stopped -p 8080:8080 rancher/server:v2.0.0-alpha10

# GKE
> gcloud container clusters create example-cluster
> gcloud container clusters get-credentials example-cluster

# AKS
$ az provider register -n Microsoft.ContainerService
$ az group create --name myResourceGroup --location eastus
$ az aks create --resource-group myResourceGroup --name myK8sCluster --node-count 1 --generate-ssh-keys

$ az aks get-credentials --resource-group myResourceGroup --name myK8sCluster

# Spinnaker
課題として「CI/CDの機能がなく別途用意する必要があること」
クラウド用CDツールSpinnakerを利用したKubernetesへのCD
Spinnakerは、このうちCDをKubernetesなどで実現するが、CIは含まないため別途必要
パイプラインやBlue/Greenデプロイメントなど、アプリケーションの自動デプロイに必要な機能を実装している
特徴:
- マルチクラウド対応。Kubernetes、AWS、Azure、DCOS、OpenStackも！
- Kubernetesにデプロイする機能が標準的に実装されている
- GUIでパイプラインを簡単に作れる
- 複数のデプロイメント方法をサポートしていること. Red/Black Deploy, Rolling Red/Black Deploy and Canary Deploy
- パイプライン中にカスタムスクリプトを実行できる. w/ Serverspec, Selenium
- CIが別途必要なこと. w/ Jenkins, Travis CI
- 進捗状況の通知. To Slack
- パイプラインの途中で承認フローを組み込める
Interesting Features:
- デプロイできる時間帯を限定する「White-listed Execution Windows」
- ランダムに障害を起こすChaos Monkeyを組み込む「Chaos Monkey Integration」
- Webhookのトリガー
- 認証機能などがあるという
Spinnaker<=>k8s
- Instance vs Pod
- Server Group vs ReplicaSet
- Cluster vs Deployment
- Load Balancers vs Service
- Security Groups vs Ingress
TODO:
- KubernetesのManifestをデプロイする機能が追加されてKubernetes環境そのものをCD可能になる
- カナリアテストのOSS「Kayanta」と連携可能になる

# NoOps
- Kubernetesによる自律的な運用
- Azureなどのマネージドプラットフォームと組み合わせた、マネージ型Kubernetes


NoOps: "システムに自律的な運用能力（回復性）を持たせることで人間による運用を最小化することを目指すための継続的な活動" @川崎氏
NoOps -> エンドユーザーにとっては高いサービスレベルなどを、運用担当者にとっては空いた時間を開発などに使える
NoOpsを実現するための3つの能力:
- Self Healing			障害発生時に自動的に修復			:Deployment, ReplicaSet
- In-Flight Renewing	変更や更新などでの無停止メンテナンス	:Rolling Update, StatefulSet(>=1.9)
- Adaptive Scale		自律的リソース調整					:Horizontal Pod Autoscaler(HPA), Cluster Autoscaler(CA)
連携:
- Open Service Broker API	サービスを問わず、同じインターフェースで外部サービスのProvisioningやその更新・削除、サービスへのBinding・Unbindingを自動化できる
- Service Catalog			kubectlから外部サービスが使えるようになる。e.g. http://github.com/Azure/open-service-broker-azure

NoOpsの最終的な目的は、さまざまな運用負荷を最小化し、あいた時間をさらなるイノベーションに使うことにある

# Managed Kubernetes
Features:
- Upstream
- SLA 99.95%
- コンテナを用意するだけで、サーバーやノード、クラスタを意識することなく使えるクラスタフリー＆サーバレスコンテナサービス. e.g. Azure Container Instances(ACI), https://github.com/virtual-kubelet/virtual-kubelet
  az container create -g aci_grp --name nginx --image library/nginx --ip-address public --cpu 2 --memory 5

# Kubernetes ecosystem
- Microservicesの課題:
  - データ一貫性・整合性や、複雑なサービス間通信、クライアント・アプリ間の通信、モニタリング、CI/CD
- Service Mesh
  - Pod内にSidecarを埋め込むことで、コードを変更することなく回復性機能を追加することができる
    - サービスメッシュはアンバサダーパターンとして実装
    - Pod内にアプリのライフサイクルを伴うSidecarとしてデプロイされる
  - 代表としてIstioフレームワークがある。Sidecarとして組み込んだ「Envoy」がプロキシーとして振る舞うため、コードの変更が不要。サーキットブレーカーの設定
- Helm
  Kubernetesアプリのパッケージ管理とデプロイメントのツール. Charts = Package
- マイクロサービスのモニタリングとログ収集についていろいろな選択肢がある
  全体で何が起きているのか把握できることが重要だ!
  - クラスタ全体(Node, Pod)で何が起きているのかが把握できることが重要。例えば、メトリックのリアルタイム観察/傾向観察、問題調査のためのログ
  - DaemonSetとしてエージェントを登録しノードごとのログ・メトリックを収集するのが一般的
  - 選択肢として、
    Metrics time-seris DB: Prometheus, InfluxDB
    Metrics visualization: Kibana, Grafana
    ログ収集・転送: fluentd, logstash, OMS/LogAnalytics
    ログ検索・可視化: Elasticsearch/Kibana, OMS/LogAnalytics
    REF: https://docs.microsoft.com/en-us/azure/architecture/microservices/logging-monitoring

TODO... try above.


# PITFALLS
- コンテナ疲れ   
  コンテナ技術の抽象度の低さから
  - 美しいDockerfileを書いていたら半日が過ぎていた
  - イメージサイズが大きくなりすぎて改善するのに2日かかった
  - 社内にプライベートリポジトリ立てて苦労
  - Kubernetesの独自の概念を教えるだけで○週間かかる
  - 特にコンテナでは次から次へと新しい仕組みが出てきて、それが面白い点であるが、会社でほかの人に教えて普及させるには大変な点でもある
  - etc.
  => コンテナ技術は抽象度が低く、エンジニアがカバーしないといけない責任範囲が広い

# Derivatives
- k8s			Trucks
- minukube
  仮想マシンを利用せずにKubernetesを動かすことができる
- k3s			Bikes	by Rancher Labs
  様々な機能が削られていますが、MasterとNodeで稼働し、本来のKubernetesとしての分散管理というところについてはしっかり
  Rancherと連携が今後のキーポイント
- MicroK8s		Truck	by Canonical
  MasterとNodeという分散動作はせず、分散環境などの冗長性はない。開発向けのシングルKubernetesを動かすことに特化していて、
  簡単にItsioやjaegerを有効にすることができます。そういう意味で、CI/CD用途であったり、簡単にデプロイできるところを狙っているよう
  Raspberry Piでも動く?

## Supported OS
- k3s シングルバイナリーで、Ubuntu、RancherOS、CentOS等で動く. arch= amd64, arm64.
- MicroK8s Snapに対応しているOSであれば. Ubuntu、CentOSで動く. arch= amd64, arm64, ppc64el.

## Features

| Feature                      | k3s | MicroK8s |
| ---------------------------- | --- | -------- |
| Runtime組み込み               | containerd | Docker? |
| Kubernetes Master-Node分散   | 〇 | ✕ |
| traefik組み込み               | 〇 | ✕ |
| GPU対応                      | ✕ | 〇 |
| Kubernetesバージョン切り替え機能  | ✕ | 〇 |
| ダッシュボード                   | ✕ | 〇 |
| Itsio組み込み                 | ✕ | 〇 |
| jaeger組み込み                | ✕ | 〇 |
| fluentd組み込み               | ✕ | 〇 |
| storage組み込み               | ✕ | 〇 |
| fluentd組み込み               | ✕ | 〇 |
| registry組み込み              | ✕ | 〇 |
| ingress組み込み               | ✕ | 〇 |
| dns組み込み                   | ✕ | 〇 |
| metrics-server組み込み        | ✕ | 〇 |
| prometheus組み込み            | ✕ | 〇 |
| registry組み込み              | ✕ | 〇 |
| データストア                     | sqlite3(etcdも可) | etcd(シングル) |

# Kubernetes、PaaS、Serverless
## どれを選ぶのか？

XaaS:
|      | HW > Virtualization > OS > Containers > Runtimes > Applications > Functions
| ---- | 
| IaaS | O          O          O         x           x           x           x
| CaaS | O          O          O         O           x           x           x
| PaaS | O          O          O         O           O           O           x
| FaaS | O          O          O         O           O           O           O

PaaS:
- 開発者がアプリケーション開発に専念できるようにする
- アプリケーションのライフサイクルを支援するプラットフォーム
- Cloud Foundry, Deis, OpenShift, Herokuなど

Serverless:
- サーバーレスコンピューティング = サーバー管理をせずともアプリケーションの構築と実行を行う仕組み
- FaaS
  - イベントに応じて関数の実行を行う仕組み
    - イベントドリブンアーキテクチャ
  - AWS Lambda, Azure Functions, OpenWhish, Riffなど
- BaaS
  - よくServerless = FaaSというのが、
  - アプリケーションの一部を置き換えるサードパーティーのサービス

次に求めるのは
- より高度に抽象化され
- より高度に自動化され
- 現在の欠点を補えるもの
-> Dockerfileを書かずとも、自動でよい感じに動かしてくれる
-> 運用周りも全部見てくれる
-> こちらで指定しなくても、リクエストに応じてうまいことスケールしてくれる

選択基準:
//CNCFが2月に公開したホワイトペーパー「CNCF Serverless Whitepaper」がよくまとまっている
CaaS:
  Pro:
    - 高い柔軟性(Infra, Middlewares)
	- Less-opinionated from platform
	- Reusable container image
	- Powerful eco system
	- High application portability
	- Adaptive to stateful application
  Con:
	- 抽象化度合いが低い
	- 人、もしくは他の仕組みでカバーが必要な要素が多い
	  e.g. Create image, mgmt of image security patches, settings for container deployment,, monitoring and logging, load balancing and scaling
PaaS:
  Pro:
    - 開発者がアプリケーションの開発に集中できる
    - インフラやミドルウェアに対する責任はプラットフォームが担保
    - ミドルウェアごとのベストプラクティスをプラットフォームが提供
    - 成熟したプログラミングモデルを利用可能
  Con:
    - CaaSに比べると低い柔軟性。プラットフォームからの要求が多い(12FactorApps)
    - Webアプリケーションに最適化されており、non-HTTPなアプリケーションの運用に難がある
FaaS:
  Pro:
    - High Scalibility
    - 予測不可能なワークロードに対する適正
    - 使った分だけの課金(esp. Public Service)
    - インフラコストの低減
  Con:
    - これまでとは大きく異なる。コンピューティングモデルへの習熟が必要
    - 運用やデバッグへのベストプラクティスの不足
    - しばらく使われていない関数はコールドスタートとなり、タイムラグが発生する可能性
    - ベンダーロックインの可能性

システム要求だけでなく組織やビジネスなどにもよるため変数が多すぎて、
『こういうときはこれを選べ』というのは難しい。
そこで考えるべきは「目的を明確にすることだ」。
コンテナやPaaS、Serverlessは手段であり、
目的はアプリケーションによるビジネスだ。
どういう価値をもたらそうとしているか。ビジネスがはっきりしないとシステムの要求が決まらない。

ビジネスでの評価ポイント:
- 強靭性・回復性
  ホスト単位の障害、DC単位の障害、NW障害にどう対応できるか
- スケーラビリティ
  例えば、キャンペーンサイトはServerlessのメリットが生きる（ただしコスト高になる可能性もある）
- パフォーマンス
  どのぐらいの応答速度が必要か。Serverlessはスケーラビリティに優れる一方、例えばコールドスタート問題を許容できるかどうかで判断が変わる
- ステートフル or ステートレス
  データベースのようなステートフルなアプリケーションを動かすならCaaSを選ぶことになる
- アプリケーションの更新頻度
  更新頻度が高い場合はPaaSが向いている
- 既存資産を流用するか
  そのままLift & Shiftで動かすにはCaaSが良いかもしれない
- 開発者と運用者の人数
  十分な開発者・運用者を確保できないならPaaSが良いかもしれない

潜在的なコスト:
- 誰もが一からアプリケーションを作れる恵まれた環境にいるわけではない
  例えば、CaaSにLift & Shiftするだけなら楽な一方、長期的にはコストがかかるという可能性もある。また、Serverless化するとインフラコストは下がる一方、アプリを書き換えるコストがかかる可能性もある。
- 依存サービスとの関係性
  ServerlessはRDBMSとの組み合わせにはあまり向かず、同じプラットフォームのサービスを使うことになる。e.g. Lambdaの場合はDynamoDBでしょう
- セキュリティの問題
  CaaSは柔軟性が高いが、そのぶんプラットフォームは自分で対応しなくてはならない。
- ベストプラクティス
  PaaSやServerlessはベストなやり方に従うことを求められるが、それにより生産性が上がるためだ。
  一方でKubernetesなどによるCaaSは自由度が高いが、そのまま移行しただけでは生産性が改善されないかもしれない
- ベンダーロックイン
  Serverlessはほかのサービスとの組み合わせが前提なので、究極のロックインだ! Code, FW; Integration with other services;
  ただし、ベンダーロックインも考えようで、気持ちよくやれるならそれで良い。基準は『ビジネスに支障があるかどうか』
  Serverless >> PaaS(non-OSS) > PaaS(OSS) > CaaS > Kubernetes

全てに適したプラットフォームはない。なので、
- 万能なものはないので、それぞれのアプリケーションを適したプラットフォームに任せて組み合わせよう
  - StatefulなアプリケーションはCaaSに
  - 更新頻度の多いものはPaaSに
  - ETLはServerlessに
- いずれにせよDevOpsパイプラインの活用
  - プラットフォームが増えた結果、手作業が増えては意味がない。大事なのは、CI/CDの自動化は必ずやろう

## 機能比較
TODO...

## 使い分けのポイント
TODO...

# EKS
TODO...

# minikube
minikubeはlibmachine + redspread/localkubeで作られています。
https://github.com/kubernetes/minikube/releases

Install:
curl -Lo minikube https://storage.googleapis.com/minikube/releases/v0.13.0/minikube-darwin-amd64 && chmod +x minikube && sudo mv minikube /usr/local/bin/

Kubernetesクラスタの作成
$ minikube start
$ kubectl config use-context minikube
$ eval "$(minikube docker-env)"


# Install with kubeadm on GCP
cat << /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://packages.cloud.google.com/yum/repos/kubernetes-el7x86_64
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://packages.cloud.google.com/yum/doc/yum-key.gpg https://packages.cloud.google.com/yum/doc/yum-package-key.gpg
EOF

yum install kubeadm kubelet kubectl

swapoff -a
yum install docker -y
systemctl start docker
systemctl enable docker
cat /proc/sys/net/bridge/bridge-nf-call-iptables
echo 1 > /proc/sys/net/bridge/bridge-nf-call-iptables
kubeadm init -pod-network-cidr=192.168.0.0/16 -apiserver-advertise-address=172.16.1.10

mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

kubectl apply -f podnetwork.yaml # With options
See https://kubernetes.io/docs/concepts/cluster-administration/addons/ and

kubeadm join 172.16.1.10:6443 -token xxxxxxxxxxxxxxxxx -discovery-token-ca-cert-hash sha256:cccccccccccccccccccccfffff...
docker images
docker ps
mkdir -p $HOME/.kube
cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
chown $(id -u):$(id -g) $HOME/.kube/config
kubectl get nodes
kubectl get ns
kubectl get pods -all-namespaces

wget https://git.io/weave-kube-1.6
kubectl apply -f weave-kube-1.6

kubectl get pods -o wide -all-namespaces
kubectl get nodes
kubeadm token list

ssh node1
	free -m
	vim /etc/fstab
	swapoff -a
	mount -a
	yum install kubeadm kubelet docker
	systemctl start docker
	systemctl enable docker
	kubeadm join 172.16.1.10:6443 -token xxxxxxxxxx -discovery-token-ca-cert-hash sha256:ccccccccccccffffffffff

kubectl get nodes	# to see if node1 is there
kubectl run nginx -image=nginx -port 80
kubectl get pods -o wide
kubectl delete pod nginx-11111111111-222222
kubectl get pods
kubectl get deployment
kubectl expose deployment nginx -type=NodePort -name=expose-nginx
kubectl get svc
	expose-nginx NodePort xx.yyy.zzz.www 80:31332/TCP 16s
Access http://NODE-IP:31332/



# TODO
- 外部ロードバランサとの連携
- Dynamic Persistent Volume
- Conformance Program from CNCF for Certified Kubernetes Distribution/Platform
- CNCF Serverless Whitepaper
- 12 Factor Apps
- Itsioやjaeger
- traefik組み込み
- Itsio, jaeger, fluentd, storage, fluentd, registry, ingress, dns, metrics-server, prometheus組み込み
- Datastore by sqlite3, etcd
- CNCFが2月に公開したホワイトペーパー「CNCF Serverless Whitepaper」
  https://github.com/cncf/wg-serverless/tree/master/whitepaper
