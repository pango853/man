

# Configuring rsyslog to Receive log

```/etc/rsyslog.conf
# Define templates before the rules that use them

### Per-Host Templates for Remote Systems ###
$template TmplAuthpriv, "/var/log/remote/auth/%HOSTNAME%/%PROGRAMNAME:::secpath-replace%.log"
$template TmplMsg, "/var/log/remote/msg/%HOSTNAME%/%PROGRAMNAME:::secpath-replace%.log"

# Provides TCP syslog reception
$ModLoad imtcp
# Adding this ruleset to process remote messages
$RuleSet remote1
authpriv.*   ?TmplAuthpriv
*.info;mail.none;authpriv.none;cron.none   ?TmplMsg
$RuleSet RSYSLOG_DefaultRuleset   #End the rule set by switching back to the default rule set
$InputTCPServerBindRuleset remote1  #Define a new input and bind it to the "remote1" rule set
$InputTCPServerRun 10514
```

# Configuring rsyslog to send Receive 

```/etc/rsyslog.conf
*.info;mail.none;authpriv.none;cron.none               @@logging-server:10514
```

> $ logger -p local1.info -t abcd testing-001...


# Filters

```
*.* /var/log/file1 # the traditional way
if $msg contains 'error' then /var/log/errlog # the expression-based way

if $syslogfacility-text == 'local0' and $msg startswith 'DEVNAME' and ($msg contains 'error1' or $msg contains 'error0') then /var/log/somelog

if $syslogfacility-text == 'local0' and $msg startswith 'DEVNAME' and not ($msg contains 'error1' or $msg contains 'error0') then /var/log/somelog

```

# SELinux
```
# yum install policycoreutils-python
# semanage port -l | grep syslog
syslog_tls_port_t              tcp      6514, 10514
syslog_tls_port_t              udp      6514, 10514
syslogd_port_t                 tcp      601, 20514
syslogd_port_t                 udp      514, 601, 20514
# semanage port -l | grep 514
...
rsh_port_t                     tcp      514
syslogd_port_t                 tcp      6514, 601
syslogd_port_t                 udp      514, 6514, 601

# semanage port -a -t syslogd_port_t -p tcp 10514
# firewall-cmd --zone=zone --add-port=10514/tcp
# firewall-cmd --list-all

```