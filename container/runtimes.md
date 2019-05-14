
コンテナを実行するランタイムに関しては様々なランタイムが存在する割にはあまり注目されていないのが現状らしい


# Deviatives
- Docker
- cri-o
- Frakti
- containerd
- rkt by CoreOS, Kubernetes1.10において既にrktはdeprecated



# CRI(Container Runtime Interface)
コンテナ関連の重要な標準化のポイント.
Kubernetes 1.5からリリースされたKubeletとContainer Runtimeが通信するためのPlugin Interface.

	On a Node: kubelet --_CRI_--> container runtime --_OCI_--> runtime -> container(s)
ポイント: Kubernetesはマスター上のapiserver、controller-managerなどの他に、実際にコンテナが実行されるノードであるkubeletなどいくつかのコンポーネントで実行される.
そのために制御がどのように遷移していくのかを理解していないとランタイムが実際にどこで動いているのかを理解することは難しい

## Comparision between HIGH-LEVEL and LOW-LEVEL CONTAINER RUNTIME
**HIGH-LEVEL**
- Receive CRI/gRPC  and transfer to low-level runtime
- Image Management: pull/push/rm...
- Runtime: cri-o, container
=> kubeletから叩かれる部分
**LOW-LEVEL**
- Receive OCI/JSON file and execute process
- Image Management: N/A
- Runtime: runC
=> その先のコンテナイメージを叩く部分

i.e.
	On a Node: kubelet --_CRI_--> High-level --_OCI_--> Low-level -> container(s)

- Docker: kubelet -> CRI -> Docker -> containerd -> OCI -> runC -> コンテナイメージを起動 という流れだ
- cri-o:  kubelet -> CRI -> cri-o -> OCI -> runC -> コンテナイメージ
- containerd: kubelet -> CRI -> cri-containerd -> gRPC -> containerd -> OCI -> runC -> コンテナイメージという流れ. Too long!
- So、Kubernetes 1.10、containerd 1.1以降は
  kubelet -> CRI -> containerd -> OCI -> runC -> コンテナイメージという流れに変わっているという。
- Kata Container: kubelet --_CRI_--> anything --_OCI_--> runV/cc-runtime/kata-runtime -> Containers? VM?
  Intelと中国のHyperが寄贈したコンテナランタイム
  コンテナだけではなく仮想マシンのようにカーネルを共有しないOpenStack FoundationがホスするランタイムであるKata Containerの実行も可能
  今後、ContainerのようにVMを起動させる技術は期待できそう

CRIとOCIといった仕様が策定されているため、runtimeの入れ替えがより柔軟に行えるようになった
runtimeによって性能差が若干あるが、現時点でDocker(containerd)から積極的に乗り換える理由は現時点ではないかな


# OCI(Open Container Initiative)
Linux Foundation配下の組織である

# コンテナの標準化
3つ目の標準化: Runtime, Format, Image Deploy
## Format
TODO...

## Runtimes
runC vs. cc-runtime vs
- kata-runtime

### 内部構造
### 性能比較
By runtime: runc >> kata-runtime > cc-runtime
By storage driver:
- devicemapper(loopback): RHEL default. 手軽だが、性能はよくない 
- devicemapper(direct-lvm): loopbackより性能いいといわれているが、どうだろ。Production環境でdevicemapperを使う場合はdirect-lvmが推奨
- overlay: 性能は良い。UnionFSの一つ、ファイルシステムを透過的に重ねることができる
- overlay2: 最速. overlayよりもやや早いし、overlayで問題があったinode増大と性能維持に対応しているという。最近これがデフォルトだろね


## Distribution Specification for Registries
Other than Runtime and Format,
Docker Registry version 2を元にしたイメージ配布の標準化が進められている


