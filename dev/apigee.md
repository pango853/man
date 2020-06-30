
# Features

## Basics

## DEVELOP
- Proxies
- Edge Microgateway

## PUBLISH
## ANALYZE
## MONETIZE
## ADMINISTER

## INTEGRATE
- Integrate Edge Microgateway with Kubernetes 
- Apigee Adapter for Istio
- Apigee service broker for PCF (Pivotal Cloud Foundry)

## REFERENCE
## Others

# QA
- Apigeeのサービスは?
	[x] API Service
	[x] Analysis Service
	[x] Developer Service
	[ ] NO! Audit Service
	[ ] NO! Collect Service
- ApigeeはOSSでしょうか

Apigee
https://github.com/apigee

ポータルを作るためのDrupal連携モジュール(Drupalは完全OSS)や、
PHPでクライアントを作るサンプルスクリプトなどを
GitHub上に公開しているだけで、主コンポネントであるAPI Edge/Sense/Monetizationに該当しそうなソースがないので、


# External references

SOAP:
- https://ws.cdyne.com/delayedstockquote/delayedstockquote.asmx?wsdl
- http://www.dneonline.com/calculator.asmx?wsdl


# Solutions

## Bypass credentials via SOAP Proxy

There can be multiple ways to do this depending on the requirement/design.

1. Assign Message policy
   If username/password is same for every API call. I will recommend to them in an encrypted kvm, extract it from there in the target request postflow and assign it to your request payload using the Assign Message policy.
2. Custom attributes
   If you want to associate username/password with apikey.
   Then it can be stored as custom attributes in the developer app retrieved from the developer app flow variable (populated after execution of verify apikey or oauth v2 verify token policies). it can be extracted and assigned in the same manner as point 1.
3. Basic Authentication policy
   If username/password is required to be passed as input in every api call then it can be passed as Basic Authentication credentials in the Authorization parameter, if it is not being used to pass APIGEE credentials/token etc. In case Authorization is already in use, pass username/password as a base64 encoded concatenated string in a custom header parameter. The value can be extracted and decoded using the Basic Authentication policy

# Dict

- Apigee-127(deprecated)
  Apigee-127 provides the tools you need to design and build Enterprise-class APIs entirely in Node.js and deploy them on any Node.js runtime system.
  => API design & build tools
  = Swagger editor?

- Apigee-volos(deprecated)
  Volos is also a solution/middleware adds values to APIs with features such as Caching, Quota and OAuth 2.0.

- Usergrid
  Apache Usergrid is an open source top-level project at the Apache Software Foundation. A number of developers from around the world contribute to it and make use of it. Apigee donated the original Usergrid code base to the ASF and contributes heavily to the Usergrid open source project. The company makes use of Usergrid to power the Apigee Edge BaaS, which is used by hundreds of Apigee enterprise customers, and whom Apigee is committed to supporting. As a consequence, you can expect that Apigee (now Google) engineers will continue to invest in contributing to the open source project.

- MBaaS
  SaaS > BaaS > IaaS
  Cover API layer, provide basic features like authentication, push, email and etc.

- Apigee hybrid
  Apigee hybrid lets you manage APIs on-premises, on Google Cloud Platform (GCP), or a mix of both.
- Edge Microgateway include

- Drupal
- Adapter




## Certification

Google Cloud - Apigee Certified API Engineer
Job Role Description

An Apigee Professional API Engineer designs, builds, and maintains API proxies.
The API Engineer responsibilities include cross-cutting business concerns like authentication,
authorization, monitoring, logging, governance, and documentation.
API Engineers also consider API design features like consistency, usability, and versioning.
Finally, the API Engineer measures and drives success of the API program and is responsible for the documentation,
promotion, and evangelism of its products.


Certification Exam Guide

Section 1: Designing APIs

1.1 Data Modeling.

    Using consistent and intuitive naming across all APIs
    Modeling resources based on business concepts rather than internal terminology

1.2 Designing APIs.

    API-first approach
    Designing API resources and actions from consumer point-of-view
    Understanding API versioning models and breaking changes
    Determining appropriate level of orchestration for efficient API request flows
    Scoping access controls

1.3 RESTful Design.

    Choosing meaningful and consistent resource names
    Knowing when to push REST or accept legacy designs
    Using HTTP verbs appropriately and consistently
    Designing RESTful URI paths
    Choosing between path, payload, headers, and query parameters
    API paging design

1.4 Driving API consumption.

    Documenting APIs
    Creating and using OpenAPI Specifications
    Building a community for API programs

Section 2: Developing, implementing and securing APIs

2.1 Implementing API proxies on Apigee Edge.

    Implementing proxy and target flows
    Methods for calling backend services
    Fault handling and error conditions
    Mediation strategies, including:
        SOAP to REST
        Converting between XML and JSON
        Extracting data from payloads
        Mashups
    Using caching to improve latency and reduce backend load
    Extending functionality using code
    API configuration using key-value maps and target servers
    API logging and custom attributes for analytics

2.2 API Security.

    Securing APIs via OAuth, SAML, basic authentication, and IP-based access control
    Protecting against traffic spikes
    Detecting content-based attacks
    Transport layer security via one-way and two-way TLS
    Data masking
    Role-based access control for Edge

2.3 API Testing & Performance Analysis.

    Understanding the performance characteristics of policies
    Tracing calls within Edge
    Analysis of target and proxy performance
    Implementing API performance benchmarks
    Cache performance analysis and tuning

Section 3: Development Lifecycle and CI/CD

    Automating build, deployment, and configuration
    Automating unit and integration tests
    Implementing static code analysis
    Organization and environment strategies for proxy SDLC

Section 4: Requirements and Business Analysis

4.1 Managing API Products.

    Identifying API products based on business needs
    Configuring quotas
    Extending product functions using custom attributes

4.2 Requirements Analysis.

    Challenging legacy assumptions
    Writing API user stories
    Decoding business stories and finding resources and properties
    Writing consumption-based API test scenarios



# Cousera
https://www.coursera.org/courses?query=apigee

COURSES:
- Development Track
  - [x] API Design and Fundamentals of Google Cloud's Apigee API Platform
  - [x] API Development on Google Cloud's Apigee API Platform
  - [x] API Security on Google Cloud's Apigee API Platform
- Installation & Administration Track
  - [ ] Install and Manage Google Cloud's Apigee API Platform
  - [x] On Premises Management, Security, and Upgrade with Google Cloud's Apigee API Platform
  - [x] On Premises Installation and Rundamentals with Google Cloud's Apigee API Platform
  - [ ] On-Premises Capacity Upgrade and Monitoring with Google Cloud's Apigee API Platform



## COURSE: API Design and Fundamentals of Google Cloud's Apigee API Platform
https://www.coursera.org/learn/api-design-apigee-gcp

### Specialization Overview
0.1 Welcome
0.2 Get to know your Instructors
0.3 Lab Prerequisites
### Module 1 - The Fundamentals of the Apigee API Platform
1.1. Welcome to the Fundamentals
1.1.1. Introduction to the Fundamentals
1.1.2. Module Overview
1.2. What is the Apigee API Platform?
1.2.1. Product OPverview
1.2.2. Practice Quiz
1.3. Quiz
1.4. Optional: Apigee Technology Stack
1.4.1. Apigee API Platform Technology Stack
1.4.2. Honors Quiz
### Module 2 - The Basics of APIs
Overview of the basic concepts of APIs.
2.1. The Basics of APIs
2.1.1. Module Overview
2.1.2. The API Lifecycle
2.1.3. Practice Quiz
2.1.4. Fundamental Concepts and Keywords
2.1.5. Role Based Access Control (RBAC)
2.2. Quiz
### Module 3 - Apigee Edge UI Overview
3.1. Walkthrough of the Apigee Edge UI
3.1.1. Module Overview
3.1.2. Navigating the Apigee Edge UI
3.1.3. API Development in Apigee Edge
3.1.4. Practice Quiz
3.1.5. Package, Publish, and Manage APIs in Apigee Edge
3.1.6. Analyze your APIs in Apigee Edge
3.2. Quiz
	1/4 Apigee analytics tools are located separately from Edge UI?		FALSE
	2/4 OpenAPI Specs can be created in the Apigee Edge UI or imported via URL or file?	TRUE
	3/4 Publish page > Developer referring to what type of developer?	App Developer
	4/4 NOT included in the Analyze menu in the Apigee Edge UI?			NOT:Community!!!, INCLUDE:Geomap, API Proxy Performance, Developer Engagement
### Module 4 - API Design Concepts
4.1. Welcome to Design
4.1.1. Introduction to Design
4.1.2. Module Overview
	- walk through the Open API spec and how it is incorporated into the Apigee API Platform
	- cover best practices such as the consumption model, REST, proper versioning strategies, and response codes
4.2. API Design Best Practices
4.2.1. Building Blocks of REST
	- Basics of REST
	  REST is an acronym for "Representational State Transfer"
	    has a set of constraints, one is HATEOAS -- Hypermedia as the Engine of Application State
	  Pragmatic REST
	    utilizes the standard HTTP Verbs, and the action of the verb is performed on the resource.
	- Rechardson Maturity Model
	  Level0: The Swamp of POX
	  	Level1: Resources
	  		Level2: HTTP Verbs					-> Pragmatics REST
	  			Level3: Hypermedia Controls		-> REST
	  				Glory of REST
	- Examples
	  e.g. /v1/customers/ID001
	  e.g. 301 with deprecated message in reponse json
	  e.g. Request with If-Modified-Since header and 304 (Not Modified) response
4.2.2. Best Practices in API Design
	- Mission: The Most Important Design Influence
	  "Here is my services, have fun figuring them out."
	  designed with the App Developer mind -> Wider adoption, faster development time
	- Sample Mission: Reduce time to market for new apps
	  - More than just wrapping existing services
	  - Development teams need:
	    - Consistency
	    - Sandboxes to test theories
	    - Good Doc
	    - Uninterrupted Workflow
	    - Stable Environments
	- Tips for Success
		- 70% for design effort on APIs that have consumers FB
		- Nouns are good, verbs are bad
		- use conventions and technologies already in place as much as posible. First evaluate the current portfolio and see if modification can be madke to existing API to satisfy the need.
		- "An API is like a joke. If yhou have to explain it, it's not that good."
	- Best Practice: Noun-Oriented Resources
	- Best Practice: Force Verbs Out of URIs. They causes a long list of URIs with no consistent pattern
	- Best Practice: Use HTTP Verbs to Manage CRUD Operations -- POST GET PUT DELETE
	- Best Practice: Sweep Complexity Behind the '? '
		GET /parks
			For each park: GET /parks/{park-id}/dogs
				For each dog: GET /dogs/{dog-id} (filter out dogs not running & not grey)
		vs.
		GET /dogs?color=grey&state=running&location=park-id
4.2.3. Product Design
	Products are how developers and their apps access your API proxies and resources.
		have to be consumer friendly
	Developer protal: as a marketplace where consumers will have access to a catalog of products
	- Product Strategies
		API Proxy Model:			proxy A --> product A			simplicity & flexibility, isolation		Create a 1-to-1 relationship with your API proxies and your products. e.g. Authorization, Users, Locations
		Business Model:				Business Unit A --> Product A	team ownership on API, enable flexibility and growth within the product offerings, inconsistent experiences, same API resources conflicts		Create a relationship between a company's business unit specific APIs and products. e.g. (ECommerce) Website, Mobile (app)
		Ownership Model:			Dev/Ops Team A --> product A	For internal consumers. let data resources owner team drives the product groupings, grouping by development or operations teams. may not be intuitive, lack of consistency accross team				Create a relationship between the owner of the API resources and the products. e.g. Users, Locations, Authorizations
		Service Plan Model :		Plan (Blonze/Gold/etc.) --> product A 		Most flexibility for future growth, agnostic to changes in organizational or business units, not tied to back-end resource, 		Group API resources into products by service level. e.g. Silver, Gold, Platinum
	  => Don't wast time to choose, just start, change over time
4.2.4. Practice Quiz
	1/2	REST is an architectural style for distributed systems?			TRUE
	2/2	Who is the ideal person to provide feedback in regards to your API?		The application developer (or consumer) using the API
4.3. API Versioning and Revisions
4.3.1. API Versioning Strategy
	naming examples: 
		- GET /2017-04-03/accounts
		- GET /accounts
		  x-api-version: 1.1
		- GET /v20/accounts
	Perfered (but not a standard)
		GET /v1/<domain>/<resource>/{id}
		OR
		GET /<domain>/v1/<resource>/{id}
	Be Consistent --> But have to set the versioning standard yourself. There is NO STANDARD
		Consistency			leads to	predictability
		Predictablility		leads to	intuitive usability
		Usability			leads to	usage
		Usage				leads to	innovation
4.3.2. API Proxy Revisions
	Version		expose to consumers. Major change requires versioning
	Revision	proxy updates without impact consumers
	Revisioning can be controlled through Management API so can put into CI/CD process.
4.3.3. Practice Quiz
4.4. Response Codes and the Open API Spec
4.4.1. Response Codes and Pagination
	Scenario
		GET /users/U124
		404 Not Found
		GET /users/U124
		403 Forbidden		Can be used to predict existence of user!
	7 Minimal Status Codes
		- 200 OK
		- 201 Created
		- 304 Not Modified
		- 400 Bad Request
		- 401 Unauthorized
		- 404 Not Found
		- 500 Server Error
	Response Payloads	Put message, doclink, or even contact email for developer to obtain more details
	Pagination
		e.g. ```{"pagination":{page:4,pageSize:10,items:10,next:"",prev:""},items:[{},{}]}```
