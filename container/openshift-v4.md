
Planning your installation: https://docs.openshift.com/container-platform/3.11/install/index.html


# Install OpenShift 4 on AWS

1. Route54
	ocp.private
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
