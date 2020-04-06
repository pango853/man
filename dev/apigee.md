


# Cousera

COURSES:
- Development Track
  - [x] API Design and Fundamentals of Google Cloud's Apigee API Platform
  - [ ] API Development on Google Cloud's Apigee API Platform
  - [ ] API Security on Google Cloud's Apigee API Platform
- Installation & Administration Track
  - [ ] Install and Manage Google Cloud's Apigee API Platform
  - On Premises Management, Security, and Upgrade with Google Cloud's Apigee API Platform
    - [x] On Premises Installation and Rundamentals with Google Cloud's Apigee API Platform
  - [ ] On-Premises Capacity Upgrade and Monitoring with Google Cloud's Apigee API Platform


## COURSE: API Design and Fundamentals of Google Cloud's Apigee API Platform

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
		Access Firebase Console and Import Data
			https://firebase.google.com -> Add project -> Create database (Realtime Database) -> Import JSON -> Update Firebase Rules with auth==null -> Publish
		Firebase REST API
			$ curl -X GET https://your-projectname.firebaseio.com/db/carts.json
			$ curl -X GET https://your-projectname.firebaseio.com/db/carts/{item-id}.json
		Deploy the edge-developer-training-backend proxy and dependencies
			unzip setup.zip
			cd setup
			npm install
			node setup
5.2. Lab: Creating an Open API Spec
5.2.1. Creating an Open API Spec
	https://apigee.com/edge -> select Organization -> Develop Specs -> + Spec -> Import URL... -> https://raw.githubusercontent.com/apigeecs/apigee-engg-training-lab-resources/master/resources/products-openapi.json -> Import
	Design-First approach: experimenting in a designer tool like Swagger UI before generating code
	Build-First approach: if there are exisitng back-end services and APIs. Starts from creating API Proxy first

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
2.1.3. Practice Quiz
2.1.4. Client Credentials Grant Type
2.1.5. Password Grant Type
2.1.6. AuthorizationCode Grant Type
2.1.7. Implicit Grant Type
2.1.8. Miscellaneous
2.2. Lab: OAuth
2.2.1. Client Credentials Grant Type
2.2.2. Password Grant Type
2.2.3. OAuth 2.0 - Misc
2.3. Transport Security and SAML
2.3.1. Transport Security(TLS)
2.3.2. SAML
2.4. Quiz
2.4.1. OAuth and Network Security
2.5. End of Specialization Wrap Up
2.5.1. Wrap Up
2.6. Optional: Optional Labs
2.6.1. Authorization Code Grant Type
2.6.2. Honors Labs Completion


## COURSE: API Development on Google Cloud's Apigee API Platform

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
	cover the various out of the box policies in the Apigee API platform, and how to create custom policies.
2.1.2. Policy Overview
	Policies are teh fundamental building blocks that make up your API.
2.1.3. Traffic Management
2.1.4. Practice Quiz
2.2. Lab: Traffic Management
2.2.1. Spike Arrest
2.2.2. Quota
2.3. API Policies Overview (continued)
2.3.1. Mediation
2.3.2. API Security
2.4. Lab: Mediation and Security
2.4.1. Mediation
2.4.2. Security
2.5. Quiz - API Policies and Management
### Module 3 - Target Servers and API Products
3.1. Target Servers
3.1.1. Module Overview
3.1.2. Dealing with Secure Target Server
3.1.3. Setting up a Named Target Server
3.2. Lab: KVM and Target Server Creation
3.2.1. Secure Target Server
3.2.2. Setting Up Named Target Server
3.3. API Products
3.3.1. Product Design
3.4. Lab: Product, Developer, and Developer Apps
3.4.1. Product, Developer, and Developer App
3.5. Quiz - Target Servers and API Products
### Module 4 - Error Handling and Logging
4.1. Error Handling and Logging
4.1.1. Module Overview
4.1.2. Fault Rules and Error Responses
4.1.3. Logging
4.2. Lab: Fault Rules Error Responses and Logging
4.2.1. Fault Rules Error Responses
4.2.2. Logging to External Service Provider - Loggly
4.3. Quiz - Error Handling and Logging

### Module 5 - Shared Flows, Flow Hooks, and Extensions
5.1. Shared Flows and Flow Hooks, Flow Hooks, and Extensions
5.1.1. Module Overview
5.1.2. Shared Flows and Flow Hooks
5.1.3. Extentions
5.2. Lab: Shared Flows
5.2.1. Shared Flows and Flow Hooks
5.3. Quiz - Shared Flows and Flow Hooks
5.4. Optional: Optional Labs
5.4.1. Extensions - Java
5.4.2. Extensions - Python
5.4.3. Honors Lesson Completion
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

