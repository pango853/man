


# Cousera

## API Design and Fundamentals of Google Cloud's Apigee API Platform

1.1.1. Introduction to Fundamentals and Architecture


## On Premises Installation and Rundamentals with Google Cloud's Apigee API Platform

0. Introduction
### Module 1 - Fundamentals of Apigee
1.1. Welcome to the Fundamentals
1.1.1. Introduction to Fundamentals and Architecture
1.2. The Apigee API Platform
1.2.1. Product Overview
1.2.2. Technology Stack
1.2.3. Terminology and Organizational Structure
1.2.4. Topology Design

### Module 2 - Installation
2.1. Introduction to Apigee API Platform Installation
2.1.1. Overview
	Planning: Requirements analysis, Installation topology design, Organization design, Capacity planning
	Preparation: Infrastructure provisioning, Prerequisites
	Installation: Bootstrapping, Edge profile setup, Organization provisioning, Developer protal profile setup, Validation, Post-installation activities
2.2. Planning and Preparation
2.2.1. Installation Planning
	- Choosing an Installation Topology Design
	  with architecture 
	  http://docs.apigee.com/private-cloud/latest/installation-topologies
	  planet: testing, code development, production, etc.
	- Firewall Requirements
	  DMZ zone, App zone and database zone
	- Organzizations and Environments
	  SLDC stage(dev, test, QA, staging, production, etc.)
	- Capacity Planning
2.2.2. Infrastructure Provisioning and Pre-requsites
	- Host Resource Requirements
	  Message processor, Cassandra, and PostgreSQL have the highest resource requirements
	  http://docs.apigee.com/private-cloud/latest/installation-requirements
	- Operating System
	  RHEL and variants are supported
	  OS supprot list for developer portal is slightly different
	  http://docs.apigee.com/api-services/reference/supported-software
	- Firewalls
	- Prerequisites
	  - Users and groups
	  - JDK
	  - Red Hat Satellite, EPEL, ...
	- Software Distribution
	  1. https://software.apigee.com/
	  2. local mirror
	  3. tarballs software distribution method
2.3. Installing the Apigee API Platform
2.3.1. Bootstrapping
	configures the software repository and installs base utilities
	prepares a host for customization during the profile setup process
	repository location selection is done
	- Bootstrap the first host in the cluster
	$ curl -O https://software.apigee.com/bootstrap_4.17.05.sh
	$ bash bootstrap_4.17.05.sh  apigeeuser=opstrain
	To install the utility
	$ /opt/apigee/apigee-service/bin/apigee-service apigee-setup install
2.3.2. Edge Profile Setup Overview
	Configure services on each host
	Requires a profile and response file
	- Installation Topology review
	  e.g. Region 1
	    Node1	UI MS OL 	ZK_v CS		: management stack - OpenLDAP, the management server and the enterprise UI
	    Node2	R  MP		ZK_v CS		: API gateway for processing API requests - message processors, routers
	    Node3	R  MP		ZK_v CS		
	    Node4	PS QS		PG_m QD		: analytics backend - Qpid, PostgreSQL, Qpid server and Postgres server
	    Node5	PS QS		PG_s QD		
	    Node6	DP DB                   : developer protal front-ent and its PostgreSQL database
	  Install steps:
	  1. ZK_v, CS: build all data storage services with DS profile
	  2. UI, MS, OL: build all management stack services with MS propfile
	  3. R, MP: install gateway services -- routers and message processors with RMP oprofile
	  4. PS, QS, PG_m/s, QD: install analytics services with SAX profile. Or QS and PS profiles respectively
	  5. Installs developer services using the PDB and DP propfiles
	- Edge Profiles - Use different profile to install each component host
	  c: Cassandra
	  zk: 
	  ds: 
	  ld: 
	  ms: 
	  r: 
	  mp: 
	  rmp: 
	  ui: 
	  qs: 
	  ps: 
	  sax: 
	  mo: 
	  sa: 
	  aio: 
	- Response File
	  A text file contains bash variables
	  for different tasks
	  - Installation
	  - Setuting up Apigee Edge hosts, organization and environment onboarding
	  - Setting up developer protal hosts
	  - performing platform validation
	  https://docs.apigee.com/private-cloud/latest/install-edge-components-node#installedgecomponents
	  https://docs.apigee.com/private-cloud/latest/edge-configuration-file-reference
	  multiple regsions settings are also controlled as the same way
	- Running Setup
	  # /opt/apigee/apigee-setup/bin/setup.sh -f <response_file> -p <profile>
	  Run different profiles on different hosts
