
# EXAMPLES

https://github.com/gitlabhq/gitlabhq/blob/master/lib/support/logrotate/gitlab

/var/log/gitlab/nginx/*.log {
    missingok
    notifempty
    sharedscripts
    postrotate
       /opt/gitlab/embedded/bin/sv 1 /opt/gitlab/service/nginx
    endscript
}

/var/log/gitlab/gitlab-rails/*.log {
    daily
    missingok
    rotate 40
    compress
    notifempty
    copytruncate
}

/var/log/gitlab/gitlab-shell/gitlab-shell.log {
    daily
    missingok
    rotate 40
    compress
    notifempty
    copytruncate
}
