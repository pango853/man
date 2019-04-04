
- How to remove credentials from Git
If `git config credential.helper` == manager

On Windows, go to Control Panel > click User Accounts and Family Safety / User Accounts.
In the left pane, click Manage your credentials.

# GitWeb
ln -s /usr/share/gitweb /srv/http/gitweb

# SSH

## Windows

> mkdir %USERPROFILE%\.ssh
> mkdir %USERPROFILE%\.ssh\config

```
Host bitbucket.org
  IdentityFile C:\Users\userName\.ssh\id_rsa_bitbucket.ppk
```

OR

```Git Bash
Host github.com
  User git
  Hostname ssh.github.com
  Port 443
  IdentityFile "c:\Users\$user_profile\.ssh\id_rsa"
  ProxyCommand connect.exe -H $proxyserver:$port %h %p

ssh -T git@github.com
```



# TODO

gitolite3.noarch
gitstats.noarch
git-lfs.x86_64
git-instaweb.noarch
git-email.noarch
git-cal.noarch
gitflow.noarch
Cloudron


[chansi@hail4snow contrib]$ repoquery -l gitweb
/etc/gitweb.conf
/etc/httpd/conf.d/git.conf
/usr/share/doc/gitweb-1.8.3.1
/usr/share/doc/gitweb-1.8.3.1/INSTALL
/usr/share/doc/gitweb-1.8.3.1/README
/var/www/git
/var/www/git/gitweb.cgi
/var/www/git/static
/var/www/git/static/git-favicon.png
/var/www/git/static/git-logo.png
/var/www/git/static/gitweb.css
/var/www/git/static/gitweb.js


