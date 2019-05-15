

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



# Openshift Commands
files:
	~/.kube/config
	/etc/sysconfig/docker
	/etc/sysconfig/atomic-openshift-master
	/etc.bash_completion.d/oc
	/etc/origin/master/scheduler.json
services:
	[master] systemctl status atomic-openshift-master
	[node]   systemctl status docker

install:
	atomic-openshift-excluder unexclude
	atomic-openshift-installer -u -c /root/custom-installer.cfg.yml install

	systemctl status atomic-openshift-master
	oc set image --source=docker dc/registry-console registry-console=workstation.lab.example.com:5000.openshift3/registry-console:3.5

	oc login -u developer -p password https://master.lab.example.com:8443	

project:
	oc new-project myproject

	oc get pods -o wide
	oc expose svc NAME --hostname=NAME.cloudapps.lab.example.com

debug:
	oc logs -f bc/version



rc/dc:
	$ oc scale --replicas=5 dc myapp
hpa (HorizaontalPodAutoscaler)
	$ oc autoscale dc/myapp --min 1 --max 10 --cpu-percent=80
	oc get hpa/frontend
	oc describe hpa/frontend
	

	<examples>
	oc new-app -i php:7.0 https://github.com/sclorg/cakephp-ex.git -o yaml > .\new-app.yml
	vim new-app.yml
		spec:
			replicas: 3
	oc create -f .\new-app.yml

*scheduling*
	oc label node node1 region=us-west zone=power1a --overwrite
	oc get nodes node1.lab.example.com -L region
	oc get node node1.lab.example.com -L region -L zone
	oc get node node1.lab.example.com --show-labels

	oc adm manage-node --schedulable=false node2.lab.example.com
	oc adm drain node2.lab.example.com
	oc adm manage-node --schedulable=true node2.lab.example.com

	oc patch dc myapp --patch '{spec:{template:{nodeSelector:{env:qa}}}}'

	oc label node nodeNEW region=infra
	oc annotate --overwrite namespace default openshift.io/node-selector='region=infra'
	oc project default
	oc delete pod docker-registry-X-YYYYY

	oc new-app --name=hello --docker-image=workstation.lab.example.com:5000/openshift/hello-openshift --insecure-registry
	oc label node node2.lab.example.com region=my-japan-east --overwrite=true
	oc get dc/hello -o yaml > dc-hello.yml
	vim dc-hello.yml
		spec:
		  nodeSelector:
		    region: my-japan-east
	oc apply -f dc-hello.yml

is:
	oc tag ruby:latest ruby:2.0
	oc tag -d ruby:latest

	oc tag --alias=true <source> <destination>
	oc tag --scheduled=true <source> <destination>

	oc tag --reference-policy=local <source> <destination>

	oc export is phpmyadmin > is.yaml
	oc replace -f is.yaml


template:
	oc get templates -n openshift
	oc export templates XXXXX -n openshift > XXXXX.yml
	oc export po/registry-console-2-b2n1l --as-template='MyTemplate' > YYYYY.yml
	oc create -f XXXX.yml
	oc create -f XXXX.yml -l name=mylabel

metrics:
	APIPROXY=${MASTERURL}/api/v1/proxy/namespaces/openshift-infra/services
	HEAPSTERAPI=https:heapster:/api/v1/model
	TOKEN=$(oc whoami -t)
	curl -k -H "Authorization: Bearer $TOKEN" -X GET $APIPROXY/$HEAPSTER/$NODE/metrics/memory/working_set?start=$START

	oc get pods -n openshift-infra

	docker-registry-cli workstation.lab.example.com:5000 search metrics

	https://hawkular-metrics.<MASTER-wildcard-domain>

resourcequota:
	oc create -f dev-quota.yml   # kind: ResourceQuota
	OR
	oc create quota dev-quota --hard=services=10 --hard=cpu=1300m --hard=memory=1.5Gi
	oc get resourcequota
	oc describe resourcequota dev-quota
	oc describe quota
	oc delete resourcequota dev-quota

	oc create -f dev-limits.yml
	// kind: LimitRange > spec: > limit > type: Pod/Container, max/min/default: cpu: 2/200m/1, memory: 1Gi/6Mi/512Mi
	oc get limitranges
	oc describe limitranges dev-limits
	oc describe limits
	oc delete limitranges dev-limits

	oc create clusterquota user-qa --project-annotation-selector openshift.io/requester=qa --hard pods=12 --hard secrets=20
	oc create clusterquota env-qa --project-label-selector environment=qa --hard pods=10 --hard services=5
	oc delete clusterquota user-qa

	oc set resources dc/hello --requests=memory=256Mi
	oc set resources dc/hello --requests=memory=8Gi


	*troubleshooting*
	oc describe node node1.lab.example.com | fgrep -A4 Allocated
	oc describe pod hello-1-bnkdf | fgrep -A 2 Requests
	oc describe dc hello | fgrep Replicas:
	oc get events | fgrep -i error
	oc logs hello-###-deploy



misc:
	oc new-app -L
	oc new-app http://workstation.lab.example.com/version
	oc new-app --name=hello --docker-image=workstation.lab.example.com:5000/openshift/hello-openshift --insecure-registry

	oc delete all -l app=hello

	oc get svc docker-registry -n default

	REGISTRYIP=$(oc get svc docker-registry -n default -o custom-columns='IP:{.spec.clusterIP}' --no-headers)
	docker tag XXX_IMAGE_ID_XXX $REGISTRYIP:5000/schedule-is/phpmyadmin:4.7
	docker load -i phpmyadmin-latest.tar
	TOKEN=$(oc whoami -t)
	docker login -u admin -p $TOKEN $REGISTRYIP:5000
	docker push $REGISTRYIP:5000/schedule-is/phpmyadmin:4.7

	$ watch -n 3 oc get builds
	$ for i in {1..5}; do curl -s https://... | fgrep IP; done
