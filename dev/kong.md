
enterprise level support:
https://konghq.com/kong-enterprise-edition/


# Components

admin interface
	https://konghq.com/api-admin-gui/
developer portal 
	https://konghq.com/api-dev-portal/

# Features

- API Routing - The API object describes an API that’s being exposed by Kong. Kong needs to know how to retrieve the API when a consumer is calling it from the Proxy port. Each API object must specify some combination of hosts, URIs, and methods
- Consumers - The Consumer object represents a consumer - or a user - of an API. You can either rely on Kong as the primary datastore, or you can map the consumer list with your database to keep consistency between Kong and your existing primary datastore.
- Certificates - A certificate object represents a public certificate/private key pair for an SSL certificate.
- Server Name Indication (SNI) - An SNI object represents a many-to-one mapping of hostnames to a certificate.

API Mangement core aspects:
- Authentication - Protect your services with an authentication layer.
- Traffic Control - Manage, throttle, and restrict inbound and outbound API traffic.
- Analytics - Visualize, inspect, and monitor APIs and microservice traffic.
- Transformations - Transform requests and responses on the fly.
- Logging - Stream request and response data to logging solutions.

Added scalable features:
- DNS-based load balancing - When using DNS based load balancing the registration of the backend services is done outside of Kong, and Kong only receives updates from the DNS server.
- Ring-balancer - When using the ring-balancer, the adding and removing of backend services will be handled by Kong, and no DNS updates will be necessary.
- Clustering - A Kong cluster allows you to scale the system horizontally by adding more machines to handle more incoming requests. They will all share the same configuration since they point to the same database. Kong nodes pointing to the same datastore will be part of the same Kong cluster.
- Plugins - lua-nginx-module enables Lua scripting capabilities in Nginx. Instead of compiling Nginx with this module, Kong is distributed along with OpenResty, which already includes lua-nginx-module. OpenResty is not a fork of Nginx, but a bundle of modules extending its capabilities.
- API - Administrative API access for programmatic control.
- CLI Reference - The provided CLI (Command Line Interface) allows you to start, stop, and manage your Kong instances. The CLI manages your local node (as in, on the current machine).
- Serverless - Invoke serverless functions via APIs.



# API
https://getkong.org/docs/0.12.x/admin-api/

# community editions
KongDash - https://ajaysreedhar.github.io/kongdash/
Konga - Kong GUI, make it a much richer ecosystem
Kong Manager - https://docs.konghq.com/enterprise/1.3-x/kong-manager/overview/

# Enterprise editions

コミュニティ版とエンタープライズ版の棲み分けに関わる課題を緩和するもう1つの手段に、クラウドサービスの提供があります。(2018年提供予定らしい)

# References
- https://dzone.com/articles/a-summary-of-kong-as-an-api-management-solution
- http://management.apievangelist.com/