4.4.2. Intro to the OpenAPI Spec
	Pain of reading!
	OpenAPI Specification (OAS) -- formally Swagger, or Swagger specification
		describe how the API behaves between API provider and the API consumer
4.4.3. Practice Quiz
	1/6	4 standard HTTP Verbs:									GET POST PUT DELETE
	2/6	Pragmatic REST is a more strict version of REST?		FALSE?
	3/6	Consumption(outside-in) model to API design refer to?	Designing APIs with the Application Developer (or comsumer) in mind
	4/6	NOT a Product Strategy?									Business Model, Service Plan Model, Ownership Model, Deployment Model<--NOT>
	5/6	A new version of an API should be introduced with every change?			FALSE
	6/6	Which is major change?									Adding a required field to the payload
4.5. Quiz

### Module 5: Lab Setup and Creating an OpenAPI Spec
5.1. Lab: Pre-Requisites and Setup
5.1.1. Module Overview
5.1.2. Setting up an environment for labs
	develope APIs for a fictitious e-commerce company called Moon Digital
	- setup the Firebase Realtime database -- store sample data for backend
	- setup the edge-developer-training-backend proxy --  and setup APIs to act as Moon Digital's backend e-commerce services for product management, order management, inventory management, etc.
	Steps:
		First download and extract setup.zip: https://d3c33hcgiwev3.cloudfront.net/PBf3xN27TAWX98Tdu9wFfg_1db375be66ad402e9eab488c17185a95_setup.zip?Expires=1593648000&Signature=QthBos9rGB0z8vnQJxILd0mrDuvK1Ok66lC--neJ5enEpv133sqqXHLB8lrALlqWbIYflnagYDJKSIIcn6g-xTXEA2rMHmAaUamaEp-6Gr8lVrkFvqiiQNavW8im2XccSFi70wJBO8heIFzjNyk38ALdt8I4R05tX2TalKvYR3c_&Key-Pair-Id=APKAJLTNE6QMUY6HBC5A
		Access Firebase Console and Import Data
			https://firebase.google.com -> Add project -> Create database (Choose Realtime Database) -> click ... button and select Import JSON -> 
				select the firebase-all.json file located in the setup/data directory and import it.
			Update Firebase Rules, at the RULES tab, copy and paste below
				```
				{
				  "rules": {
				    ".read": "auth == null",
				    ".write": "auth == null"
				  }
				}
				```
			After all, click Publish button
		Firebase REST API
			$ curl -X GET https://your-projectname.firebaseio.com/db/carts.json
			$ curl -X GET https://your-projectname.firebaseio.com/db/carts/{item-id}.json
			$ curl -X GET https://your-projectname.firebaseio.com/db/carts/4b1e4bda.json
			$ curl -X GET https://your-projectname.firebaseio.com/db/users/joe.json
		Deploy the edge-developer-training-backend proxy and dependencies
			unzip setup.zip
			cd setup
			npm install
			node setup
				prompt: Please provide the Apigee Edge username:  your-gmail-account@gmail.com
				prompt: Please provide the Apigee Edge password:  *************

				prompt: Please provide the Apigee Edge Organization name:  pango853-eval
				prompt: Please provide the Apigee Edge Environment name:  test
				prompt: Please provide the Firebase Host name:  my-firebase-project-name.firebaseio.com
			(!) You also need mvn first to run above.
			Once its provided correctly, the script runs and deploys the backend proxies in your Apigee instance.
			Then you can go to Develop > API Proxies. You will find 2 proxies added: `edge-developer-training-backend` and `edge-developer-training-idp`
			- http://<org>-test.apigee.net/db or https://<org>-test.apigee.net/db
				- Proxy Endpoints
					Endpoint Flow Name	Method	Path/Condition
					PreFlow	ALL	n/a
					root	GET	
					Get all products	GET	/products
					Get product by ID	GET	/products/*
					Get product availability	GET	/products/*/availability
					Create product	POST	/products
					Update product	PUT	/products/*
					Get stores	GET	/stores
					Get stores by ID	GET	/stores/*
					Not Found	ALL	/*
					PostFlow	ALL	n/a
				- Target Endpoints
					Endpoint Flow Name	Method	Condition
					PreFlow	ALL	n/a
					Get product by ID	GET	(proxy.pathsuffix MatchesPath "/products/*") and (request.verb = "GET")
					Get product availabiity	GET	(proxy.pathsuffix MatchesPath "/products/*/availability") and (request.verb = "GET")
					Create product	POST	(proxy.pathsuffix MatchesPath "/products") and (request.verb = "POST")
					Update product	PUT	proxy.pathsuffix MatchesPath "/products/*" and request.verb = "PUT"
					PostFlow	ALL	n/a
			- https://<org>-test.apigee.net/v1/identity
				- Proxy Endpoints
					Endpoint Flow Name	Method	Path / Condition
					PreFlow	ALL	n/a
					authenticate	POST	/authenticate
					PostFlow	ALL	n/a
5.2. Lab: Creating an Open API Spec
5.2.1. Creating an Open API Spec
	https://apigee.com/edge
		select Organization
			Develop > Specs >  click +Spec
				Import URL... -> https://raw.githubusercontent.com/apigeecs/apigee-engg-training-lab-resources/master/resources/products-openapi.json -> Import
		Click the spec name to view it in the spec editor.
		Change the `host` property,
			"host": "<yourapigeeorgname>-test.apigee.net",
		Then try the basics of the OSA design tool yourself.
	Note:
		Design-First approach: 		start by creating an OpenAPI(Swagger) document, experimenting in a designer tool like Swagger UI before generating code
		Build-First approach: 		if there are exisitng back-end services and APIs. Starts from creating API Proxy first

## COURSE: On Premises Installation and Rundamentals with Google Cloud's Apigee API Platform

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

## COURSE: API Security on Google Cloud's Apigee API Platform

### Module 1 - API Security and why it's important
1.1. Welcome to API Security
1.1.1. Introduction to Secure
	convering topics such as authenitication, grant types, rate limiting, and protecting against content-based attacks
1.1.2. Module Overview and Course Prerequisites
	convering API keys and out of the box policies for managing traffic and content based attacks
1.2. API Security Fundamentals
1.2.1. Verify API Key
	Verify API Key policy
		Apps/Developer  ----- Consumer Key -----> Product{ API Proxy 1, 2, 3... }
	Need to create
		- an API Proxy
		- an Apigee Product		-> links Environment, Quota, Resource Path and API Proxy
		- an App Developer		-> Can also add cutom attributes that can be consumerd within the API proxy flow
		- a Developer App		-> links products with developers, with Callback URL. Developer App to Product is 1-to-M. The Consumer Key and Consumer Secret will be created then.
		=> Then Apigee will create a Client ID (=Consumer Key) and secret
	Attach Verifyu API Key policy to **preflow**
	Specify where to find the API Key
```
<VerifyAPIKey async="false" continueOnError="false" enabled="true" name="Verify-API-Key-1">
	<DisplayName>Custom label used in UI</DisplayName>
	<!-- Usually the API key is provided in the request header -->
	<APIKey ref="request.formparam.apikey"/> 	<!-- In this example, the key is extracted from the request payload -->
	<APIKey ref="request.header.API-Key"/> 		<!-- In this example, the key is extracted from a customer header -->
	<APIKey ref="request.queryparam.apikey"/> 	<!-- In this example, the key is extracted from a query parameter -->
</VerifyAPIKey>
```

1.2.2. Traffic Management and Rate Limiting
	`https://d3c33hcgiwev3.cloudfront.net/_3216b295b127db750cd2362217c98f64_Traffic-Management-and-Rate-Limiting.pdf?...`
	Traffic management policies
		3 policy types. Let you configure cache, control traffic quotas and spikes, set concurrent rate limits, and so on.
		- enforce quotas
		- mitigate denial of service attacks
		- cache also can be accessed via policies to manage traffic and handling of requests
	Traffic Management Policy - Spike Arrest
		Spike arrest
			is a technical requirement to protect the backend as opposed to Ouota or Rate Limit which is a business requirement to manage developer relationships
			REF: http://docs.apigee.com/api-services/reference/spike-arrest-policy#howspikearrestworks
		Spike arrest and Denial of Service
			Spike Arrest monitors the rate at which traffic comes in, it doest not count each request by putting them in timed buckets
		Spike arrest configuration
			- Identifier
			  - Mechanism to scope your incoming traffic
			  - Uses a seperate rate for each unique Id
			- Message weight
			  - Used to give extra weight to conditioned reqeusts
			- Rate
			  - Specifies the rate you want to allow traffic to come into your API Proxy
			  - Rate is for each Message Processors
			  - Rate is formatted with a number and a unit. Unit is defined as ps(per second), pm(per minute)
			  Example:
			  ```
			  <SpikeArrest async="false" continueOnError="false" enabled="true" name="Spike-Arrest">
			  	<Identifier ref="client_id"/>
			  	<MessageWeight ref="request.header.weight"/>
			  	<Rate>3ps</Rate>
			  </SpikeArrest>
			  ```
	Traffic Management Policy - Quota
		Quota
			to allow a defined number of requests to an entity
			for business logic requirements normally, unlike Spike Arrest or Concurrent Rate Limit policies for security reequirements
			uses buckets of requests per time unit, unlike spike arrest limits based on the rate of traffic
			once limit is reached all requests will be rejected
		Quota configurations
			- Identifier
			  - Mechanism to scope your incoming traffic
			  - Uses a separate bucket for each unique Id
			- Message weight
			  - Used to give extra weight to conditioned requests
			- Allow
			  - Secifies the number of requests allowed for q particular entity
			- Time Unit
			  - Month, Day, Week, Minute, Year
			- Interval
			  - Frequency of the time unit
		Quota type
			- calendar (default)	Quota counting has an explicit <StartTime>. Resets based on <Interval> and <TimeUnit>
			- rollingwindow			rolling window that resets based on <Interval> and <TimeUnit>. The start time is from the first message received matching the <Identifier>
			- flexi					allows access for a specified period of time. Start time is dynamic for each each <Identifier> based on first message being received. Calls can be used until interval has elapsed.
			REF: http://docs.apigee.com/api-services/reference/quota-policy#quotapolicytypes
		Distributed quotas
			- <Distributed>	specifies whether the count is shared among all message processors (true) or maintained separately (false)
			- <Synchronous>	specifies whether the distributed quota counter is updated synchronously
			- <AsynchronousConfiguration>	specifies how an asynchronous distributed quota is updated
			- <PreciseAtSecondsLevel>		the quota will be enforeced with an accuracy of second if true, even if the <TimeUnit> is set at a unit longer than a second
	Traffic Management Policy - Concurrent Rate Limit
		- Throttles inbound connections		API proxies <--> backend services
		- Specific placement requirements: it must be attached on both the Request and Response flows in the Target Endpoint.
		  It is recommended that you place it in a DefaultFaultRule to ensure that the rate limit counters are maintained correctly even in the event of an error
		- Limit the traffic to a manageable number of connections
	REF: http://docs.apigee.com/api-services/content/comparing-quota-spike-arrest-and-concurrent-rate-limit-policies
1.2.3. Protection Against Content Based Attack
	Content Based Attacks
	- Message content is a significant attack vector
	- Policies to mitigate the risk of your backend being compromised by malicious request payloads. e.g. SQL or JavaScript injection attacks
	Content Based Security
	- JSON Threat Protection Policy				for attacks that intend to overwhelm the parser and crush the service, i.e. application level Denial-of=Service
	- XML Threat Protection Policy				Same as JSON. Set limits on XML structure beyond what is specified in the schema, like node depth and attribute counts.
	- Regular Expression Protection Policy		for attacks through malicious content in the HTTP headers, query parameters, or the request payload that are attempting to execute code.
	JSON Thread Protection example
	```
	<JSONThreatProtection async="false" continueOnError="false" enabled="true" name="JSON-Thread-Protection-1">
		<DisplayName>JSON Threat Protection 1</DisplayName>
		<ArrayElementCount>20</ArrayElementCount>
		<ContainerDepth>10</ContainerDepth>
		<ObjectEntryCount>15</ObjectEntryCount>
		<ObjectEntryNameLength>50</ObjectEntryNameLength>
		<Source>request</Source>
		<StringValueLength>500</StringValueLength>
	</JSONThreatProtection>
	```
	XML Thread Protection example
	```
	<XMLThreatProtection async="false" continueOnError="false" enabled="true" name="XML-Thread-Protection-1">
		<DisplayName>XML Threat Protection 1</DisplayName>
		<NameLimits>
			<Element>10</Element>
			<Attribute>10</Attribute>
			<NamespacePrefix>19</NamespacePrefix>
			<ProcessingInstructionTarget>10</ProcessingInstructionTarget>
		</NameLimits>
		<StructureLimits>
			<NodeDepth>5</NodeDepth>
			<AttributeCountPerElement>2</AttributeCountPerElement>
			<NamespaceCountPerElement>3</NamespaceCountPerElement>
			<ChildCount includeComment="true" includeElement="true" includeProcessingInstruction="true" includeText="true">3</ChildCount>
		</StructureLimits>
		<ValueLimits>
			<Text>15</Text>
			<Attribute>10</Attribute>
			<NamespaceURI>10</NamespaceURI>
			<Comment>10</Comment>
			<ProcessingInstructionData>10</ProcessingInstructionData>
		</ValueLimits>
	</XMLThreatProtection>
	```
	Regular Expression Protection example
	```
	<RegularExpressionThreatProtection async="false" continueOnError="false" enabled="true" name="Regular-Expression-Thread-Protection-1">
		<DisplayName>Regular Expression Threat Protection 1</DisplayName>
		<Source>response</Source>
		<IgnoreUnresolvedVariables>false</IgnoreUnresolvedVariables>
		<URIPath>
			<Pattern>REGEX PATTERN</Pattern>
		</URIPath>
		<QueryParam name="a-query-param">
			<Pattern>REGEX PATTERN</Pattern>
		</QueryParam>
		<Header name="a-header">
			<Pattern>REGEX PATTERN</Pattern>
		</Header>
		<FormParam name="a-form-param">
			<Pattern>REGEX PATTERN</Pattern>
		</FormParam>
		<Variable name="request.content">
			<Pattern>REGEX PATTERN</Pattern>
		</Variable>
		<XMLPayload>
			<Namespaces>
				<Namespace prefix="apigee">http://www.apigee.com</Namespace>
			</Namespaces>
			<XPath>
				<Expression>/apigee:Gretting/apigee:User</Expression>
				<Type>string</Type>
				<Pattern>REGEX PATTERN</Pattern>
			</XPath>
		<JSONPayload>
			<JSONPath>
				<Expression>$.store.book[*].author</Expression>
				<Pattern>REGEX PATTERN</Pattern>
			</JSONPath>
		</JSONPayload>
	</RegularExpressionThreatProtection>
	```
	Example Blacklist Patterns
	```
		- SQL Injection							[\s]*((delete)|(exec)|(drop\s*table)|(insert)|(shutdown)|(update)|(\bor\b))
		- Server-Side Include					<!--\s*<!--(include|exec|eccho|config|printen)\s+.*   XML encoded: &lt;!--\s*&lt;!--(include|exec|echo|config|printenv)\s+.*
		- XPath Abbreviated Syntax Injection	(/(@?[\w_?\w:\*]+(\+\])*)?)+
		- XPath Expanded Syntax Injection		/?(ancestor(-or-self)?|descendant(-or-self)?|following(-sibling))
		- JavaScript Injection					<\s*script\b[^>]*>[^>]+<\s*/\s*script\s*>           XML encoded: &lt;\s*script\b[^&gt;]*&gt;[^&lt;]+&lt;\s*script\s*&gt;
		- Java Exception Injection				.*Exception in thread.*
	```

