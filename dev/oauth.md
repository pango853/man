
# Code
OAuth libraries are available in a variety of languages.

Java
.NET
Python
PHP
Node.js
Ruby
Erlang
Go
Kotlin
Elixir
Rust
Perl
Objective C C
Swift
Scala
ColdFusion
JavaScript
QT / C++ / C++
Lua
Dart
ActionScript
PowerShell
Elm

# OAuth Services
REF: https://oauth.net/code/

## Open Source
Glewlwyd
Keycloak
OAuth.io
ORY Hydra		https://github.com/ory/hydra
SimpleLogin
SSQ signon

## Commercial
Auth0
Curity Identity Server
FusionAuth
Okta
Red Hat Single Sign-On


https://medium.com/securing/what-is-going-on-with-oauth-2-0-and-why-you-should-not-use-it-for-authentication-5f47597b2611

- do not use OAuth 2.0 itself for authentication (use OpenID Connect instead),
- use state parameter to prevent CSRF attacks,
- switch to authorization code type from of implicit type and use PKCE,
- implement short-lived and one-time use authorization codes,
- return the access token in the body of HTTP response to POST request using CORS,
- defend your frontend applications from XSS attacks that could steal tokens from localStorage,
- watch out for the open redirection vulnerabilities.


# Oauth Providers
REF: https://en.wikipedia.org/wiki/List_of_OAuth_providers

- 500px	1.0a	
- Amazon	2.0[1]	
- AOL	2.0[2]	
- Autodesk	1.0,2.0[3]	
- Apple	2.0[4]	Yes
- Basecamp	2.0[5]	No
- Battle.net	2.0[6]	
- Bitbucket	1.0a 2.0 [7]	No
- bitly	2.0	
- Box	2.0[8]	
- Cloud Foundry	2.0[9]	
- Dailymotion	2.0 draft 11[10]	
- Deutsche Telekom	2.0	
- deviantART	2.0 drafts 10 and 15	
- Discogs	1.0a	
- Discord	2.0[11]	
- Dropbox	1.0, 2.0[12]	
- Etsy	1.0[13]	
- Evernote	1.0a[14][15][16]	
- Facebook	2.0 draft 12[17]	No
- FatSecret	1.0, 2.0[18][19]	
- Fitbit	2.0	
- Flickr	1.0a	
- Formstack	2.0	
- Foursquare	2.0	
- GitHub	2.0[20]	No
- GitLab	2.0[21] x	Yes[22]
- Goodreads	1.0	
- Google	2.0[23]	Yes
- Google App Engine	1.0a, 2.0 [24]	Yes
- Groundspeak	1.0	
- Huddle	2.0	
- Imgur	2.0	
- Instagram	2.0[25]	No
- Intel Cloud Services	2.0	
- Jive Software	1.0a, 2.0	
- Keycloak	2.0[26]	Yes
- LinkedIn	1.0a, 2.0[27]	No
- Microsoft (Hotmail, Windows Live, Messenger, Active Directory, Xbox)	2.0	Yes
- Mixi	1.0[28]	
- MySpace	1.0a	
- Netflix	1.0a	
- Okta	1.0a, 2.0	Yes[29]
- OpenAM	2.0	
- OpenStreetMap	1.0, 1.0a[30]	
- OpenTable	1.0a	
- ORCID	2.0[31]	
- PayPal	2.0	
- Ping Identity	2.0	
- Pixiv	2.0	
- Plurk	1.0a[32]	
- Reddit	2.0[33]	
- Salesforce.com	1.0a, 2.0	Yes
- Sina Weibo	2.0	
- Spotify	2.0[34]	No
- Stack Exchange	2.0	
- StatusNet	1.0a	
- Strava	2.0	
- Stripe	2.0	
- Trello	1.0[35]	
- Tumblr	1.0a	
- Twitch	2.0	
- Twitter	1.0a, 2.0[36]	No
- Ubuntu One	1.0	No
- Viadeo	2.0[37]	
- Vimeo	2.0 [38]	No
- VK	2.0 [39]	No
- WeChat	2.0 [40]	No
- Withings	1.0 [41]	
- Woocommerce	1.0a	
- Wordpress	1.0a	
- WSO2 Identity Server	1.0a, 2.0	Yes
- Xero	1.0a	
- XING	2.0[42]	
- Yahoo!	1.0a, 2.0	
- Yammer	2.0	
- Yandex	2.0	
- Yelp	2.0 [43]	
- Zendesk	2.0

