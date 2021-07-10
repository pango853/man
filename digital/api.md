

https://www.moesif.com/blog/technical/api-gateways/How-to-Choose-The-Right-API-Gateway-For-Your-Platform-Comparison-Of-Kong-Tyk-Apigee-And-Alternatives/
How to choose the right API Gateway for your platform: Comparison of Kong, Tyk, Apigee, and alternatives,  March 06, 2019

Major players in the API Gateway Space
Kong

Kong is an open source API gateway that is build on top of (NGINX.) which is a very popular open source HTTP proxy server. Even though Kong is open source, KongHQ provides maintenance and support licenses for large enterprise. While basic features are had with the open-source version, certain features like the Admin UI, Security, and developer portal are available only with an enterprise license.

Deployment: one of the biggest advantages of Kong is its wide range of installation options, with pre-made containers such as Docker and Vagrant so you can get a deployment running quickly. NGINX is the most popular HTTP server after Apache and IIS and also very high performing even at high request rates. NGINX has a huge community of Lua scripts and extensions so you won’t be left in the dust when looking for some customization. Kong has moderate complexity when it comes to deployment. It does require running Cassandra or Postgres. Some plugins such as the rate-limiting one optionally require additional data stores such as Redis. However, a production deployment isn’t as complicated as Apigee.

Feature Completeness: Kong out of box provides many expected features of API Management, such as creating API keys, Routing to multiple microservices, etc. It doesn’t have a lot of transformation layer (mostly HTTP based transformation, no SOAP or to XML). However, if you don’t have many legacy apps, you probably don’t need the extra weight of data transformation layers anyway. Even though it comes with rate limiting, it doesn’t have billing integrations. The administration and management task can be performed via CLI or curl commands to a REST API which makes management easier to integrate within your existing devops playbooks.

Kong has the concept of services, routes, and consumers which provide a lot of flexibility when dealing with hundreds microservices that compose your API and different types of consumers calling your APIs. This enables plugins and transformations to be attached to a specific route or even a single consumer.

Kong has a large community of community developed Plugins, they launched Kong Hub in 2018, and it already have dozens of plugins. Moesif is one of the plugins there.

Kong is one of our highly recommended API gateways. If you don’t need the legacy baggage and want a popular open source API gateway, you can’t go wrong with Kong. It’s modern, designed for managing modern microservices rather than just adding a transformation facade to legacy monoliths, and has a rapidly growing community of plugins from API analytics like Moesif to caching layers and and verifying JWT (JSON Web Tokens).