1.2.4. Practice Quiz
	1/1	2 authentication keys used to allow an API Developer to call an API?			[o] A Client ID and Secret		NOT Token, Username or Password

1.3. Lab: Securing your API
1.3.1. Verify API Key
	Add Configurations to Products, Developer Apps
		like customer attributes, Quota configurations, specific flow variables to control the behaviour of the Proxy, etc. from outside of a Proxy
		Here we use the products and apps created in `API Fundamentals and Design` and `API Development` courses.
	Part 1: Configure Quota in Product
		Select `Publish` > Select `API Products`
			Click on the products row to view Product Details, and click the `Edit` button
				enter `Quota` value like as 3 requests every 1 minute, click Save button
	Part 2: Add Custom Attributes to Developer App
		Externalize the Spike Arrest configuration using custom attributes.
		Select `Publish`, then select `Apps` this time
			Select product app to view the `Developer App Details` and click the `Edit` button
				Click `+ Custom Attribute` button, fill in as below and click the Save button
					- Name: spike-arrest
					- Value: 5pm
	Part 3: Test
		Select `Develop`, then `API Proxies`
			Select the product and lick the `TRACE` tab and start a trace session.
				Open Postman, send GET /products with API Key.
				Then click the Verify API Key policy in the trace session to show more information.
					You will find from `Phase Details`,
						- verifyapikey.Verify-API-Key-1.apiproduct.developer.quota.limit = 3
						- verifyapikey.Verify-API-Key-1.apiproduct.developer.quota.internal = 1
						- verifyapikey.Verify-API-Key-1.apiproduct.developer.quota.timeunit = minute
						- verifyapikey.Verify-API-Key-1.spike-arrest = 5pm

1.3.2. Traffic Management and Rate Limiting
	Custom attributes allow developers to dynamically change a proxy's behavior for each product(e.g. Quota) or developer app (e.g. Spike Arrest).
	Use it as flow variable that were populated after the Verify API Key policy to affect the behavior of the API externally.
	Part 1: Update Quota policy
		Select `Develop` > `Shared Flows`
			Select the security-traffic-mgmt shared flow, click `DEVELOP` tab, click `Quota` policy, update as below and click the Save button.
				```
				<Quota async="false" continueOnError="false" enabled="true" name="Quota" type="calendar">
					<DisplayName>Quota</DisplayName>
					<Properties/>
					<Allow count="200" countRef="verifyapikey.Verify-API-Key-1.apiproduct.developer.quota.limit" />
					<Interval ref="verifyapikey.Verify-API-Key-1.apiproduct.developer.quota.interval">1</Interval>
					<TimeUnit ref="verifyapikey.Verify-API-Key-1.apiproduct.developer.quota.timeunit" />minute</TimeUnit>
					<Distributed>true</Distributed>
					<Synchronous>true</Synchronous>
					<StartTime>2017-02-13 12:00:00</StartTime>
				</Quota>
				```
	Part 2: Test Quota
		Click the `TRACE` tab, start a new Trace session,
			Open Postman and send multiple requests to GET /products with APIKey till you see a QuotaViolation error returned in the response.
			Go to Publish Products, edit the Product and change the Quota to 200.
			Try calling GET /products again to see the error is gone.
	Part 3: Update Spike Arrest policy
		Select `Develop` > `Shared Flows`, select the security-traffic-mgmt shared flow
			Click the `DEVELOP` tab, click the `Spike-Arrest` policy under Policies, update as below and save.
			```
			<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
			<SpikeArrest async="false" continueOnError="false" enabled="true" name="Spike-Arrest">
				<DisplayName>Spike-Arrest</DisplayName>
				<Properties/>
				<Identifier ref="request.queryparam.apikey" />
				<Rate ref="verifyapikey.Verify-API-Key-1.spike-arrest" />
			</SpikeArrest>
			```
	Part 4: Test Spike Arrest
		Click the `TRACE` tab and start a new Trace session,
			send multiple requests to GET /products with APIKey from Postman to see the SpikeArrestViolation error
			Go to Publish Apps, edit the products-app to change the custom attribute named spike-arrest to 200pm to update Quota policy to a higher number
			Try calling GET /products to see if the error is gone.

1.3.3. Protection against Content Based Attack
	Add security policies like Regular Expression Protection policy and JSON Thread Protection, to prevent content based attacks by specifying limits on various JSON structure, such as arrays and strings. Also evaluate the content against predefined regular expressions.
	Part 1: Regular Expression policy
		Select `Develop` > `API Proxies`, select the products API proxy, click the `DEVELOP` tab,
			click `Create New Product`, followed by `+ Step` in the request flow to go to the `Add Step` window,
				select `Regular Expression Protection` policy under `Security`, set Display Name and Name as "RegexProtection" and click Add to add below and save.
					```
					<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
					<RegularExpressionProtection async="false" continueOnError="false" enabled="true" name="RegexProtection">
						<DisplayName>RegexProtection</DisplayName>
						<Source>request</Source>
						<JSONPayload escapeSlashCharacter="true">
							<JSONPath>
								<Expression>$.</Expression>
								<Pattern>.*Exception in thread.*</Pattern>
								<Pattern>[\s]*((delete)|(exec)|(drop\s*table)|(insert)|(shutdown)|(update)|(\bor\b))</Pattern>
							</JSONPath>
						</JSONPayload>
					</RegularExpressionProtection>
					```
	Part 2: Test
		Go to the `TRACE` tab and start a new session.
			Open Postman and send request to POST /products with APIKey(Regex)
				Because the attribute has SQL code that is being injected so you will see the policy got executed and raised an error response.
	Part 3: JSON Threat Protection policy
		Select `Develop` > `API Proxies`, and select your products API proxy, click `DEVELOP` tab
			Click `Create New Product` followed by `+ Step`,
				In the `Add Step` window, select `JSON Threat Protection` policy, enter JSONThreatProtection as the Display Name, click Add and add as below, click Save.
					```
					<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
					<JSONThreatProtection async="false" continueOnError="false" enabled="true" name="JSONThreatProtection">
						<DisplayName>JSONThreatProtection</DisplayName>
						<Properties/>
						<ArrayElementCount>5</ArrayElementCount>
						<ContainerDepth>2</ContainerDepth>
						<ObjectEntryCount>6</ObjectEntryCount>
						<ObjectEntryNameLength>50</ObjectEntryNameLength>
						<Source>request</Source>
						<StringValueLength>250</StringValueLength>
					</JSONThreatProtection>
					```
	Part 4: Test
		Go to the `TRACE` tab and start a new session.
			Open Postman and send a request to POST /products with APIKey (JSONThreat) to see the error response.
1.4. Quiz
	1/3 Another name for the Client ID?			The Consumer Key
	2/3 The Verify API Key Policy should be added to the Post Flow?			FALSE
	3/3 Which are out of the box Apigee Policies that can protect your APIs against content based attacks?			Regular Expression Protection Policy, JSON Threat Protection Policy and XML Threat Protection Policy
1.4.1. API Security Fundamentals
### Module 2 - OAuth and Network Security
2.1. OAuth
2.1.1. Module Overview
	wide variety of options for OAuth, like various grant types for API proxy
2.1.2. OAuth Introduction
	OAuth Roles
		Resource Owner		Owns access to protected resources
		Resource Server		Protected server, accepts access tokens
		Client				Application making request to protected resources
		Authorization Server	Issues access tokens to client
	OAuth Review
		OAuth v2.0			Clients grant access to server resources without sharing credentials
		Client IDs and Secrets	used to identify and authenticated applications
		Tokens				Client IDs and Secrets exchanged for tokens, Grant access to resource, and is Time bound
		Scopes				limits the tokens access for a resource
		Grant Types			4 Grant Types: client credentials, password, implicit and authorization code
		TLS					OAuth 2.0 requires TLS
	Access Tokens
		Client ID and Secret - Identification from the requesting application						First application sends to authorization server
		+ (OPTIONAL) User of the app - Resource owner credentials									
		+ Scope - Optional information about what the application wants to do with the resource		
		= Access Token and (optional) refresh token													Returned by authorization server
	Refresh Tokens
		Client ID and Secret - Identification from the requesting application
		+ Refresh token
		+ Scope - Optional information about what the application wants to do with the resource		
		= Access Token and (optional) refresh token
	Scopes
		Examples
			- Scope1: "READ"	GET /photos	GET /photos/{id}
			- Scope2: "UPDATE"	GET /photos	GET /photos/{id} POST /photos	PUT /photos/{id}
		Scopes are configured at Apigee > `Product Details` > `Allowed OAuth Scopes`
	OAuth Grant Types	4 OPAuth 2.0 Grant types:
		<No specific resource owner is involved>
		- Client Credentials	For business system interactions, where resources being operated on are owned by the partner, not a paticular user.	Not Complex
		<A specific resource owner is involved>
		- Client Credentials		For Resources are owned by a particular user and the requesting application is trusted			A bit complex
		- Authorization Code		For Resources are owned by a particular user and the requesting application is untrusted		Very complex
		- Implicit					For Resources are owned by a particular user and the requesting application is an untrusted browser-based app written in a scripting language such as JavaScript. Very very Complex!
2.1.3. Practice Quiz
	1/1	Which is NOT an OAuth Role?			Client | Backend Server | Resource Server | Authorization Server | Resource Owner => Backend Server
2.1.4. Client Credentials Grant Type
About client credentials
	Most typically, this grant type is used when the app is also the resource owner. For example, an app may need to access a backend cloud-based storage service to store and retrieve data that it uses to perform its work, rather than data specifically owned by the end user. This grant type flow occurs strictly between a client app and the authorization server. An end user does not participate in this grant type flow.
		Client app <--> Authorization server,  no end user participated. Client Authentication also used as the autorization Grant => Must only be used with confidential clients
		- Client ID is the only data that is exchanged for an access token
		- Simplest to implement but the least secure
	Main idea:
		Client ---> Resource Server
		no user context (resources do not belong to any user). e.g. /getlocations API call to get the list of stores which are not specific to a certain user
	Actors:
		Client App <--> Apigee Edge(Authorization Server) <-->	Resource Server
	Generate Access Token operation/policy
		```
		<?xml version="1.0" encoding="UTF-8" standalone="yes" ?>
		<OAuthV2 async="false" continueOnError="false" enabled="true" name="oauth-generate-token">
			<DisplayName>OAuth Generate Token</DisplayName>
			<Operation>GenerateAccessToken</Operation>
			<ExpiresIn>86400000</ExpiresIn>
			<SupportedGrantType>
				<GrantType>client_credentials</GrantType>
			</SupportedGrantType>
			<GrantType>request.queryparam.grant_type</GrantType>		<!-- ★ -->
			<GenerateResponse/>
		</OAuthV2>
		```
	Verify OAuth Token Policy
		```
		<?xml version="1.0" encoding="UTF-8" standalone="yes" ?>
		<OAuthV2 async="false" continueOnError="false" enabled="true" name="VerifyOAuthToken">
			<DisplayName>OAuth Verify Token</DisplayName>
			<Operation>VerifyAccessToken</Operation>
		</OAuthV2>
		```
		> curl -H "Authorization: Bearer {access_token}" http://myorg-test.apigee.net/v1/cc/oauth_cc_weather/forecastres?w=12797282
