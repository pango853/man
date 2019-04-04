
# TRICKS

# 
https://github.com/settings/tokens

Settings > Developer settings > Personal access tokens

Select scopes > MUST check "repo" section to get the full control of private repositories.


curl https://api.github.com/?access_token=OAUTH-TOKEN

curl -u pango853 https://api.github.com
curl -u pango853:<PASSWD> https://api.github.com
curl -u :<TOKEN> https://api.github.com
curl -u :<TOKEN> https://api.github.com/orgs/<org-name>/repos
(!) Do even need username anymore


