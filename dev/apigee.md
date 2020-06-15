
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