2.1.5. Password Grant Type
	Most typically, this grant type is used when the resources are owned by a particular user and the requesting application is trusted. For example, a native app could use this grant type to log in on mobile or desktop apps. It is similar to the client credentials grant type, but with an extra step to validate the user credentials along with the client credentials. However, this grant type is more secure and complex than the client credentials grant type.
	Actors:
		User
		Client
		Apigee Edge
		Authentication Server
		Resource Server
	Resource Owner Password Credentials Grant
		- resource owner is involved and the application is trusted. username and password can be used.
		- more complex and secure than client credentials grant type
		- migrate from basic auth to access tokens
		- refresh token + access token
	Generate Access Token policy
		```
		<?xml version="1.0" encoding="UTF-8" standalone="yes" ?>
		<OAuthV2 async="false" continueOnError="false" enabled="true" name="oauth-generate-token">
			<DisplayName>OAuth Generate Token</DisplayName>
			<Operation>GenerateAccessToken</Operation>
			<ExpiresIn>86400000</ExpiresIn>
			<SupportedGrantType>
				<GrantType>password</GrantType>							<!-- ★ -->
			</SupportedGrantType>
			<GrantType>request.formparam.grant_type</GrantType>		<!-- ★ -->
			<UserName>request.formparam.username</UserName>
			<PassWord>request.formparam.password</PassWord>
			<GenerateResponse/>
		</OAuthV2>
		```
	Client credentials vs. Password grant type
		Password grant type has additional attributes: refresh_token{,_issued_at,_status}
	Verify OAuth token policy
		> curl -H "Authorization: Bearer {access_token}" http://myorg.test.apigee.net/v1/customers/1234
		```
		<?xml version="1.0" encoding="UTF-8" standalone="yes" ?>
		<OAuthV2 async="false" continueOnError="false" enabled="true" name="VerifyOAuthToken">
			<DisplayName>OAuth Verify Token</DisplayName>
			<Operation>VerifyAccessToken</Operation>		<!-- ★ Same as client credentions grant type -->
		</OAuthV2>
		```
2.1.6. AuthorizationCode Grant Type
	OAuth Grant Types
		Authorization Code: Resources are owned by a particular user and the requesting application is untrusted. Very complex.
		- typically used with confidential clients or clients that can securely store the client ID and secret
	main idea
		User --> Client --> Resource Server			You don't want to share your user credentials with the Client
	Actors
		User
		User Agent (e.g. a web browser)
		Client
		Apigee (as Authorization Server)
		Authentication Server (Login App)
		Resource Server
	Sequence diagram
		user_request	User --> Client App
		/oauth/authorize(redirect_url, client_id, scope, response_type)		Client App --> Edge
		validate_client_id			Inside Edge
		http_redirect(login_page)	Edge --> Client App
		open_login_page				Client App --> User Agent
		get_login_page				User Agent --> Login App
		return_login_page			Login App --> User Agent
		display_login_page			User Agent --> User
		Then,
		provide_credentials					User --> User Agent
		submit_credentials					User Agent --> Login App
		validate_credentials				in Login App
		consent_form						Login App --> User Agent
		display_consent_page				User Agent --> User
		provide_consent						User --> User Agent
		submit_consent						User Agent --> Login App
		POST /oauth/UserAuthorize(client_id, redirect_url, scope)			Login App --> Edge
		validate_redirect_url												in Edge
		create_auth_code													in Edge
		response(redirect_url?code=auth_code)								Edge --> Login App
		http_redirect(redirect_url?code=auth_code)							Login App --> User Agent
		redirect_url?code=auth_code											User Agent --> Client App
		extract_auth_code													in Client App
		/token(grant_type, client_id, client_secret, auth_code, scope)		Client App --> Edge
		validate_credentials												in Edge
		return(access_token, refresh_token, scope, exipry)					Edge --> Client App
		get_protected_resource(access_token)								Client App --> Edge
		validate_token					in Edge
		get_resource					Edge --> Resource Server
		resource						Resource Server --> Edge
		resource						Edge --> Client App
		user_response					Client App --> User
	Generate Authorization Code
		```
		<OAuthV2 async="false" continueOnError="false" enabled="true" name="GetAuthCode">
			<DisplayName>GetAuthCode</DisplayName>
			<ExpiresIn>600000</ExpiresIn>
			<GenerateResponse/>
		</OAuthV2>
		```
	Exchange Authorization Code for Access Token
		```
		<OAuthV2 name="GetAuthToken">
			<Operation>GenerateAccessToken</Operation>
			<ExpiresIn>360000000</ExpiresIn>
			<SupportedGrantTypes>
				<GrantType>authorization_code</GrantType>			★
			</SupportedGrantTypes>
			<GrantType>request.queryparam.grant_type</GrantType>	★
			<GenerateResponse/>
		</OAuthV2>
		```
	Verify Access Token Policy
		```
		<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
		<OAuthV2 async="false" continueOnError="false" enabled="true" name="VerifyOAuthToken">
			<DisplayName>OAuth Verify Token</DisplayName>
			<Operation>VerifyAccessToken</Operation>
		</OAuthV2>
		```
	Verify OAuth Token Policy
	> curl -H "Authorization: Bearer {access_token}" http://myorg-test.apigee.net/v1/cc/oauth_cc_weather/forecastrss?w=12797282

2.1.7. Implicit Grant Type
	Implicit - Resources are owned by a particular user, and the requesting application is an untrusted browser-based app written in a scripting language such as JavaScript. Very complex and less secure than Auth Code
	main idea
		User --> Client --> Resource Server
		Client is, for example, a SPA written in JavaScript.
		This flow is a simplified version of the authorization code flow. It is typically used with browser based clients.
	Actors
		User
		User Agent
		Client
		Apigee (Authorization Server)
		Authenication Server (Login App)
		Resource Server
	Sequence diagram
		Main diff from auth code grant type is:	the implicit grant does not return an authorization code.
		Other sequences are same as authorization code flow.
	Generate Authorization Code
		```
		<OAuthV2 async="false" continueOnError="false" enabled="true" name="GetAuthCode">
			<DisplayName>GetAuthCode</DisplayName>
			<ExpiresIn>600000</ExpiresIn>
			<GenerateResponse/>
		</OAuthV2>
		```
	Verify Access Token Policy
		```
		<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
		<OAuthV2 async="false" continueOnError="false" enabled="true" name="VerifyOAuthToken">
			<DisplayName>OAuth Verify Token</DisplayName>
			<Operation>VerifyAccessToken</Operation>
		</OAuthV2>
		```
	Verify OAuth Token Policy
	> curl -H "Authorization: Bearer {access_token}" http://myorg-test.apigee.net/v1/cc/oauth_cc_weather/forecastrss?w=12797282

2.1.8. Miscellaneous
	OAuth - Misc.
	Refreshing tokens
		```xml
		<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
		<OAuthV2 async="false" continueOnError="false" enabled="true" name="RefreshToken">
			<DisplayName>OAuth Refresh Token</DisplayName>
			<Operation>RefreshAccessToken</Operation>
			<ExpiresIn>86400000</ExpiresIn>
			<ReuseRefreshToken>true</ReuseRefreshToken>
			<GrantType>request.queryparam.grant_type</GrantType>
			<RefreshToken>request.formparam.refresh_token</RefreshToken>
			<GenerateResponse/>
		</OAuthV2>
		```
		> curl -v -u "vn0zG4cnSWaWIzdwBZgnREI1NGORDXXz:uZt7LeDbq7vX90NP" -d "grant_type=refresh_token&refresh_token=LRYvVXXgWwbuEZivoe8XvZE2WPdzX9fp" "http://myorg-test.apigee.net/v1/oauth/refresh_accesstoken"
	Invalidating access and refresh tokens
		```xml
		<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
			<OAuthV2 async="false" continueOnError="false" enabled="true" name="InvalidateToken">
			<DisplayName>OAuth Invalidate Token</DisplayName>
			<Operation>InvalidateToken</Operation>
			<Tokens>
				<Token type="accesstoken" cascade="true">request.queryparam.access_token</Token>
				<Token type="refreshtoken" cascade="true">request.queryparam.refresh_token</Token>
			</Tokens>
		</OAuthV2>
		```
	Access token attributes
		```
		<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
		<OAuthV2 async="false" continueOnError="false" enabled="true" name="oauth-generate-token">
			<DisplayName>OAuth Generate Token</DisplayName>
			<Operation>GenerateAccessToken</Operation>
			<ExpiresIn>86400000</ExpiresIn>
			<SupportedGrantTypes>
				<GrantType>client_credentials</GrantType>
			</SupportedGrantTypes>
			<GrantType>request.queryparam.grant_type</GrantType>
			<Attributes>
				<Attribute name=”attr_name1” ref=”flow.variable” display="true|false">value1</Attribute>
				<Attribute name=”attr_name2” ref=”flow.variable” display="true|false">value2</Attribute>
			</Attributes>
		</OAuthV2>
		```
	GetOAuthV2Info to retrieve access token attributes
		```
		<GetOAuthV2Info name="GetTokenAttributes">
			<AccessToken ref="request.queryparam.access_token"></AccessToken>
		</GetOAuthV2Info>
		```
		Variables:
		- apigee.access_token				= ...
		- apigee.apiproduct.name			= Certification_OAuthClientCredentialsWeather
		- apigee.client_id					= ...
		- apigee.developer.app.name			= CertificationOAuthCCWeather
		- apigee.developer.email			= cerfifieddev@apigee.com
		- apigee.developer.id				= c...
		- apiproxy.name						  Certification_OAuthGetSetInfo
		- environment.name					  test
		- flow.resource.name				
		- oauthV2.failed					= false
	SetOAuthV2Info to set access token attributes
		```
		<SetOAuthV2Info name="SetOAuthV2Info">
			<AccessToken ref="request.queryparam.access_token"></AccessToken>
			<Attributes>
				<Attribute name="myAttribute1">foo</Attribute>
				<Attribute name="myAttribute2">baaz</Attribute>
			</Attributes>
		</SetOAuthV2Info>
		```

2.2. Lab: OAuth
2.2.1. Client Credentials Grant Type		15 min
	In this lab you will learn how to:
	- create an OAuth proxy that supports the client credentials grant type
	- import a shared flow that handles token validation and traffic management
	- update your Products proxy to use the shared flow
	- test the OAuth proxy and updated Products proxy.

	Part 1: Create an OAuth proxy
		Flow
			Client app <--> Apigee Edge <--> Resource Server
			1. Client app --> Apigee Edge:				/accesstoken (Client ID, Client Secret)
			2. Apigee Edge internal:					Validate credentials
			3. Client app <-- Apigee Edge				access_token, scope, expiry_time
			4. Client app --> Apigee Edge				get_protected_resource(access_token)
			5. Apigee Edge internal:					validate token
			6. Apigee Edge --> Resource Server			get resource
			7. Apigee Edge <-- Resource Server			resource
			8. Client app <-- Apigee Edge				resource
		Select Develop > API Proxies from nav,
			Client +Proxy on the right corner
				Select `No Target` and then click `Next` button
					Entery Proxy details, and click `Next` button
						Proxy Name: OAuth
						Proxy Base Path: /oauth
						Description: OAuth 2.0 Proxy
					Select `Pass through (none)` and then click `Next`
					Unselect `default` and click `Next` // so that the proxy is only deployed on https endpoint (secure), as required for OAuth 2.0
					Leave the `Deployment Environments` set only to `test` and then click the `Build and Deploy` button
				Click the `View OAuth proxy in the editor` link to enter the proxy editor
			From the `Overview` tab, click on the `DEVELOP` tab to edit the proxy.
			Now we will need to add a conditional flow to handle generating the access token.
			Click on the + button next to the default section under `Proxy Endpoints`.
				Enter Conditional Flow details, and then click Add button
				- Flow Name: GetAccessToken
				- Description: Flow to issue an OAuth 2.0 access token
				- Condition Type: Path
				- Condition: /accesstoken
				- Leave `Optional Target URL` empty
			Now we will also add the policy to handle generating the access token.
			Select GetAccessToken flow and click `+ Step` button to add a policy to the request
				Select the `OAuth v2.0 policy`, enter details and click Add button
					- Display Name: OA-GenerateAccessToken
					- Name: (Same)
					Provide the following proxy configuration and click the Save button.
					```xml
					<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
					<OAuthV2 async="false" continueOnError="false" enabled="true" name="OA-GenerateAccessToken">
						<DisplayName>OA-GenerateAccessToken</DisplayName>
						<Operation>GenerateAccessToken</Operation>
						<!-- This is in milliseconds, so expire in an hour -->
						<ExpiresIn>3600000</ExpiresIn>
						<SupportedGrantTypes>
							<GrantType>client_credentials</GrantType>
						</SupportedGrantTypes>
						<GrantType>request.formparam.grant_type</GrantType>
						<GenerateResponse enabled="true"/>
						<Tokens/>
					</OAuthV2>
					```
			Now we will add it to the API Product. Go to Publish > API Products, select the product's API Product and click `Edit`,
				click the `+ API Proxy` button under Resources > API Proxies section
					select the `OAuth` proxy from the dropdown and click `Save`.
	Part 2: Import existing shared flow
		Import a shared flow that handles token validation and traffic management to incorporate into the Product's proxy.
		First, download the shared flow: Request-Validation.zip > E:\WS\Coursera\api-security-apigee-gcp\
			https://d3c33hcgiwev3.cloudfront.net/UChynDhPEeig8Q74SlgkIA_50652d60384f11e88259c75bedf98fad_Request-Validation.zip?Expires=1590624000&Signature=UjTNokQz3RSWgN-KyqiIL48C0T0xi6CCLEAMaZKZDpaqKyXP75A~vPM0n7MrvAmcySRNTVG6lspap1sMczWZg~PpVCXEw5VlzSzyepyohIrNtqj-VzEQJE1cjQkJFtfJDX2uxcXxFGiVVwMq-99bzJW8O5~GbGiRMSXHS4J63Hc_&Key-Pair-Id=APKAJLTNE6QMUY6HBC5A
			sharedflowbundle\
				policies\
					AM-RemoveAuthHeader.xml
					Quota.xml
					Spike-Arrest.xml
					Verify-OAuth-Token.xml
				sharedflows\
					default.xml
				Request-Validation.xml
		Select `Develop` > `Shared Flows`, click the `+ Share Flow` button on the top right corner and click `Upload bundle...` option
			Select Request-Validation.zip file and then click the Create button
				Deploy the shared flow to the `test` environment
	Part 3: Implement the shared flow
		Update the Products proxy to use the shared flow.
		First select `Develop` > `API Proxies`, select `Products` proxy from the proxy list, then click the `Develop` tab to edit the proxy.
			Select the `Preflow` in the default section under `Proxy Endpoints` then click the `+ Step` button to add a policy to the request.
				Select the `Flow Callout` policy, enter as below and then click Add button. // Import to the Request Preflow since we want it to be executed first for all proxy calls
					Display Name: FC-RequestValidation
					Name: Same
					Shared Flow: Request-Validation
				Drag and drop the FC-RequestValidation step to the beginning of the `Preflow`,
					remove the existing FlowCallout-Security-Traffic-Mgmt sharedflow as we don't need it.
						click the Save button to save the proxy.
	Part 4: Test the proxies
		By getting an OAuth access token and validate that the Products proxy enforces the client credentials grant type.
		First invoke the GET /products request in Postman. You should see a failed authorization since no OAuth token was passed in the request
		Update the POST /accesstoken request in Postman with your consumer key and secret and click the Update Request.
			POST /accesstoken
				Authorization tab: Enter consumer key as Username, secret key as Password
			Then invoke the API call by clicking Send. This time you should get an access token in the response.
		Add the access token received above as a `Bearer` token in the Authorization header of the GET /products with Bearer Token request in Postman and invoke the API call.
		Now you should see a successful response!
