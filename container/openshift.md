

# コンテナをエンタープライズレディに OpenShiftにかけるRed Hatの意気込みとは?, 2018/5/25

About OpenShift
- 2010 Makaraの買収が起点		// Docker started in 2013/3, K8s started from mid of 2015?
- v1 released in 2012/11, v3 in 2015/6, v3.9 in 2018/3
- 2015当時、PaaSとしては先駆的な地位にあったHerokuがSalesforceに買収後、輝きを失う中で台頭してきたのがPivotal/VMwareが推進するCloud Foundryだ。
  PaaSとしてCloud Foundryを追いかけるのではなく、OpenShiftはバージョン3で「Container Platform」としてオーケストレーションツールであるKubernetesを全面的にサポートするプラットフォームに生まれ変わった
  => Red Hatはエンタープライズのアプリケーション開発がコンテナとKubernetesにターゲットを移すことを予見
- RHEL Atomic Host released in 2014/4




## 2018/1のCoreOS買収を経てさらに加速するエンタープライズKubernetesとしてのOpenShift


TODO: Red Hat Summit 2018/5

# Docker+DIY vs. Red Hat Certified

# Service Mesh
サービスメッシュを実現するIstioについてバージョン3.10で組み込まれる予定

# MISC

## OpenShiftのグローバルでの顧客層に関しては意外なことに金融業界が多いという
About 40%!
日本では信頼性重視で保守的な業界と言える金融業においてユースケースが拡がっているのは非常に興味深い。
FinTechに代表される破壊的なイノベーションに対抗するために既存の投資を無駄にせずにモダンなアプリケーション開発に向かえるというのがその理由だろうか。
シンガポールなどの政府機関においても利用が拡がっているということも合わせてより深く内容を聞き込みたいポイントとなった。
e.g. PayPal, RBS, KeyBank, PAYCHEX, BBVA, Bank of America, Nordea, BARCLAYS, Deutsche Bank, AMEX, ...

## Usecase: Amadeus

## 3.10 Roadmap
OpenShift Container Platform 3.10
- Kubernetes 1.10 & CRI-O & Bulldah(Tech Preview)
- Custom Metrics HPA
- Smart Pruning
- **Istio(Dev Preview)**
- IPv6(Tech Preview)
- OVN(Tech Preview), Multi-Network, Kuryr, IP per Project
- oc client for developers
- AWS AutoScaling
- Golden Image Tooling and TLS bootstrapping
- **Windows Server Containers(Dev Preview)**
- **Prometheus Metrics and Alerts(GA)**
- OCP + CNS integrated monitoring/Mgmt, S3 Svc Broker
- OpenShift Online & Dedicated
  - Dedicated self-service: RBAC, templates, ingress
  - Dedicated encrypted storage, multi-AZ, Azure beta



# Openshift Online


project:
	oc new-project myproject

	oc get pods -o wide
	oc expose svc NAME --hostname=NAME.cloudapps.lab.example.com


rc/dc:
	$ oc scale --replicas=5 dc myapp
hpa (HorizaontalPodAutoscaler)
	$ oc autoscale dc/myapp --min 1 --max 10 --cpu-percent=80
	oc get hpa/frontend
	oc describe hpa/frontend
	
	
oc new-app -i php:7.0 https://github.com/sclorg/cakephp-ex.git -o yaml > .\new-app.yml
vim new-app.yml
	spec:
		replicas: 3
oc create -f .\new-app.yml


misc:
	$ watch -n 3 oc get builds
	$ for i in {1..5}; do curl -s https://... | fgrep IP; done
