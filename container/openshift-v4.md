
# Install OpenShift 4 on AWS: Installer-Provisioned Infrastructure

1. Route 53 > Create Hosted Zone:
	Domain: ocp4.private
	Type: Public Hosted Zone for Amazon VPC
	(*) Note that it have to be public

2. Create an User in IAM

	User name:		openshift4installer
	Access type:	Programmatic access
	Managed policy:	AdministratorAccess
	(*) This time I just attached the administrator policy for convenience. TODO!

3. Create an working EC2 instance (OR use an existing one)
	e.g.
	CentOS 7 (x86_64) - with Updates HVM
	t2.medium

4. Install AWS CLI on the working instance
yum install awscli
aws help --version
	aws-cli/1.14.28 Python/2.7.5 Linux/3.10.0-957.1.3.el7.x86_64 botocore/1.8.35

aws configure

aws ec2 describe-instances
aws ec2 describe-vpcs
aws route53 list-hosted-zones
aws route53 list-vpc-association-authorizations
aws route53 get-hosted-zone --id "/hostedzone/Z0240606S8FQIZVBII5R"



(OPTIONAL) Also,
sudo yum install epel-release
sudo yum install jq wget vim

5. Configure and deploy a cluster
mkdir work && cd work
wget https://mirror.openshift.com/pub/openshift-v4/clients/ocp/latest/openshift-install-linux-4.1.0.tar.gz
wget https://mirror.openshift.com/pub/openshift-v4/clients/ocp/latest/sha256sum.txt
fgrep openshift-install-linux sha256sum.txt | sha256sum --check
tar -zxvf openshift-install-linux-4.*.tar.gz


./openshift-install create install-config --dir=installDir
	? Platform aws
	? Region ap-northeast-1
	? Base Domain ocp4.private
	? Cluster Name ocp4cluster1
	? Pull Secret [? for help] ** You have to copy from https://cloud.redhat.com/openshift/install/aws/installer-provisioned ***

./openshift-install create cluster --dir=installDir
	INFO Consuming "Install Config" from target directory
	INFO Creating infrastructure resources...
	INFO Waiting up to 30m0s for the Kubernetes API at https://api.ocp4cluster1.ocp4.private:6443...
	INFO Use the following commands to gather logs from the cluster
	INFO ssh -A core@52.194.182.195 '/usr/local/bin/installer-gather.sh 10.0.128.246 10.0.159.59 10.0.170.85'
	INFO scp core@52.194.182.195:~/log-bundle.tar.gz .
	FATAL waiting for Kubernetes API: context deadline exceeded
	!!!!!!!!!!!!!!!!!!!!!!!




Access Your Cluster

You can log into your cluster as a default system user by exporting the cluster kubeconfig file:

export KUBECONFIG=<installation_directory>/auth/kubeconfig

oc whoami
system:admin






# Drill in

## Provisioned resources

### Route 53(1)
	ocp4cluster1.ocp4.private.	Private	9

### VPC & Subnets
VPC(1):
	vpc-0820d6eec574eada2 (ocp4cluster1-mwt26-vpc)	10.0.0.0/16
Network ACLs(1):
	(NONAME)	acl-0b838a8c7a73f2dd4	6 Subnets	Yes	vpc-0820d6eec574eada2 | ocp4cluster1-mwt26-vpc