2.2.2. Password Grant Type
	OAuth 2.0 - Resource Owner Password Credentials Grant Type
	Learn how to update the OAuth proxy to supports the resource owner password credentials grant type
	Part 1: Update OAuth proxy
		Update the OAuth proxy that generates an OAuth token using the OAuth 2.0 resource owner password credentials grant type flow.
		Flow:
			Client App <--> Edge <--> User Authentication <--> Resource Server
			```
			1. Client App --> Edge				/token(grant_type=password, client_id, client_server, username, password)
			3. Edge internal					validate_credentails
			4. Edge --> User Authentication		/authentication(username, password)
			5. User Authentication internal		validate_credentails
			6. Edge <-- User Authentication		authentication_success
			7. Client App <-- Edge				return(access_token, refresh_token, expiry)
			8. Client App --> Edge				get_protected_resource(access_token)
			9. Edge internal					validate_token
			10. Edge --> Resource Server		get_resource
			11. Edge <-- Resource Server		resource
			12. Client App <-- Edge				resource
			```
		First select `Develop` > `API Proxies`,
			select `OAuth` API Proxy that you built in the previous lab to enter the proxy editor
				from the `OVERVIEW` tab, click on the `DEVELOP` tab to begin editing the proxy
					update the OAuthV2 policy with the one below
					```xml
					<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
					<OAuthV2 async="false" continueOnError="false" enabled="true" name="OA-GenerateAccessToken">
						<DisplayName>OA-GenerateAccessToken</DisplayName>
						<Operation>GenerateAccessToken</Operation>
						<!-- This is in milliseconds, so expire in an hour -->
						<ExpiresIn>3600000</ExpiresIn>
						<SupportedGrantTypes>
							<GrantType>client_credentials</GrantType>
							<GrantType>password</GrantType>				<!-- add this -->
						</SupportedGrantTypes>
						<GrantType>request.formparam.grant_type</GrantType>
						<UserName>request.formparam.username</UserName>	<!-- add this -->
						<PassWord>request.formparam.password</PassWord>	<!-- add this -->
						<GenerateResponse enabled="true"/>
						<Tokens/>
					</OAuthV2>
					```
				Next, use a Service Callout policy to send credentials to an external identity service.
				Select GetAccessToken under default sectoin of Proxy Endpoints on the Navigator pane, and click `+ Step` button.
					Select the `Service Callout` policy, enter SC-AuthenticateUser as Display Name and Name and leave HTTP Target empty, click Add button.
						Set SC-AuthenticateUser policy as below
						```
						<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
						<ServiceCallout name="SC-AuthenticateUser">
							<DisplayName variable="authRequest">
							<Request variable="authRequest">
								<Set>
									<FormParams>
										<FormParam name="username">{request.formparam.username}</FormParam>
										<FormParam name="password">{request.formparam.password}</FormParam>
									<Verb>POST</Verb>
								</Set>
							</Request>
							<Response>
							<HTTPTargetConnection>
								<URL>https://{org}-{env}.apigee.net/v1/identity/authenticate</URL> <!-- Replace the org and env with the Apigee Org and Env respectively -->
							</HTTPTargetConnection>
						</ServiceCallout>
						```
						Drag the policy to the left of OAuth policy to make sure that the Service Callout policy is executed before the OAuth policy.
				In the Proxy flow under GetAccessToken, include the following condition so that the Service Callout happens only for the password grant type.
				```
				...
				<Step>
					<Name>SC-AuthenticateUser</Name>
					<Condition>request.formparam.grant_type = "password"</Condition>
				</Step>
				...
				```
				After all click the Save button to save the proxy.
	Part 2: Test the proxy
		By getting an OAuth access token using the resource owner password credentials grant type flow.
		First update the `POST /accesstoken (password grant)` password grant type request in Postman with your consumer key, secret, username and password and invoke the API call, you should get an access token and refresh token in the response.
			Body tab:
				Select "x-www-form-urlencoded"
				username: apininja
				password: iloveapis
				grant_type: password
			Authroization tab:
				Username: consumer key
				Password: secret
		Change the credentials to be invalid and confirm that you receive an error.
2.2.3. OAuth 2.0 - Misc
	Learn
		- Use custom attributes while generating new access tokens
		- Retrieve the custom attributes once the access token is verified by Apigee Edge
		- Generate an access token using the refresh token
	Part 1: Update OAuth proxy to include the attributes we get from the Service callout
		Select `Develop` > `API Proxyies`,
			select the OAuth API Proxy that built in the previous lab to enter the proxy editor,
				click on `DEVELOP` tab
		Now extract the info (name and email) from the response returned by the callout server, and store them as customer attributes.
		Select GetAccessToken flow from default section of Proxy Endpoints and click `+ Step` button to
			add an `Extract Variable` policy, enter the Display Name: EV-Extract-User-Info then click Add button,
				paste the follow code.
				```xml
				<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
				<ExtractVariables async="false" continueOnError="false" enabled="true" name="EV-Extract-User-Info">
					<DisplayName>EV-Extract-User-Info</DisplayName>
					<Properties/>
					<IgnoreUnresolvedVariables>true</IgnoreUnresolvedVariables>
					<JSONPayload>
						<Variable name="name">
							<JSONPath>$.name</JSONPath>
						</Variable>
						<Variable name="email">
							<JSONPath>$.email</JSONPath>
						</Variable>
					</JSONPayload>
					<Source clearPayload="false">authenticationResponse</Source>
					<VariablePrefix>authRespPrefix</VariablePrefix>
				</>
				```
		Click on GetAccessToken flow and set condition for executing only when the grant type is password.
			```
			...
			<Step>
				<Name>EV-Extract-User-Info</Name>
				<Condition>request.fromparam.grant_type = "password"</Condition> <!-- Add this -->
			</Step>
			...
			```
		Save. Then Click the OA-GenerateAccess policy from the Policies section on the left pane and update as below.
			```xml
			<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
			<OAuthV2 async="false" continueOnError="false" enabled="true" name="OA-GenerateAccessToken">
				<DisplayName>OA-GenerateAccessToken</DisplayName>
				<Operation>GenerateAccessToken</Operation>
				<ExpiresIn>3600000</ExpiresIn>
				<SupportedGrantTypes>
					<GrantType>client_credentials</GrantType>
					<GrantType>password</GrantType>
				</SupportedGrantTypes>
				<GrantType>request.formparam.grant_type</GrantType>
				<UserName>request.formparam.username</UserName>
				<PassWord>request.formparam.password</PassWord>
				<GenerateResponse enabled="true"/>
				<Attributes>
					<Attribute name="attr_user" ref="authRespPrefix.name" display="true"/>	<!-- add this -->
					<Attribute name="attr_email" ref="authRespPrefix.email" display="true"/>	<!-- add this -->
				</Attributes>
				<Tokens/>
			</OAuthV2>
			```
		Test by hitting the POST /accesstoken(password grant) request in Postman.
	Part 2: Verify custom attributes
		Check if the custom attributes that was set to the token is being displayed as flow variables.
		Select `Develop` > `API Proxies`, select the Products API Proxy that you built in the previous lab,
			click on the `TRACE` tab and start a new session,
				invoke the GET /products with Bearer Token by passing the access token you got from the POST /accesstoken(password grant) request in Postman.
					then click the OAuth Verify Access Token policy (red lock icon) in the Transaction Map, in the the Variables list, you can find all the custom attributes assigned with a prefix access token.
	Part 3: Generate Access Token using Refresh Token
		Select `Develop` > `API Proxies`, select the OAuth API Proxy,
			click on `DEVELOP` tab to begin editing the proxy,
				click `+` button next to default under Proxy Endpoints to create a new Conditional flow for the refresh token.
					provide the following details and Add and Save the proxy changes after all.
					- Flow Name: Refresh_Token
					- Description: Generate Access Token from Refresh Token
					- Condition Type: Select Path and Verb
					- Path: /refresh_accesstoken
					- Verb: Select POST
				Click the Refresh_Token flow and click `+ Step` to add a new `OAuth v2.0` policy called OA-RefreshToken in the Response flow.
				```xml
				<?xml version="" encoding="" standalone=""?>
				<OAuthV2 async="false" continuerOnError="false" enabled="true" name="OA-RefreshToken">
					<DisplayName>OA-RefreshToken</DisplayName>
					<Operation>RefreshAccessToken</Operation>
					<ExpiresIn>3600000</ExpiresIn>
					<ReuseRefreshToken>true</ReuseRefreshToken>
					<GrantType>request.formparam.grant_type</GrantType>
					<RefreshToken>request.formparam.refresh_token</RefreshToken>
					<GenerateResponse/>
				</OAuthV2>
				```
	Part 4: Test Refresh Token flow
		Invoke the POST /accesstoken(password grant) request in Postman. Get the refresh token from the response,
			then invoke the POST /refreshtoken request by passing the refresh token in Postman with the correct authorization in the Headers tab.
			You should get a valid response with a new access token from the Body tab.
			Next you can use this newly generated access token to call Products API.
		
