
https://docs.openshift.org/latest/install_config/install/advanced_install.html

# Install OpenShift 3.11 Cluster

0. Make sure you have nodes with 4GB memory and 4 core CPU on each.

hostnamectl set-hostname master.ocp39.localcom
bash

vim /etc/sysconfig/network-scripts/ifcfg-ens33
	BOOTPROTO=static
	IPADDR=192.168.1.10
	GATEWAY=192.168.1.2
	#DOMAIN=ocp3.localcom

service network restart
	192.168.1.10 master master.ocp3.localcom
	192.168.1.11 infra infra.ocp3.localcom
	192.168.1.12 compute compute.ocp3.localcom

```/etc/yum.repos.d/ocp.repo
[3.11]
name=ocp 3.11 packages
baseurl=http://cbs.centos.org/repos/paas7-openshift-origin311-testing/x86_64/os/
enabled=1
gpgcheck=0
```

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
#openshift_release=v3.11
openshift_public_hostname=192.168.1.10		OR Public IP here???
openshift_master_default_subdomain=192.168.1.10.nip.io   OR Public_IP.openshift.com here???
openshift_disable_check=memory_availability,disk_availability,docker_storage,docker_image_availability

[masters]
master.ocp3.localcom openshift_node_group_name="node-config-master"

[nodes]
master.ocp3.localcom openshift_schedulable=true openshift_node_group_name="node-config-master"
compute.ocp3.localcom openshift_node_group_name="node-config-compute"
infra.ocp3.localcom openshift_node_group_name="node-config-infra"

[etcd]
master.ocp3.localcom openshift_node_group_name="node-config-master"

[nfs]
master.ocp3.localcom openshift_node_group_name="node-config-master"
```

ansible -m ping all

ansible clone -b release-3.11 https://github.com/openshift/openshift-ansible.git
ansible-playbook ~/openshift-ansible/playbooks/prerequisites.yml
ansible-playbook ~/openshift-ansible/playbooks/deploy_cluster.yml

docker -version

https://192.168.1.10:8443/console/
	admin:admin

oc get rolebindings
oc get users
oc adm policy add-cluster-role-to-user cluster-admin admin
oc get nodes
oc get nodes -show-labels
oc get ns
oc get pods
oc get pods -o wide
oc get pods -o wide -all-namespaces
ip a
	inet 172.17.0.1/16 scope global docker0
oc get svc
oc get svc -all-namespaces
oc get routes -all-namespaces
oc get ds -all-namespaces

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