Subnets(6):
	ocp4cluster1-mwt26-private-ap-northeast-1a	subnet-0baf18d6db8801a22	vpc-0820d6eec574eada2 | ocp4cluster1-mwt26-vpc	10.0.128.0/20	4088	ap-northeast-1a	apne1-az4	rtb-0a06ec571d76c01cf | ocp4cluster1-mwt26-private-ap-northeast-1a	acl-0b838a8c7a73f2dd4
	ocp4cluster1-mwt26-private-ap-northeast-1c	subnet-002a2bbf94aa3c7cf	vpc-0820d6eec574eada2 | ocp4cluster1-mwt26-vpc	10.0.144.0/20	4088	ap-northeast-1c	apne1-az1	rtb-01bc946c1118088c8 | ocp4cluster1-mwt26-private-ap-northeast-1c	acl-0b838a8c7a73f2dd4
	ocp4cluster1-mwt26-private-ap-northeast-1d	subnet-0bf45a55efc8773b1	vpc-0820d6eec574eada2 | ocp4cluster1-mwt26-vpc	10.0.160.0/20	4088	ap-northeast-1d	apne1-az2	rtb-0f83c26d6a13da5e8 | ocp4cluster1-mwt26-private-ap-northeast-1d	acl-0b838a8c7a73f2dd4
	ocp4cluster1-mwt26-public-ap-northeast-1a	subnet-058bcd9710ab86955	vpc-0820d6eec574eada2 | ocp4cluster1-mwt26-vpc	10.0.0.0/20	4088	ap-northeast-1a	apne1-az4	rtb-0b77ad4ebf56313c1 | ocp4cluster1-mwt26-public	acl-0b838a8c7a73f2dd4
	ocp4cluster1-mwt26-public-ap-northeast-1c	subnet-0d26d6781ce5717a9	vpc-0820d6eec574eada2 | ocp4cluster1-mwt26-vpc	10.0.16.0/20	4089	ap-northeast-1c	apne1-az1	rtb-0b77ad4ebf56313c1 | ocp4cluster1-mwt26-public	acl-0b838a8c7a73f2dd4
	ocp4cluster1-mwt26-public-ap-northeast-1d	subnet-09da7900dd3797bb2	vpc-0820d6eec574eada2 | ocp4cluster1-mwt26-vpc	10.0.32.0/20	4089	ap-northeast-1d	apne1-az2	rtb-0b77ad4ebf56313c1 | ocp4cluster1-mwt26-public	acl-0b838a8c7a73f2dd4
Route Tables:
	ocp4cluster1-mwt26-private-ap-northeast-1a	rtb-0a06ec571d76c01cf	subnet-0baf18d6db8801a22	No	vpc-0820d6eec574eada2 | ocp4cluster1-mwt26-vpc
	ocp4cluster1-mwt26-private-ap-northeast-1c	rtb-01bc946c1118088c8	subnet-002a2bbf94aa3c7cf	No	vpc-0820d6eec574eada2 | ocp4cluster1-mwt26-vpc
	ocp4cluster1-mwt26-private-ap-northeast-1d	rtb-0f83c26d6a13da5e8	subnet-0bf45a55efc8773b1	No	vpc-0820d6eec574eada2 | ocp4cluster1-mwt26-vpc
	ocp4cluster1-mwt26-public               	rtb-0b77ad4ebf56313c1	3 subnets(subnet-0d26d6781ce5717a9, subnet-09da7900dd3797bb2, subnet-058bcd9710ab86955)	Yes	vpc-0820d6eec574eada2 | ocp4cluster1-mwt26-vpc
### AMI
	Name	AMI Name	AMI ID	Source	Owner	Visibility	Status	Creation Date	Platform	Root Device Type	Virtualization
	ocp4cluster1-mwt26-master	ocp4cluster1-mwt26-master	ami-07786eabbfded0f51	889443912130/ocp4cluster1-mwt26-master	889443912130	Private	available	June 18, 2019 at 6:39:43 AM UTC+9	Other Linux	ebs	hvm

### Security Groups
	ocp4cluster1-mwt26-bootstrap-sg	sg-006a4bd0c85c06be4	terraform-20190617213947045400000004	vpc-0820d6eec574eada2m	Allow 22/tcp, 19531/tcp
	ocp4cluster1-mwt26-master-sg	sg-0ed5f35c64f8b803f	terraform-20190617213945397300000002	vpc-0820d6eec574eada2m	
	ocp4cluster1-mwt26-worker-sg	sg-0deecb80914c24a85	terraform-20190617213945678500000003	vpc-0820d6eec574eada2m