2.3. Transport Security and SAML
2.3.1. Transport Security(TLS)
	Edge Support for TLS
		- Public and private cloud
		- One-way TLS	Client verifies server
		- Two-way TLS	Mutual auth between client and server
	What data is encrypted via TLS?
		- URL
		- Headers
		- Query params
		- HTTP verb
		- Payload
		- NOT: ONLY destination server & payload size are known
	Sensitive Data and TLS
		Use payload or headers, rather than
		- No passwords in query parameters	TLS encrypts data in motion not at rest
		- Avoid sensitive info in URLs		might be logged
	TLS & Edge
		Client --> Edge --> Target
	Edge Keystores & Trustores
		Keystores and Truststores used for client and target communication
		- Keystore		Holds server certificates that are presented to the client
		- Truststore 	Valid client certificates that are presented to the server after the cilent has validated the server certificate
	one-way TLS
		1. Requests protected resource		CLIENT --> SERVER
		2. Presents certificate				SERVER KEYSTORE --> SERVER --> CLIENT
		3. Verifies certificate				CLIENT --> TRUSTSTORE (SERVER CERTIFICATE)
		4. Accesses protected resource		CLIENT <--> SERVER
	two-way TLS
		1. Requests protected resource		CLIENT --> SERVER
		2. Presents certificate				SERVER KEYSTORE --> SERVER --> CLIENT
		3. Verifies certificate				CLIENT --> TRUSTSTORE (SERVER CERTIFICATE)
		4. Presents certificate				CLIENT KEYSTORE --> CLIENT --> SERVER
		5. Verifies certificate				SERVER --> TRUSTSTORE (CLIENT CERTIFICATE)
		6. Accesses protected resource		CLIENT <--> SERVER
	Configuring 2-way TLS from client to Edge (Public Cloud)
		1. Server keystore		Create a keystore and upload certificate and private key of the server
		2. Truststore			If the client uses a self-signed certificate, or a certificate that is not signed by a trusted CA, create a truststore on Edge that contains the CA chain of the client certificate
		3. Virtualhost			Create a support ticket so the virtualhost is created with the suitable configuration.
			```
			<VirtualHost name="myTLSVHost">
				<HostAliases>
					<HostAlias>apiTLS.myCompany.com</HostAlias>
				</HostAliases>
				<Port>443</Port>
				<SSLInfo>
					<Enabled>true</Enabled>
					<ClientAuthEnabled>false</ClientAuthEnabled>
					<KeyStore>myTestKeystore</KeyStore>
					<KeyAlias>myKeyAlias</KeyAlias>
				</SSLInfo>
			</VirtualHost>
			```
	Securing calls to the backend
		Generally the backend is locked down. Options for securing the communication to the backend server:
		- Credentials
		- OAuth		adds significant complexity to backend calls
		- IP Whitelisting	!but can be spoofed
		- Two-way TLS
	Implementing 2-way TLS from Apigee Edge to backend server
		  - Obtain/generate client certificate for Edge
		  - Create and populate a keystore on Edge containing Edge's cert and private key
		  - Creaet and populate a truststore on Edge containing trusted certs
		  - Configure the TargetEndpoint or TargetServer
	Configuring 2-way TLS from Edge to target
	    ```
	    <TargetServer name="target1">
	    	<SSLInfo>
	    		<Enabled>true
	    		<ClientAuthEnabled>true</ClientAuthEnabled>
	    		<KeyAlias>myKeystore</KeyAlias>
	    		<KeyStore>myKey</KeyStore>
	    		<TrustStore>myTrustStore</TrustStore>
	    	</SSLInfo>
	    </TargetServer>
	    ```
	Data Masking
		Edge's trace tool allows developers to capture runtime traffic. Some of sensitive information may be exposed, such as passwords, credit card numbers, or personal health information.
		Edge provides data masking to filter this data out of the capturd trace infomation.
		- block values in XML payloads, JSON payloads, and variables
		Data masking configurations can be set
		- globally for an organization
		  POST /v1/o/{org}/maskconfigs
		- or on specific apis
		  POST /v1/o/{org}/apis/{api}/maskconfigs
	Using mask configurations
		```
		<MaskDataConfiguration name="default">
			<XPathsRequest>
				<XPathRequest>/apigee:Greeting/apigee:User</XPathRequest>
			</XPathsRequest>
			<XPathsResponse>
				<XPathResponse>/apigee:Greeting/apigee:User</XPathResponse>
			</XPathsResponse>
			<JSONPathsRequest>
				<JSONPathRequest>$.store.book[*].author</JSONPathRequest>
			</JSONPathsRequest>
			<JSONPathsResponse>
				<JSONPathResponse>$.store.book[*].author</JSONPathResponse>
			</JSONPathsResponse>
			<XPathsFault>
				<XPathFault>/apigee:Greeting/apigee:User</XPathFault>
			</XPathsFault>
			<JSONPathsFault>
				<JSONPathFault>$.store.book[*].author</JSONPathFault>
			</JSONPathsFault>
			<Variables>
				<Variable>request.header.user-agent</Variable>
				<Variable>request.formparam.password</Variable>
			</Variables>
		</MaskDataConfiguration>
		```
2.3.2. SAML
	Security Assertion Markup Language(SAML)
	- exchange authentication and authorization information in XML format
	- security assertions between:
	  - Identity Provider - generates SAML tokens
	  - Server Provider - validates SAML tokens
	- Apigee Edge acts as Identity Provider and Server Provider
	- support SAML Core Specification Version 2.0 and WS-Security SAML Token Profile specification Version 1.0
	GenerateSAMLAssertion policy
	- outbound token generation
	- attach SAML assertions to outbound XML requests
	- for authentication and authorization of the backend services
	- typically attached to the TargetEndpoint request Flow
	- requries:
	  - issuer
	  - keystore
	  - subject
	  - xpath
	Example:
	```
	<GenerateSAMLAssertion name="SAML" ignoreContentType="false">
		<CanonicalizationAlgorithm />
		<Issuer ref="reference">Issuer name</Issuer>		★
		<KeyStore>											★
			<Name ref="reference">keystoername</Name>
			<Alias ref="reference">alias</Alias>
		</KeyStore>
		<OutputVariable>
			<FlowVariable>assertion.content</FlowVariable>
			<Message name="request">
				<Namespaces>
					<Namespace prefix="test">http://www.example.com/test/</Namespace>
				</Namespaces>
				<XPath>/envelope/header</XPath>				★
			</Message>
		</OutputVariable>
		<SignatureAlgorithm />
		<Subject ref="reference">Subject name</Subject>		★
		<Template ignoreUnresolvedVariables="false">
			<!-- A lot of XML goes here, in CDATA, with {} around each variable -->
		</Template>
	</GenerateSAMLAssertion>
	```
	ValidateSAMLAssertion policy
	- inbound authentication and authorization
	- validate SAML assertions to inbound SOAP requets
	  If valid, sets variables for further processing. Rejects if invalid.
	- typically attached to the ProxyEndpoing request Flow
	- requires:
	  - source
	  - xpath
	  - truststore	contains the trusted X.509 certificate used to validate the digital signature on the SAML assertion.
	Example:
	```
	<ValidateSAMLAssertion name="SAML" ignoreContentType="false">
		<Source name="request">															★
			<Namespaces>
				<Namespace prefix="soap">http://schemas.xmlsoap.org/soap/envelope/</Namespace>
				<Namespace prefix="wsse">http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-secext-1.0.xsd</Namespace>
				<Namespace prefix="saml">urn:oasis:names:tc:SAML:2.0:assertion</Namespace>
			</Namespaces>
			<XPath>/soap:Enveloper/soap:Header/wsse:Security/saml:Assertion</XPath>		★
		</Source>
		<TrustStore>TrustStoreName</TrustStore>											★
		<RemoveAssertion>false</RemoveAssertion>
	</ValidateSAMLAssertion>
	```
2.4. Quiz
2.4.1. OAuth and Network Security
	1. OAuth scope defines what the access token can do and what resources it can access?					True
	2. Which of the following is NOT an OAuth Grant Type?
		Authorization Code | Password | Implicit | None of the above | Client Credentials					None of the above
	3. Client Credential Grant Type is the Most Secure of the 4 OAuth Grant Types?					False
	4. Why would you want to use an Authorization Grant Type?											b. an app to acess resource
		a. If the Access Token expires too quickly and you want to extend it's lifespan.
		b. If there is a client application that wants access to a third party resource server.
		c. If you want all application developers from a trusted client to use the same ID.
	5. What's the primary difference in when to use Implicit Grant types over Authorization Grant Types?				b. untrusted browser based app
		a. Implicit Grant Types are used when the requesting application is trusted.
		b. Implicit Grant Types are used when the untrusted third party application is a browser based application written in a scripting language such as Javascript.
		c. Implicit Grant Types are no different that Authorization Grant Types in terms of the use case.
	6. Transport Security (TLS) protects....																The backend servers
		a. The front end UI.
		b. Backend Servers.
		c. The Application Source Code.