2.3.3. Edge Profile Setup Demo
	First boostrap an host
	Prepare response file
	Place license file
	[root#node1]# /opt/apigee/apigee-setup/bin/setup.sh -f /tmp/apigee/response-edge.txt -p ds
	[root#node2]# /opt/apigee/apigee-setup/bin/setup.sh -f /tmp/apigee/response-edge.txt -p ds
	[root#node1]# /opt/apigee/apigee-setup/bin/setup.sh -f /tmp/apigee/response-edge.txt -p ms
	[root#node2]# /opt/apigee/apigee-setup/bin/setup.sh -f /tmp/apigee/response-edge.txt -p rmp
	[root#node3]# /opt/apigee/apigee-setup/bin/setup.sh -f /tmp/apigee/response-edge.txt -p rmp
	[root#node4]# /opt/apigee/apigee-setup/bin/setup.sh -f /tmp/apigee/response-edge.txt -p sax
	[root#node5]# /opt/apigee/apigee-setup/bin/setup.sh -f /tmp/apigee/response-edge.txt -p sax
2.3.4. Organization Provisioning
	Finally, we provision an organization, including an environment, virtual host and organization administrative.
	- Create an organization and evironment in order to use the platform
	- Also need to prepare Response File for it
	Install the provisioning utility and set up the organization
	  [root#node1]# /opt/apigee/apigee-service/bin/apigee-service apigee-provision install
	  [root#node1]# /opt/apigee/apigee-service/bin/apigee-service apigee-provision setup-org -f /tmp/apigee/response-org-apigee-prod.txt
	Now we can lo into the Apigee Enterprise UI by accessing host one in a web browser with port 9001
2.3.5. Developer Protal Setup
	Next is to set up the Apigee developer portal profiles on host 6
	- standalone PDB profile, or PG, DP profiles separately
	- PostgreSQL(PG) Response File
	- Developer Portal(DP) Response File
	[root#node6]# /opt/apigee/apigee-setup/bin/setup.sh -f /tmp/apigee/response-pdb.txt -p pdb
	Now we can log into the portal by accessing host 6 in a web browser on port 8079
2.3.6. Validation and Post-Installation Activities
	Validate the platform and perform a few additional maintenance and security tasks
	- apigee-validate
	  Install the validation utility
	  [root#node1]# /opt/apigee/apigee-service/bin/apigee-service apigee-validate install
	  To execute the script
	  [root#node1]# /opt/apigee/apigee-service/bin/apigee-service apigee-validate setup
	  [root#node1]# /opt/apigee/apigee-service/bin/apigee-service apigee-validate setup -f <response>
	  To clean up the configuration that the validation script created
	  [root#node1]# /opt/apigee/apigee-service/bin/apigee-service apigee-validate clean
	  [root#node1]# /opt/apigee/apigee-service/bin/apigee-service apigee-validate clean -f <response>
	- Autostart
	  # /opt/apigee/apigee-service/bin/apigee-service enable_autostart
	  # /opt/apigee/apigee-service/bin/apigee-service disable_autostart
	- Maintenance with cron
	  Execute the nodetool repair command on all Cassandra hosts once per week
	  # /opt/apigee/apigee-cassandra/bin/nodetool repair
	  For multi-region,
	  # /opt/apigee/apigee-cassandra/bin/nodetool repair -pr
	  PostgreSQL PG data purge
	  # /opt/apigee/apigee-service/bin/apigee-service apigee-postgresql pg-data-purge <org-name> <env> <days>
	  # /opt/apigee/apigee-service/bin/apigee-service apigee-postgresql pg-data-purge apigee prod 90
	- Other Tasks
	  Backups - There is an apigee-service action to run backups
	  TLS encryption - Enable TLS on routes, management servers and the enterprise UI
	  External directory authentication. Or identify provider to authenticate system users
	- Uninstall
	  # /opt/apigee/apigee-service/bin/apigee-service <component> uninstall
	  Completely,
	  # /opt/apigee/apigee-service/bin/apigee-all stop
	  # yum -y remove 'apigee-*' 'edge-*'
	  # rm -rf /opt/apigee /opt/nginx
	  # userdel -rf apigee
2.4. Course Completion


