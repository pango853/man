
https://developer.ibm.com/messaging/learn-mq/mq-tutorials/mq-connect-to-queue-manager/#ubuntu





Get message from queue
	./amqsgetc DEV.QUEUE.1 QM1


# Container


> docker run --env LICENSE=view ibmcom/mq:9.1.4.0
> docker run --env LICENSE=accept --env MQ_QMGR_NAME=QM1 --volume /var/example:/mnt/mqm --publish 1414:1414 --publish 9443:9443 --detach ibmcom/mq:9.1.4.0


https://your-ec2-hostname:9443/admin/ 


 Chapter 4: Mocking and simulating JMS IBM® WebSphere MQ

https://trafficparrot.com/tutorials/mocking-or-simulating-jms-ibm-websphere-mq.html


# Exporter

https://github.com/ibm-messaging/mq-metric-samples/tree/master/cmd/mq_prometheus



# References

https://developer.ibm.com/messaging/learn-mq/mq-tutorials/mq-connect-to-queue-manager/#ubuntu


MQ設計虎の巻: 第1回「WebSphere MQの特長と主な機能（前編）」
https://www.ibm.com/developerworks/jp/websphere/library/wmq/toranomaki/1.html
MQ設計虎の巻: 第2回「WebSphere MQの特長と主な機能（後編）」
https://www.ibm.com/developerworks/jp/websphere/library/wmq/toranomaki/2.html


# Monitoring

- amqsrua
  Monitoring system resource usage by using the amqsrua command
  https://www.ibm.com/support/knowledgecenter/SSFKSJ_9.0.0/com.ibm.mq.mon.doc/mo00013_.htm


- IBM MQ - IBM Middleware User Community
  https://community.ibm.com/community/user/imwuc/blogs/louis-horsley1/2020/04/06/uniform-cluster-monitor-application-resource-usage
  https://community.ibm.com/community/user/imwuc/communities/community-home/digestviewer/viewthread?GroupId=379&MID=13928&CommunityKey=183ec850-4947-49c8-9a2e-8e7c7fc46c64&tab=digestviewer
  
- https://github.com/ibm-messaging/mq-golang
  https://github.com/prometheus/client_golang