2.5. Optional: Optional Labs
2.5.1. Authorization Code Grant Type
	The authorization code grant type requires a step where the end user logs in to the resource server (where protected resources owned by the user are stored)
		and then gives explicit consent for the app to access those resources.
	The key to this flow is that the client app never gets to see the user's login credentials for the protected resources,
		as the authorization on the resource server is handled between the user, the resource server, and the OAuth authorization server.
	Implement the OAuth 2.0 authorization code grant type with Apigee Edge as the authorization server.
		REF: IETF specification https://tools.ietf.org/html/draft-ietf-oauth-v2-31
		Prerequisites
			- Login to enterprise.apigee.com
			- The name of the organization
			- node.js and npm https://nodejs.org/
			- Apigeetool https://www.npmjs.com/package/apigeetool
			- Yeoman http://yeoman.io/
			- Install oauth-auth-code-grant-sample generator: `npm install generator-oauth-auth-code-grant-sample -g`
			Note) No compatible in Windows 10
		Deploy
			> yo oauth-auth-code-grant-sample
			Follow the prompts to enter you user name, password, API URL Endpoint(https://api.enterprise.apigee.com), organization name and environment name.
		Test
			Open http://{myorg}-{myenv}.apigee.net/web
			Click the "Login with Apigee Example Auth" button to send a request to the authorization server (Apigee Edge), and which redirects the browser to a login page. Register or log in there.
			Give consent, also limit the type of access the app will have to the resources.
			Retrieve the access token.
		=> Flow summary
			- The login app communicates to the authorization server that the login was successful.
			- The authorization server generates an authorization code and returns it to the app.
			- The app puts the code into a request to the authorizatoin server for an access token, also with client ID and client secret keys.
			- The authorization server validates the auth code and other credentials, and if successful, returns an access token back to the client.
			- Now, with an access token, the client can request resources from the protected API.
	Flow diagram outlining the steps of this flow:
		Actors: User <--> User Agent <--> Webserver App (webserver-app bundle) <--> Authorization Server (oauth2 bundle) <--> Login App (login-app bundle) <--> User Store (user-mgmt-v1 bundle) <--> Resource Server
		```
		User --> User Agent			: Initiate
		User Agent --> Web App		: Initiate
		User Agent <-- Web App		: 200 OK, return Page with button to Login Page
		User --> User Agent			: user click on Login button
		User Agent --> Login App	: send to Login Page
		User Agent <-- Login App	: return login page
		In User Agent				: show login page
		User --> User Agent			: provide credentials
		User Agent --> Login App	: submit login
		Login App --> User Store	: send credentials
		In User Store				: validate credentials
		Login App <-- User Store	: credential response
		alt[Valid credentials]
		User Agent <-- Login App	: return consent form
		In User Agent				: show consent form
		User --> User Agent			: provide consent
		User Agent --> Login App	: submit consent
		Auth Server <-- Login App	: /oauth/UserAuthorize(client_id, redirect_url, scope, user-specific info)
		In Auth Server				: Validate request redirect_url against registered redirect_url for client_id
		In Auth Server				: Create authorization code w/ user-specific info
		Auth Server --> Login App	: 302 location redirect_url?code=(auth_code)&scope=(scope)
		User Agent <-- Login App	: 302 location redirect_url?code=(auth_code)&scope=(scope)
		User Agent --> Web App		: execute redirect: redirect_url?code=(auth_code)&scope=(scope)
		In Web App					: extract auth code and scope
		Web App --> Auth Server		: /oauth/token(client_id, client_secret, code, grant_type, scope, redirect_url)
		In Auth Server				: validate client_id, secret, and redirect_url(against redirect_url from auth code request)
		Web App <-- Auth Server		: return access token, scope, expiry time, refresh token
		Web App --> Auth Server		: get protected resource(access token)
		In Auth Server				: validate token
		Auth Server --> Resource Server : get resource
		Auth Server <-- Resource Server : return resource
		Web App <-- Auth Server		: return resource
		alt[Invalid credentials]
		User Agent <-- Login App	: return access denied
		User <-- User Agent			: show access denied
		```
	In summary:
		1. User initiates the flow by clicking a button in a web page.
		2. The user's browser is redirected to a login page. This login page is not under the control of the client app. The client app does not participate in the login interaction, and the client app never sees the user's username or password.
		3. If login is successful, the user is directed to a consent page. The consent page allows the user to specify scopes (what the client app is authorized to do with on behalf of the user).
		4. After consent is given, the login app communicates with the authorization server. If redirect_URI matches the redirect_URI in Apigee Edge for that client_id, the authorization server generates an authorization code and sends it back to the client app (via a previously specified redirect URI).
		5. The client app now has an authorization code and uses it to ask the authorization server for an access token.
		6. Upon receiving an access token, the client app is able to access the protected APIs on the resource server by including the access token with each call.
	Parts:
		login-app -- A complete implementation that includes a login page and a consent page. Implements session management for extra security. Essentially, this is an API proxy deployed on Apigee Edge. Most of the implementation is in Node.js. For information on the session management feature, see login-app/README.
		user-mgmt-v1 -- A key/value store implementation for storing the user's login information. Implemented as an API proxy and deployed on Apigee Edge. An interface to any user management system could be plugged in here, such as LDAP.
		webserver-app -- A very simple web page implemented as an API proxy (runs on Apigee Edge to simplify this example). This is the client app -- the target of the redirect URL to which tokens and other information are sent from the authorization server. This client app never sees the user's login credentials for the resource server.
		oauth2 -- An API proxy deployed on Apigee Edge that implements the OAuth 2.0 token endpoints. This is the Apigee Edge authorization server interface. Think of this as a service for requesting and managing OAuth tokens.
	Clean Up
		Use the clean up script to remove the entities (developers, apps, products) that were installed
		cd provisioning and ./cleanup.sh <OrgName> <Environment> <Username> <Password> <MSURL>. e.g. ./cleanup.sh myorg prod test@example.com apigee123 https://api.enterprise.apigee.com
	Further
		- See ./login-app/README for more information
		- Configure Loginapp
			1. Open login-app/apiproxy/resources/node/config/config.js
			2. Enter your environment information. The domain will typically be apigee.net. Some on-premise installations of Apigee Edge may use a different domain. For example:
			```
			exports.envInfo = {
			             org: 'Your org name on Edge',
			             env: 'Your environment on Edge (test or prod)',
			             domain: 'apigee.net'
			          };
			```
			3. Deploy the login-app bundle.
		- Provision the webserver-app
			1. CD to provisioning
			2. Open the file webserver-app.xml in an editor.
			3. Edit the <CallbackUrl> element, substituting your Edge organization and environment names.
			4. Execute: ./provision-webserver.sh username password orgName environment https://your-ms-url.com
			The provisioning script creates the required entities on Apigee Edge and returns two keys: consumer key and consumer secret in your terminal window. You'll need these values when you configure the webserver app.
		- Configure the webserver-app bundle
			1. Open webserver-app/apiproxy/policies/SetConfigurationVariables.xml
			2. Enter your values for appKey, appSecret, environment, and organization, as shown below.
			Important! You'll need to grab the Consumer ID and Consumer Secret that were returned when you provisioned the webserver-* entities in the previous step. Substitute those values in for the appKey and appSecret.
			```
			     <AssignMessage async="false" continueOnError="false" enabled="true" name="SetConfigurationVariables">
			          <DisplayName>SetConfigurationVariables</DisplayName>
			          <FaultRules/>
			          <Properties/>
			          <AssignVariable>
			              <Name>appKey</Name>
			              <Value>Substitute the Consumer key</Value>
			          </AssignVariable>
			          <AssignVariable>
			              <Name>appSecret</Name>
			              <Value>Substitute the Consumer secret</Value>
			          </AssignVariable>
			          <AssignVariable>
			              <Name>config.environment</Name>
			              <Value>Substitute your Edge environment (prod or test)</Value>
			          </AssignVariable>
			          <AssignVariable>
			              <Name>config.organization</Name>
			              <Value>Substitute your organization name on Edge</Value>
			          </AssignVariable>
			          <AssignVariable>
			              <Name>config.domain</Name>
			              <Value>apigee.net</Value>
			          </AssignVariable>
			          <AssignVariable>
			              <Name>config.protocol</Name>
			              <Value>https</Value>
			          </AssignVariable>
			          <IgnoreUnresolvedVariables>false</IgnoreUnresolvedVariables>
			      </AssignMessage>
			```
			3. Save the file.
			4. Open webserver-app/apiproxy/policies/HTMLIndex.xml
			5. Edit the BASEURL, REDIRECT, and CLIENT_ID variables as follows:
			BASEURL - The base URL for your environment -- use your organization and environment names on Edge. For example: https://myorg-prod.apigee.net
			REDIRECT - This is the Redirect URI.
			Note that this URI must exactly match the CallbackUrl element that you added to the webserver-app.xml configuration previously. For example: https://myorg-test.apigee.net/web/callback
			CLIENT_ID - The "Consumer Key" obtained from a developer app that is registered on Apigee Edge.
			Note that this key must match the one you configured previously in the webserver app.
			6. Save the file.
			7. Deploy webserver-app API proxy.


## COURSE: API Development on Google Cloud's Apigee API Platform
https://www.coursera.org/learn/api-development-apigee-gcp/home/welcome

### Module 1 - Getting Started with API Development

1.1. Welcome to Development
	covering the basics of the API proxy
	API functions like fault rules, logging, mediation, debugging
1.2. API Proxy Overview
1.2.1. What is a Proxy
	Common Proxy Types
		Open Proxy		Forward to another website another.com
		Reverse Proxy	Hide backend site
	API Proxy in Edge
		- gain a level of control and insight
		- insight into API usage
		- decouple
			shields consumer developers
			innovate of API Provider
			acts as a virtualzation layer
			compose multiple backend services
	API Proxy -> API Management
	API Proxy
		Inbound Request -> Proxy Endpoint	policies that make decisions about the request. e.g. Permission, limits, 
		        -> Target Endpoint			formatting of how requests to the backend systems
		-> Reponse -> Proxy Endpoint		
		          -> Target Endpoint		
		          -> Outbound

1.2.2. Anatomy of an API Proxy
	Platform Entities
		Organization
			Environment
	API Proxies
		Proxy Endpoint
		Target Endpoint
		Resources
	Proxy Endpoint
		Virtual Host, Flows, Route Rule, Fault Rules
	Virtual Host
	Policy Flows	PreFlow -> Conditional Flow -> PostFlow and PostClientFlow
		PreFlow					security related and red limiting policies
		Conditional Flow		
		PostFlow				mediation policies
		PostClientFlow			for logging messages after a response is returned to the client
	Route Rules
		URL
		Target Endpoint
		Conditional Targets		e.g. mock
		Null Target
	Target Endpoint
		Flows, Load Balancer, Fault Rules
	Fault Rules		exception handling
	HTTPProxyConnection		in ProxyEndpoint	
	HTTPTargetConnection	in TargetEndpoint	has a set of HTTP transport properties

1.2.3. Practice Quiz
	1/1 A ProxyEndpoint contains policies that affect the request and resonse to the backend?		FALSE	to the client not the backend!
		Client --(request)--> ProxyEndpoint -> TargetEndpoint -> Backend
		        <-- ProxyEndpoint <- TargetEndpoint <--(response)--/

1.2.4. Debugging Using Trace
	Trace Tool	DEVELOP menu > API Proxies > Select one > TRACE tab
		Transaction menu on the left
		Transaction map on the right

1.3. Lab: Building your first API Proxy
1.3.1. Building your first API Proxy in Apigee Edge
	This lab requires the completion of the labs in the `API Fundamentals and Design course`
	to build a pass-through API Proxy for an existing backend service.
	Use the OpenAPI specification created in the previous course to create an API proxy in Apigee Edge.
		Login to apigee.com/edge > `Develop API Proxies` menu item > + Proxy > Select `Reverse proxy` and click `Use OpenAPI`
			select the specification `products_spec` created earlier >  enter proxy details as below
				Proxy Name: Products
				Project Base Path: /v1
				Existing API: https://yourapigeeorgname-test.apigee.net/db
				Description: Product Information
			choose `Pass throught (none)`
			Ensure `test` environment is selected and click `Build and Deploy`
1.4. Lab: Test your Proxy
1.4.1. Test your Proxy
	Use `Postman` tool as a client to invoke the proxy.
	Go to Chrome Apps and launch Postman
	Click Import button to import the saved file downloaded from `https://raw.githubusercontent.com/apigeecs/apigee-engg-training-lab-resources/master/resources/Apigee-Edge-Dev-Training.postman_collection`.
	Also import the environment downloaded from `https://raw.githubusercontent.com/apigeecs/apigee-engg-training-lab-resources/master/resources/Apigee-Edge-Dev-Training.postman_environment`
	Then select the `Apigee-Edge-Dev-Training` environment and select the `Apigee-Edge-Dev-Training` collection
	Send the `GET /products/{id}` request and observe the response.
	You can also try with cURL or RESTClient, etc.
1.5. Lab: Deploy your Proxy
1.5.1. Deploying and Tracing your Proxy
	"deploy" an API Proxy means making its configuration active -- Apigee Edge begins listening for inbound requests on the base URL path and will execute the policy steps in the proxy configuration once request arrives. Then call the configured backend system and run the policies in the response flow when the response arrives.
	To deploy or undeploy a proxy,
		Edge UI > `Deployment` drop-down on the API Proxy page > click on environment name, green here means it is now deploying to.
			After undeployed, the request fails with "Unable to identify proxy for host". You can try GET /products/{id} on Postman tool after undeployed it.
	Click on the `TRACE` tab from the `Products` API Proxy page,
		select the correct environment from the `Deployment to Trace` drop-down,
			click the `Start Trace Session` button and then invoke the `GET /products/{id}` request in Postman
				check the transaction appears in the `Transactions` section and its flow in the `Transaction Map` section,
					click on the execution steps and review in the `Phase Details` section.
			after all, click on the `Stop Trace` button.
	References:
	- Build a simple API Proxy - http://docs.apigee.com/api-services/content/build-simple-api-proxy
	- Best practices for API proxy design and development - http://docs.apigee.com/api-services/content/best-practices-api-proxy-design-and-development
	- Apigee Docs: Trace - http://docs.apigee.com/api-services/content/using-trace-tool-0
	- Apigee Community on Tracing - https://community.apigee.com/topics/trace.html

1.6. Conditions and Route Rules
1.6.1. Conditions and Route Rules
	to control an API proxy behaviour and route the traffic to the correct endpoints for processing.
	Conditions
		- Dynamic processing at runtime
		- Defines operations on variables
		- Results are boolean
		- Allows chaining
	Condition Format: <Condition>{variable.name}{operator}{"value"}</Condition>
	Conditions - Proxy Execution	e.g. <Step><Condition>request.header.accept = "application/json"</Condition><Name>XMLToJSON</Name></Step>
		NOTE: if you try to access a flow variable that is out of scope, you will receive a null value. No error will be generated.
	Conditions - Flow Execution		e.g. <Flow name="GetRequests"><Condition>request.verb = "GET"</Condition><Request/>...<Response/></Flow><Flow>...Another flow...</Flow>
		NOTE: The conditional flows are evaluated top to bottom, only the first one that evaluates to true is executed.
	Conditions - Target end point route selection
		<RouteRule name="xmlTarget"><Condition>request.header.Content-Type = "text/xml"</Condition><TargetEndpoint>XmlTargetEndpoint</TargetEndpoint></RouteRule>
	Pattern matching in Conditions
		- Matches
			- <Condition>(proxy.pathsuffix Matches "/cat")</Condition>
			- <Condition>(proxy.pathsuffix Matches "/*at")</Condition>
			- <Condition>(proxy.pathsuffix Matches "/cat*")</Condition>
			- <Condition>(proxy.pathsuffix Matches "/c%*at")</Condition>
			- <Condition>(proxy.pathsuffix ~ "/c%*at")</Condition>		// Exactly same as Matches
			- <Condition>(proxy.pathsuffix Like "/c%*at")</Condition>	// Exactly same as Matches
		- JavaRegex
			- <Condition>(proxy.pathsuffix JavaRegex "/cat")</Condition>
			- <Condition>(proxy.pathsuffix JavaRegex "/c*t")</Condition>
			- <Condition>(proxy.pathsuffix JavaRegex "/ca?t")</Condition>
			- <Condition>(proxy.pathsuffix JavaRegex "/[cbr]at")</Condition>
			- <Condition>(proxy.pathsuffix ~~ "/cat")</Condition>	// Exactly same as JavaRegex
		- MatchesPath
			- <Condition>(proxy.pathsuffix MatchesPath "/animals/*")</Condition>
			- <Condition>(proxy.pathsuffix MatchesPath "/animals/**")</Condition>
			- <Condition>(proxy.pathsuffix MatchesPath "/animals/*/wild/**")</Condition>
			- <Condition>(proxy.pathsuffix ~/ "/animals/*")</Condition>
			- <Condition>(proxy.pathsuffix LikePath "/animals/*")</Condition>
	Route Rule
		determines which target endpoint will handle the request, also allows API the flexibility to route to multiple target endpoints. e.g. can send requests to different backend servers.
		e.g.
		```xml
		<ProxyEndpoint name="default">
			<PreFlow/>
			<Flows>
				<Flow name="forecast"><Condition>proxy.pathsuffix MatchesPath &quot;/forecastrss%quot;</Condition></Flow>
			</Flows>
			<PostFlow/>
			<HTTPProxyConnection>
				<VirtualHost>default</VirtualHost>
				<BasePath>/v1/weather</BasePath>
			</HTTPProxyConnection>
			<RouteRule name="default">
				<TargetEndpoint>default</TargetEndpoint>
			</RouteRule>
		</ProxyEndpoint>
		```
		```xml
		<TargetEndpoint name="default">
			<PreFlow/>
			<Flows/>
			<PostFlow/>
			<HTTPTargetConnection>
				<URL>http://weather.apis.com</URL>
			</HTTPTargetConnection>
		</TargetEndpoint>
		```

		- No Target Routes, called "null route" - <RouteRule name="auth"><Condition>proxy.pathsuffix Matches "/auth"</Condition></RouteRule>
		  Use where the system can return data without having to be directed to a backend server.
		- Conditional Routes - <RouteRule name="routeToTestServer"><Condition>request.header.X-TestServer == "true"</Condition><TargetEndpoint>testServer</TargetEndpoint></RouteRule>
		- Default Routes, called "default route" - <RouteRule name="default"><TargetEndpoint>default</TargetEndpoint></RouteRule>

1.7. Lab: Conditions and Route Rules
1.7.1. Conditions and Route Rules
	Problem Statement: How to make changes to an OpenAPI Specification and push that change to the proxy?
	Solution:
		Learn the Create and Update Product operation here.
		Part 1: Update OpenAPI Specification
			`Develop Sepcs` in the side navigation menu
					click the `products_spec` to open the specification
						Have include new operations and definitaions - Create new product, Update Product and Product Availablity
							In the `Apigee Edge Spec Editor` replace the contents with `https://raw.githubusercontent.com/apigeecs/apigee-engg-training-lab-resources/master/resources/products-sku-openapi.json`
							NOTE: The Editor might suggest you to change to YAML format, click Cancel
						 Update the host property and click Save
							"host": "yourapigeeorgname-test.apigee.net",
		Part 2: Include the new operation as Conditional flow in Products proxy
			`Develop Proxies` > click Products to open the Overview tab
				click the `Develop` tab to open the development view
					click + button next to the `default` under `Proxy Endpoints`
						select the `From OpenAPI` tab in `New Conditional Flow` dialog window
							select all check boxes and click Add to create new sets of conditional flows in the proxy
								after all, click Save
			Invoke `GET /products/{id}/availability` request in Postman to see the product availability information.
		Part 3: Conditions and Route Rules
			Send the requests to different targets based on a Condition.
			Need to add CORS(Cross-origin resource sharing) support to the proxy.
			And first we start from adding `CORS preflight`. CORS preflight refers to sending a request to a server to verify if it supports CORS.
			Click the + button next to `default` under `Proxy Endpoints` to create a new Conditional flow for OptionsPreFlight,
				select the Manual tab and set as below to create a new flow, click Add and then click Save as well.
					```
					Flow Name: OptionsPreFlight
						Description: Adding CORS Support
						Condition Type: Custom
						Condition: request.verb == "OPTIONS" and request.header.origin != null AND request.header.Access-Control-Request-Method != null
					```
			Then in the Editor, MUST before the default `<RouteRule>` configuration, create a Null target RouteRule for the OPTIONS request as below.
				```
				<RouteRule name="NoRoute">
					<Condition>request.verb == "OPTIONS" AND request.header.origin != null
						AND request.header.Access-Control-Request-Method != null</Condition>
				</RouteRule>
				```
				Then click Save.
				Click OptionsPreFlight flow and then click the + Step button in its response flow,
					select `Assign Message policy` under the MEDIATION section and set as below
						Display Name: Add-CORS
						Name: Add-CORS
					and click Add,
					add the following in the policy.
					```
					<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
					<AssignMessage async="false" continueOnError="false" enabled="true" name="Add-CORS">
						<DisplayName>Add-CORS</DisplayName>
						<Properties/>
						<Add>
							<Headers>
								<Header name="Access-Control-Allow-Origin">{request.header.origin}</Header>
								<Header name="Access-Control-Allow-Headers">origin, x-requested-with, accept, content-type</Header>
								<Header name="Access-Control-Max-Age">3628800</Header>
								<Header name="Access-Control-Allow-Methods">GET, PUT, POST, DELETE</Header>
							</Headers>
						</Add>
						<IgnoreUnresolvedVariables>true</IgnoreUnresolvedVariables>
						<AssignTo createNew="false" transport="http" type="response"/>
					</AssignMessage>
					```
					after all click Save.
			To test, you can use CORS tester like `https://test-cors.org` and check if the Preflight OPTIONS call happens and the response headers are set as expected.

1.8. Quiz - Getting Started with API Development
	1/7 Where is the API Proxy typically located?		Between the Application and the Backend
	2/7 One of the advantages of an API proxy is that it hides the complexity of backend systems from the application developer?		TRUE
	3/7 3 primary componetns that make up an API Proxy?					Resources, Target Endpoint, Proxy Endpoint
	4/7 Which is a type of policy flow?									PreFlow, ConditionalFlow, PostFlow, PostClientFlow, [o] All of the above
	5/7 Trace is a useful tool when it comes to debugging an API?		TRUE
	6/7 Which of the following is the proper format for Conditions?		<Condition>{variable.name}{operator}{"value"}</Condition>
	7/7 Conditional Flows are evaluated top to bottom so you should include your catch all condition at the very bottom?		TRUE

### Module 2 - API Policies and Management
2.1. API Policies Overview
2.1.1. Module Overview
	Cover the various out of the box policies in the Apigee API platform, and how to create custom policies.
2.1.2. Policy Overview
	Policies are the fundamental building blocks that make up your API.
	What is a Policy?
		- is a module that implementes a specific, limited management function
		- by using policies, you can 'program' API behavior without writing any code
		- designed to let you add common types of management capabilities to an API easily and reliably
		- can also implement custom login in the form of JavaScript, Python, Java, and XSLT with extension policies
	Out of the box policies (pre-built policies)
		- Traffic management policies	Cache policies, Concurrent Rate Limit policy, Quota policy, Reset Quota policy, Spike Arrest policy
		- Mediation policies			Access Entity policy, Assign Message policy, Extract Variables policy, JSON to XML policy, Key Value Map Operations policy, Raise Fault policy, SOAP Message Validation policy, XML to SOAP policy, XSL Tranform policy
		- Security policies				Access Control policy, Basic Authentication policy, JSON Threat Protection policy, LDAP policy(On-Prem installation only), OAuth v2.0 policies, OAuth v1.0a policy, Regular Expression Protection policy, SAML Assertion policies, Verify API Key policy, XML Threat Protection policy
		- Extension policies			Java Callout policy, JavaScript policy, Message Logging policy, Python Script policy, Serice Callout policy, Statistics Collection policy		NOTE: Some are for Cloud Enterprise only
	Policies enable fine grain controls in the APi proxy
	Build APIs faster to help...
		- Traffic Management	manage interactions with API consumers and optimize performance
			Quota, Spike Arrest, Response Cache, Lookup Cache, Populate Cache, Invalidate Cache, Reset Quota
		- Mediation		transform, translate and reformat data for easy consumption
			JSON to XML, XML to JSON, Raise Fault, XSL Transform, SOAP Message Validation, Assign Message, Extract Variables, Access Entity, Key Value Map Operations
		- Security		secure APIs and protect back-end systems from attack
			XML Threat Protection, JSON Threat Protection, Regular Expression Protection, OAuth v2.0, Get OAuth v2.0 Info, OAuth v1.0a, Verify API Key, Access Control, Generate SAML Assertion, Validate SAML Assertion
		- Extension		extend with programming when you need it
			Java Callout, Python, JavaScript, Service Callout, Statistics Collector, Message Logging
2.1.3. Traffic Management
	Some quick walkthrough example scenarios:
	Spike Arrest
		- protect target backend against severe traffic spikes and DoS attacks
		- control requests by second and minute
		- typically used in "preflow"
	Quota		Quota, Reset Quota
		- limit number of requests over a period of time
		- able to limit for everyone, or configure based on product, developer, etc.
		- typically used in "preflow"
		- `Reset Quota` policy to reset it
	Concurrent Rate Limit
		- used to limit the number of concurrent connections, throttles inbound connections from Edge to backend services
		- NOT typically used but is available
		- attach to both the request and response flows in the Target endpoint
	Response Cache
		- cache the whole HTTP response (body, headers, status code, etc)
		- can improve performance by retrieving response from the cache instead of back end
		- attach in both the request and response flows
		- typically only used with GET calls
	Cache		Lookup Cache, Populate Cache, Invalidate Cache
		- cache specific pieces of data within the proxy
		- examples: tokens, service callout responses, data from previous calls, etc.
		- control the cache by "populate", "lookup", "invalidate"

2.1.4. Practice Quiz
	1/1	API Policies can NOT be strung together in an API proxy. Only one API policy can exist in an API proxy?			FALSE

2.2. Lab: Traffic Management
2.2.1. Spike Arrest
	TODO... lab

2.2.2. Quota
	TODO... lab
	References
		Spike Arrest Policy - http://docs.apigee.com/api-services/reference/spike-arrest-policy
		Rate Limiting - http://docs.apigee.com/api-services/content/rate-limiting
		Quota Policy Reference - http://docs.apigee.com/api-services/reference/quota-policy
		Community post on setting up dynamic quotas https://community.apigee.com/questions/1488/how-do-the-quota-settings-on-an-api-product-intera.html
		Comparing Rate Limiting Policies - http://docs.apigee.com/api-services/content/comparing-quota-spike-arrest-and-concurrent-rate-limit-policies

2.3. API Policies Overview (continued)
2.3.1. Mediation
	Mediation covers the group of policies that interact with, and have the ability to transform the request in response as your proxy executes.
	In this module, we'll review the Apigee Edge policies specific to mediation.
	JSON to XML, XML to JSON
		TODO...
	XSL Transform
	SOAP Message Validation
	Assign Message
	Extract Variables
	Extract Variables + Assign Message
	Raise Fault
	Call All Flow Example
	Access Entity
	Key Value Map (KVM) Operations
	
2.3.2. API Security
	Cover all the policies that pertain to security within the Apigee Edge Management Platform.
	Basic Authentication
	XML, JSON Regex, Threat Protection
	Verify API Key Policy
	OAuth v1.0a
	OAuth v2
	SAML		Generate SAML Assertion, Validation SAML Assertion
	Access Control
	
2.4. Lab: Mediation and Security
2.4.1. Mediation
	TODO...
2.4.2. Security
	TODO...
	References
		Assign Message Policy - https://docs.apigee.com/api-services/reference/assign-message-policy
		Basic Authentication Policy - https://docs.apigee.com/api-services/reference/basic-authentication-policy

2.5. Quiz - API Policies and Management
	1/4	In Apigee Edge, if an out of the box policy is not provided, you can create your own custom policy?		=> TRUE
	2/4	The Spike Arrest policy helps protect against a severe spike in traffic and denial of service attacks. As such, where should this policy typically be located?		PreFlow/PostFlow/ConditionalFlow/PostClientFlow	=> PreFlow
	3/4	Mediation refers to which of the following?			=> The ability to transform the request and response. NOT: The ability to secure your API through authentication; The ability to manage traffic coming into your API; The ability to capture analytics on the API performance
	4/4	As a recommendation, OAuth v2 is preferred over OAuth v1.0a				=> TRUE
### Module 3 - Target Servers and API Products
3.1. Target Servers
	Key Concepts
	- Compare the various types of API product strategies
	- Apply Named Target Servers to your API proxies
	- Build in authentication to a target server
3.1.1. Module Overview
	- discover how to secure and name Target Servers in Apigee Edge
	- provide an overview of the commonly used methods to productize APIs
	- API products is an important topic covered in the Fundamentals course so we'll be showing you how to bundle the API proxies you have created into "products"
	- Hands on exercises are included to walk you through the process.
3.1.2. Dealing with Secure Target Server
	Building Target Authentication
	- Hard Code
	- Build Time Replacement
	- Using Node.js Access Vault		NOTE: Only Node.js
	- Using Key Value Map
	TODO...
3.1.3. Setting up a Named Target Server
	Exiting Target URL
	TODO...
	Target Server with SSL
	Multiple Target Servers
	Load Balancer
	- RoundRobin
	- Weighted
	- LeastConnection
	Health Monitor - HTTPMonitor
	Health Monitor - TCPMonitor
3.2. Lab: KVM and Target Server Creation
3.2.1. Secure Target Server
	Problem: hard-coding the auth credentials in Assign Message policy might have to be changed when promoted to other environments
	Solution: By using encrypted Key Value Maps
	TODO...
3.2.2. Setting Up Named Target Server
	Admin > Environments
	TODO...

3.3. API Products
3.3.1. Product Design
	Product Overview
	TODO...
	Product Strategies
	- API Proxy Model		1-to-1	api proxy to product
	- Business Model		business unit. multiple API resources to product
	- Ownership Model		dev team unit. multiple API resources to product
	- Service Plan Model	by service level e.g. Bronze, Gold plan grouping API resources to product
3.4. Lab: Product, Developer, and Developer Apps
3.4.1. Product, Developer, and Developer App
	Publish > +API Product
	Publish > Developers,  +Developer
	Publish > Apps
	Verify API Key policy
	TODO...
	
3.5. Quiz - Target Servers and API Products
	TODO...
### Module 4 - Error Handling and Logging
4.1. Error Handling and Logging
4.1.1. Module Overview
	TODO...
4.1.2. Fault Rules and Error Responses
	Terminology
	- Raise Fault policy
	- Edge raises an error during policy execution
	- Fault Rule = Fault Handler ()
	TODO...
	Fault handling
	Rewrite Backend Error Response
	Raise Fault policy
	
4.1.3. Logging
	Edge Logging Services
	Message Logging Policy		that is an asynchronous flow in the ProxyEndpoint in the PostClientFlow. If it include the message logging policy here, then Apigee will log the message after the response is sent to the client.
	TODO...
4.2. Lab: Fault Rules Error Responses and Logging
4.2.1. Fault Rules Error Responses
	TODO...
4.2.2. Logging to External Service Provider - Loggly
	TODO...
4.3. Quiz - Error Handling and Logging
	TODO...

### Module 5 - Shared Flows, Flow Hooks, and Extensions
5.1. Shared Flows and Flow Hooks, Flow Hooks, and Extensions
5.1.1. Module Overview
	TODO...
5.1.2. Shared Flows and Flow Hooks
	What is a Shared Flow?
	TODO...
	Flow Hooks
	- Pre-proxy Flow Hook
	- Pre-target Flow Hook
	- Post-target Flow Hook
	- Post-poxy Flow Hook
5.1.3. Extentions
	JavaScript Callout
	TODO...
	Flow Callout		Calls out to a shared flow
	Statistics Collector		
5.2. Lab: Shared Flows
5.2.1. Shared Flows and Flow Hooks
	TODO...
5.3. Quiz - Shared Flows and Flow Hooks
	TODO...
5.4. Optional: Optional Labs
5.4.1. Extensions - Java
	TODO...
5.4.2. Extensions - Python
	TODO...
5.4.3. Honors Lesson Completion
	TODO...
### Module 6 - Mediation, Caching, and Node.js Integration
6.1. Service Callout and Advance Mediation
6.1.1. Moduule Overview
6.1.2. Service Callout and Mash Ups
6.1.3. Advance Mediation with XSL and SOAP
6.1.4. Practice Quiz
6.2. Lab: Mediation and Caching
6.2.1. Service Callout
6.2.2. Advanced Mediation
6.3. Caching and Analytics
6.3.1. Caching
6.3.2. Edge Analytics
6.4. Lab: Caching and Analytics
6.4.1. Caching
6.4.2. Edge Analytics
6.5. Node.js Integration and Deployment Tools
6.5.1. Node.js Integration with Apigee Edge
6.5.2. Packaging and Deployment
6.6. Lab: Node.js Integration and Deployment Tools
6.6.1. Node.js Integration with Edge
6.6.2. Deployment Tools
6.7. Quiz - Advance Development Topics


## COURSE: Install and Manage Google Cloud's Apigee API Platform
TODO...

## COURSE: On Premises Management, Security, and Upgrade with Google Cloud's Apigee API Platform
## COURSE: On Premises Installation and Fundamentals with Google Cloud's Apigee API Platform
## COURSE: On Premises Capacity Upgrade and Monitoring with Google Cloud's Apigee API Platform

## COURSE: Developing APIs with Google Cloud's Apigee API Platform Specialization
https://www.coursera.org/specializations/apigee-api-gcp
TODO...







