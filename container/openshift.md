

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
	dig master.lab.example.com +short
	dig node1.lab.example.com +short
	dig XXXwildcarddomainTEST.cloudapps.lab.example.com +short

	ssh-copy-id root@master
	ssh-copy-id root@node1

	atomic-openshift-excluder unexclude
	vim /etc/sysconfig/docker-storage-setup
	docker-storage-setup
	atomic-openshift-installer -u -c /root/custom-installer.cfg.yml install

	systemctl status atomic-openshift-master
	oc set image --source=docker dc/registry-console registry-console=workstation.lab.example.com:5000.openshift3/registry-console:3.5

	oc login -u developer -p password https://master.lab.example.com:8443	

	cp -r /usr/share/openshift/examples/image-streams ~/openshift-examples
	vim ~/openshift-examples/image-streams-rhel7.json
		from: { kind: DockerImage, name: workstation.lab.example.com:5000/openshift3/ruby-20-rhel7.latest }, etc...
	oc delete is -n openshift --all
	oc create -f ~/openshift-examples/image-streams-rhel7.json -n openshift
	oc describe is php -n openshift         # just for test

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

	fgrep -r /usr/share/ansible/openshift-ansible install_metrics
		./roles/openshift_metrics/defaults/main.yaml:openshift_metrics_install_metrics: True
	less /usr/share/ansible/openshift-ansible/roles/openshift_metrics/README.md
	less /usr/share/ansible/openshift-ansible/roles/openshift_metrics/defaults/main.yaml
	Install:
	docker-registry-cli workstation.lab.example.com:5000 search 
	OPENSHIFT_ANSIBLE_INVENTORY=/usr/share/ansible/openshift-ansible/playbooks/
	vim /root/hosts				# non-interactive
		vim /etc/ansible/hosts
		vim /root/.config/openshift/hosts	# interactive
	//ansible-playbook -i /root/hosts ${OPENSHIFT_ANSIBLE_INVENTORY}byo/openshift-cluster/openshift-metrics.yml -e openshift_metrics_install_metrics=True
	ansible-playbook -i /root/hosts ${OPENSHIFT_ANSIBLE_INVENTORY}byo/openshift-cluster/openshift-metrics.yml \
		-e openshift_metrics_image_prefix=workstation.lab.example.com:5000/openshift3/ose- \
		-e openshift_metrics_image_version=v3.5 \
		-e openshift_metrics_heapster_requests_memory=300M \
		-e openshift_metrics_hawkular_requests_memory=750M \
		-e openshift_metrics_cassandra_requests_memory=750M \
		-e openshift_metrics_cassandra_storage_type=pv \
		-e openshift_metrics_cassandra_pvc_size=5Gi \
		-e openshift_metrics_cassandra_pvc_prefix=metrics \
		-e openshift_metrics_install_metrics=True
	Uninstall:
	ansible-playbook -i /root/hosts /user/share/ansible/openshift-ansible/playbooks/byo/openshift-cluster/openshift-metrics.yml -e openshift_metrics_install_metrics=False

	oc get pods -n openshift-infra


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

upgrade:
	???????
probe:
	????????
web:
	



/root/hosts:
```
[OSEv3:children]
nodes
nfs
masters
etcd

[OSEv3:vars]
openshift_master_cluster_public_hostname=None
openshift_master_default_subdomain=cloudapps.mylab.private
ansible_ssh_user=root
openshift_master_cluster_hostname=None
openshift_override_hostname_check=true
deployment_type=openshift-enterprise

[nodes:vars]
openshift_docker_additional_registries=workstation.mylab.private:5000
openshift_docker_blocked_registries={'registry.access.redhat.com': None, 'docker.io': None}
openshift_docker_insecure_registries={'workstation.mylab.private:5000': None, '172.30.0.0/16': None}


[masters:vars]
openshift_docker_additional_registries=workstation.mylab.private:5000
openshift_docker_blocked_registries={'registry.access.redhat.com': None, 'docker.io': None}
openshift_docker_insecure_registries={'workstation.mylab.private:5000': None, '172.30.0.0/16': None}


[nodes]
master.mylab.private  openshift_public_ip=172.25.250.10 openshift_ip=172.25.250.10 openshift_public_hostname=master.mylab.private openshift_hostname=master.mylab.private connect_to=master.mylab.private openshift_schedulable=False ansible_connection=local
node1.mylab.private  openshift_public_ip=172.25.250.11 openshift_ip=172.25.250.11 openshift_public_hostname=node1.mylab.private openshift_hostname=node1.mylab.private connect_to=node1.mylab.private openshift_node_labels="{'region': 'infra'}" openshift_schedulable=True
node2.mylab.private  openshift_public_ip=172.25.250.12 openshift_ip=172.25.250.12 openshift_public_hostname=node2.mylab.private openshift_hostname=node2.mylab.private connect_to=node2.mylab.private openshift_node_labels="{'region': 'infra'}" openshift_schedulable=True

[nfs]
master.mylab.private  openshift_public_ip=172.25.250.10 openshift_ip=172.25.250.10 openshift_public_hostname=master.mylab.private openshift_hostname=master.mylab.private connect_to=master.mylab.private ansible_connection=local

[masters]
master.mylab.private  openshift_public_ip=172.25.250.10 openshift_ip=172.25.250.10 openshift_public_hostname=master.mylab.private openshift_hostname=master.mylab.private connect_to=master.mylab.private ansible_connection=local

[etcd]
master.mylab.private  openshift_public_ip=172.25.250.10 openshift_ip=172.25.250.10 openshift_public_hostname=master.mylab.private openshift_hostname=master.mylab.private connect_to=master.mylab.private ansible_connection=local
```


misc:
	oc new-app -L
	oc new-app http://workstation.lab.example.com/version
	oc new-app --name=hello --docker-image=workstation.lab.example.com:5000/openshift/hello-openshift --insecure-registry
	oc new-app --name=hello -i php:7.0 http://workstation.lab.example.com/php-helloworld
	oc new-app --name=probes --docker-image=workstation.lab.example.com:5000/node-hello --insecure-registry
	oc new-app centos/ruby-22-centos7~https://github.com/openshift/ruby-ex.git
	docker-registry-cli workstation.lab.example.com:5000 search node-hello
	oc new-app --name=load --docker-image=workstation.lab.example.com:5000/node-hello --insecure-registry

	oc delete all -l app=hello

	oc get svc docker-registry -n default

	oc login -u system:admin   # on master

	REGISTRYIP=$(oc get svc docker-registry -n default -o custom-columns='IP:{.spec.clusterIP}' --no-headers)
	docker tag XXX_IMAGE_ID_XXX $REGISTRYIP:5000/schedule-is/phpmyadmin:4.7
	docker load -i phpmyadmin-latest.tar
	TOKEN=$(oc whoami -t)
	docker login -u admin -p $TOKEN $REGISTRYIP:5000
	docker push $REGISTRYIP:5000/schedule-is/phpmyadmin:4.7

	$ watch -n 3 oc get builds
	$ for i in {1..5}; do curl -s https://... | fgrep IP; done
	$ ls -alZ /exports/metrics

	oc expose svc/hello
	yum install httpd-tools
	ab -n 30000 -c 20 http://hello-myproject.cloudapps.lab.example.com/
	oc adm top node --heapster-namespace=openshift-infra --heapster-scheme=https

	docker-registry-cli xxx:5000 search <IMAGE>
	OR
	GET :5000/v2/_catalog
	GET :5000/v2/<IMAGE>/tags/list