### Elastic IPs
	ocp4cluster1-mwt26-eip-ap-northeast-1d	13.113.160.139	eipalloc-06705d1b5eb7cf983	-	10.0.45.172	vpc	eipassoc-070c5aede322ed042	eni-0225c95037a2a69d0
	ocp4cluster1-mwt26-eip-ap-northeast-1c	13.230.195.148	eipalloc-0812d3899437dd42f	-	10.0.28.215	vpc	eipassoc-034fb4575c17e12f8	eni-05d4d768388e2f37b
	ocp4cluster1-mwt26-eip-ap-northeast-1a	52.192.179.212	eipalloc-01ca67a187ec517b2	-	10.0.10.137	vpc	eipassoc-0441f6f215924d68b	eni-0920c489357473bf8
### Instances
	**Name**	kubernetes.io/cluster/ocp4cluster1-mwt26	Instance ID	Instance Type	Availability Zone	Instance State	Status Checks	Alarm Status	Public DNS (IPv4)	IPv4 Public IP	IPv6 IPs	Key Name	Monitoring	Launch Time	Security Groups	VPC ID	Subnet ID	Image ID	Elastic IPs	Private DNS Name	Private IP Address
	ocp4cluster1-mwt26-bootstrap	owned	i-09ec49bb8578723e1	m4.large	ap-northeast-1a	running	2/2 checks passed	None	ec2-52-194-182-195.ap-northeast-1.compute.amazonaws.com	52.194.182.195	-		disabled	June 18, 2019 at 6:44:51 AM UTC+9	terraform-20190617213945397300000002, terraform-20190617213947045400000004	vpc-0820d6eec574eada2	subnet-058bcd9710ab86955	ami-07786eabbfded0f51	-	ip-10-0-11-156.ap-northeast-1.compute.internal	10.0.11.156
	ocp4cluster1-mwt26-master-0	owned	i-05e616baea689231a	m4.xlarge	ap-northeast-1a	running	2/2 checks passed	None		-	-		disabled	June 18, 2019 at 6:44:51 AM UTC+9	terraform-20190617213945397300000002	vpc-0820d6eec574eada2	subnet-0baf18d6db8801a22	ami-07786eabbfded0f51	-	ip-10-0-128-246.ap-northeast-1.compute.internal	10.0.128.246
	ocp4cluster1-mwt26-master-1	owned	i-0511f61833dabf11e	m4.xlarge	ap-northeast-1c	running	2/2 checks passed	None		-	-		disabled	June 18, 2019 at 6:44:51 AM UTC+9	terraform-20190617213945397300000002	vpc-0820d6eec574eada2	subnet-002a2bbf94aa3c7cf	ami-07786eabbfded0f51	-	ip-10-0-159-59.ap-northeast-1.compute.internal	10.0.159.59
	ocp4cluster1-mwt26-master-2	owned	i-0b6a64582617f3a90	m4.xlarge	ap-northeast-1d	running	2/2 checks passed	None		-	-		disabled	June 18, 2019 at 6:44:51 AM UTC+9	terraform-20190617213945397300000002	vpc-0820d6eec574eada2	subnet-0bf45a55efc8773b1	ami-07786eabbfded0f51	-	ip-10-0-170-85.ap-northeast-1.compute.internal	10.0.170.85
	ocp4cluster1-mwt26-worker-ap-northeast-1a-shvkj	owned	i-0b4069c377be66ae8	m4.large	ap-northeast-1a	running	2/2 checks passed	None		-	-		disabled	June 18, 2019 at 6:58:56 AM UTC+9	terraform-20190617213945678500000003	vpc-0820d6eec574eada2	subnet-0baf18d6db8801a22	ami-0c63b39219b8123e5	-	ip-10-0-136-233.ap-northeast-1.compute.internal	10.0.136.233
	ocp4cluster1-mwt26-worker-ap-northeast-1c-jbnbh	owned	i-00421ae1711205734	m4.large	ap-northeast-1c	running	2/2 checks passed	None		-	-		disabled	June 18, 2019 at 6:59:01 AM UTC+9	terraform-20190617213945678500000003	vpc-0820d6eec574eada2	subnet-002a2bbf94aa3c7cf	ami-0c63b39219b8123e5	-	ip-10-0-152-13.ap-northeast-1.compute.internal	10.0.152.13
	ocp4cluster1-mwt26-worker-ap-northeast-1d-zg425	owned	i-0edad945a7e4a7946	m4.large	ap-northeast-1d	running	2/2 checks passed	None		-	-		disabled	June 18, 2019 at 6:58:54 AM UTC+9	terraform-20190617213945678500000003	vpc-0820d6eec574eada2	subnet-0bf45a55efc8773b1	ami-0c63b39219b8123e5	-	ip-10-0-172-170.ap-northeast-1.compute.internal	10.0.172.170

