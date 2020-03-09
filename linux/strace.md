
```sh

$ ps -ef | fgrep java
	root      24241      1  0 02:52 ?        00:00:00 /usr/bin/daemon --name=jenkins --inherit --env=JENKINS_HOME=/var/lib/jenkins --output=/var/log/jenkins/jenkins.log --pidfile=/var/run/jenkins/jenkins.pid -- /usr/bin/java -Djava.awt.headless=true -jar /usr/share/jenkins/jenkins.war --webroot=/var/cache/jenkins/war --httpPort=8080
	root      24242  24241  1 02:52 ?        00:00:54 /usr/bin/java -Djava.awt.headless=true -jar /usr/share/jenkins/jenkins.war --webroot=/var/cache/jenkins/war --httpPort=8080

$ pidof /usr/bin/java
	24242

# strace -tt -T -p 24242 -p 24241
OR
# strace -tt -T -p `pidof /usr/bin/java`


For multi-thread, use -f.
$ strace -tt -T -f -p `pidof rsyslogd`

# strace -tt -T -f -o rsyslogd-strace.log -p `pidof rsyslogd`

$ strace -tt -T -f -o echo-strace.log /bin/echo 'Happy Holidays!'


For filtering.
$ strace -f -p 1882 -e trace=stat
$ strace -f -e execve -p 26787

$ strace -c ls /hoge


$ strace -tt -s 1024 -p [pid]

```

