
https://docs.openshift.org/latest/install_config/install/advanced_install.html

# Install OpenShift 3.9 Cluster

0. Make sure you have nodes with 3GB memory and 2 core CPU on each.

hostnamectl set-hostname master.ocp39.localcom
bash

vim /etc/sysconfig/network-scripts/ifcfg-ens33
	BOOTPROTO=static
	IPADDR=192.168.1.10
	GATEWAY=192.168.1.2
	#DOMAIN=ocp39.localcom

service network restart
	192.168.1.10 master master.ocp39.localcom
	192.168.1.11 node1 node1.ocp39.localcom
	192.168.1.12 node2 node2.ocp39.localcom

> # ssh-keygen
> # ssh-copy-id master
> # ssh-copy-id node1
> # ssh-copy-id node2

ssh master
	yum install docker
	systemctl start docker
	systemctl enable docker
	yum install wget git net-tools bind-utils yum-utils iptables-service bridge-utils bash-completion kexec-tools sos psacct
	yum install epel-release
	yum install ansible pyOpenSSL
sed -i -e 's/^enabled=1/enabled=0/' /etc/yum.repos.d/epel.repo

```/etc/ansible/hosts
[OSEv3:children]
masters
nodes
etcd
nfs

[OSEv3:vars]
ansible_ssh_user=root
deployment_type=origin
containerized=true
os_firewall_use_firewalld=true
openshift_clock_enabled=true
openshift_release=v3.9.0
openshift_public_hostname=192.168.1.10
openshift_master_default_subdomain=192.168.1.10.nip.io
openshift_disable_check=memory_availability,disk_availability,docker_storage,docker_image_availability

[masters]
master.ocp39.localcom

[nodes]
master.ocp39.localcom openshift_node_labels="{'region':'infra','zone':'default'}" openshift_schedulable=true
node01.ocp39.localcom openshift_node_labels="{'region': 'primary', 'zone': 'east'}"
node02.ocp39.localcom openshift_node_labels="{'region': 'primary', 'zone': 'west'}"

[etcd]
master.ocp39.localcom

[nfs]
master.ocp39.localcom
```

ansible -m ping all

ansible-playbook ~/openshift-ansible/playbooks/prerequisites.yml
// Install latest anisble >= 2.4.3 if you have any issue about ansible

ansible-playbook ~/openshift-ansible/playbooks/deploy_cluster.yml

docker -version

https://192.168.1.10:8443/console/
	admin:admin

oc get rolebindings
oc get users
oc adm policy add-cluster-role-to-user cluster-admin admin
oc get nodes
oc get ns
oc get pods
oc get pods -o wide
oc get pods -o wide -all-namespaces
ip a
	inet 172.17.0.1/16 scope global docker0
oc get svc
oc get routes
docker images
docker ps
netstat -tlpn | fgrep openshift
netstat -tlpn | fgrep etcd
netstat -tlpn | fgrep haproxy
systemctl status origin-master-api
systemctl status origin-master-controllers
systemctl status origin-node
systemctl status origin-node-dep

oc describe node node1.ocp39.localcom
more .kube/config
oc get
df -hT

ssh node1
	netstat -tlpn | fgrep openshift
	netstat -tlpn | fgrep dns
	systemctl status origin-node
	docker -version


2. 
yum install awscli
aws config

https://mirror.openshift.com/pub/openshift-v4/clients/ocp/latest/

mkdir tmp

cd tmp

wget https://mirror.openshift.com/pub/openshift-v4/clients/ocp/latest/openshift-install-linux-4.1.0.tar.gz
tar -zxvf openshift-install-linux-4.*.tar.gz
ls -al
./openshift-install

https://cloud.redhat.com/openshift/install

./openshift-install create cluster
	Platform	aws
	Region		us-east-1
	Base Domain	master.ocp.localcom
	Cluster Name	testcluster
	Pull Secret		XXXXyyZz

		https://api.cluster.ocp.localcom:6443

		https://console-openshift-console.apps.cluster.ocp.localcom

	INFO Login to the console with user: kubeadmin, password: XXXXYYYY

3. Download client
   wget https://mirror.openshift.com/pub/openshift-v4/clients/ocp/latest/openshift-client-linux-4.1.0.tar.gz
   tar -zxvf openshift-client-linux-4.*.tar.gz
   export PATH=$PATH:`pwd`
   oc get pods
   export KUBECONFIG=`pwd`/auth/kubeconfig

4. Initial Setup
   oc get nodes
   oc get users
   oc create user admin
   oc adm policy add-cluster-role-to cluster-admin admin
   oc get routes -all-namespaces
   	prometheus-k8s-openshift-monitoring.apps.cluster.ocp.localcom
   	grafana-openshift-monitoring.apps.cluster.ocp.localcom
   	console-openshift-console.apps.cluster.ocp.localcom
   oc get pods -all-namespaces | grep Running
5. Delete
   ./openshift-install destroy cluster

TODO
https://mirror.openshift.com/pub/openshift-v4/clients/ocp/latest/openshift-client-windows-4.1.0.zip