### Load Balancers
	ocp4cluster1-mwt26-ext	ocp4cluster1-mwt26-ext-60db8b3e7d772ce3.elb.ap-northeast-1.amazonaws.com	active	vpc-0820d6eec574eada2	ap-northeast-1c, ap-northeast-1d, ap-northeast-1a	network
	ocp4cluster1-mwt26-int	ocp4cluster1-mwt26-int-36312d878f25f5df.elb.ap-northeast-1.amazonaws.com	active	vpc-0820d6eec574eada2	ap-northeast-1a, ap-northeast-1d, ap-northeast-1c	network

### Network Interfaces
	Name	Network interface ID	Subnet ID	VPC ID	Zone	Security groups	Description	Instance ID	Status	IPv4 Public IP	Primary private IPv4 IP	Secondary private IPv4 IPs	IPv6 IPs	Network interface
	ocp4cluster1-mwt26-master-0	eni-086d2b88339d08fce	subnet-0baf18d6db8801a22	vpc-0820d6eec574eada2	ap-northeast-1a	terraform-20190617213945397300000002		i-05e616baea689231a	in-use	-	10.0.128.246		-	
	ocp4cluster1-mwt26-master-1	eni-00a58ab376e7fa375	subnet-002a2bbf94aa3c7cf	vpc-0820d6eec574eada2	ap-northeast-1c	terraform-20190617213945397300000002		i-0511f61833dabf11e	in-use	-	10.0.159.59		-	
	ocp4cluster1-mwt26-master-2	eni-0eccccabdb9bc3602	subnet-0bf45a55efc8773b1	vpc-0820d6eec574eada2	ap-northeast-1d	terraform-20190617213945397300000002		i-0b6a64582617f3a90	in-use	-	10.0.170.85		-	
	 	eni-00e7822904a9e4efb	subnet-058bcd9710ab86955	vpc-0820d6eec574eada2	ap-northeast-1a		ELB net/ocp4cluster1-mwt26-ext/60db8b3e7d772ce3		in-use	18.182.173.25*	10.0.13.10		-	
	 	eni-019d30c77f62d73e4	subnet-0baf18d6db8801a22	vpc-0820d6eec574eada2	ap-northeast-1a		ELB net/ocp4cluster1-mwt26-int/36312d878f25f5df		in-use	-	10.0.129.138		-	
	 	eni-01d721bb5f30f51c9	subnet-0c6a0678f3d00ff83	vpc-0571112b64563388d	ap-northeast-1a	AllowSSH, default	Primary network interface	i-0d7535f6114f0d351	in-use	13.231.169.236*	192.168.87.66		-	
	 	eni-0225c95037a2a69d0	subnet-09da7900dd3797bb2	vpc-0820d6eec574eada2	ap-northeast-1d		Interface for NAT Gateway nat-0b29c232434733856		in-use	13.113.160.139*	10.0.45.172		-	
	 	eni-02a01031b16db3af6	subnet-0baf18d6db8801a22	vpc-0820d6eec574eada2	ap-northeast-1a	terraform-20190617213945678500000003		i-0b4069c377be66ae8	in-use	-	10.0.136.233		-	
	 	eni-05d4d768388e2f37b	subnet-0d26d6781ce5717a9	vpc-0820d6eec574eada2	ap-northeast-1c		Interface for NAT Gateway nat-07abfd847b1a44010		in-use	13.230.195.148*	10.0.28.215		-	
	 	eni-06990d7d4387805f4	subnet-0bf45a55efc8773b1	vpc-0820d6eec574eada2	ap-northeast-1d		ELB net/ocp4cluster1-mwt26-int/36312d878f25f5df		in-use	-	10.0.165.250		-	
	 	eni-0920c489357473bf8	subnet-058bcd9710ab86955	vpc-0820d6eec574eada2	ap-northeast-1a		Interface for NAT Gateway nat-0a196c4d8995dd5f5		in-use	52.192.179.212*	10.0.10.137		-	
	 	eni-0c46c8e98721e8848	subnet-002a2bbf94aa3c7cf	vpc-0820d6eec574eada2	ap-northeast-1c	terraform-20190617213945678500000003		i-00421ae1711205734	in-use	-	10.0.152.13		-	
	 	eni-0cfa6591d8669bb97	subnet-002a2bbf94aa3c7cf	vpc-0820d6eec574eada2	ap-northeast-1c		ELB net/ocp4cluster1-mwt26-int/36312d878f25f5df		in-use	-	10.0.147.118		-	
	 	eni-0d86fdc780955c732	subnet-0d26d6781ce5717a9	vpc-0820d6eec574eada2	ap-northeast-1c		ELB net/ocp4cluster1-mwt26-ext/60db8b3e7d772ce3		in-use	3.113.103.252*	10.0.23.224		-	
	 	eni-0e252f91ba62ae0bc	subnet-058bcd9710ab86955	vpc-0820d6eec574eada2	ap-northeast-1a	terraform-20190617213945397300000002, terraform-20190617213947045400000004		i-09ec49bb8578723e1	in-use	52.194.182.195*	10.0.11.156		-	
	 	eni-0e73ffe4559f17cbd	subnet-09da7900dd3797bb2	vpc-0820d6eec574eada2	ap-northeast-1d		ELB net/ocp4cluster1-mwt26-ext/60db8b3e7d772ce3		in-use	3.113.180.231*	10.0.36.64		-	
	 	eni-0f8934122a6c350ae	subnet-0bf45a55efc8773b1	vpc-0820d6eec574eada2	ap-northeast-1d	terrafor


## Providers
During deploying
mkdir -p tmp/ && cp -rpf /tmp/openshift-install-* tmp/
ls -al ./tmp/openshift-install-*/plugins/
	lrwxrwxrwx. 1 centos centos  35 Jun 17 21:39 terraform-provider-aws -> /home/centos/work/openshift-install
	lrwxrwxrwx. 1 centos centos  35 Jun 17 21:39 terraform-provider-azurerm -> /home/centos/work/openshift-install
	lrwxrwxrwx. 1 centos centos  35 Jun 17 21:39 terraform-provider-ignition -> /home/centos/work/openshift-install
	lrwxrwxrwx. 1 centos centos  35 Jun 17 21:39 terraform-provider-local -> /home/centos/work/openshift-install
	lrwxrwxrwx. 1 centos centos  35 Jun 17 21:39 terraform-provider-openstack -> /home/centos/work/openshift-install
	lrwxrwxrwx. 1 centos centos  35 Jun 17 21:39 terraform-provider-random -> /home/centos/work/openshift-install





./openshift-install create cluster
	Platform	aws
	Region		us-east-1
	Base Domain	master.ocp.localcom
	Cluster Name	testcluster
	Pull Secret		XXXXyyZz

		https://api.cluster.ocp.localcom:6443

		https://console-openshift-console.apps.cluster.ocp.localcom

	INFO Login to the console with user: kubeadmin, password: XXXXYYYY


FATAL failed to fetch Terraform Variables:
	failed to fetch dependency of "Terraform Variables":
		failed to fetch dependency of "Cluster ID":
			failed to fetch dependency of "Install Config":
				failed to generate asset "Base Domain":
					no public Route 53 hosted zones found


2. 



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
