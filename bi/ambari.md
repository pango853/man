
http://www.olric.org/2019/09/install-single-node-hortonworks-data.html

http://www.pathpilot.jp/blog/2020/02/post-53afd6.html
https://qiita.com/hkajikawa/items/96205a41ba9f57835e09
https://qiita.com/blueskyarea/items/4bf76de90e98c992b14e
http://steavevaivai.hatenablog.com/entry/2018/04/28/231104


https://blog.codecentric.de/en/2014/05/lambda-cluster-provisioning/
https://www.adaltas.com/en/2018/01/17/ambari-how-to-blueprint/


Lambda Architecture
	example:
	- a Hadoop 2 cluster with HDFS (to store files),
	- HBase (to store precomputed views – both views created in batch processes as well as realtime views),
	- Storm (to process data in realtime),
	- Map Reduce (to process data as batches) and finally
	- Pig to make it easier to create views.
	- use Tez to speed up our processing.





# Blueprint
blueprint - Systematic way of defining a cluster

- Configs + 
- Topology +
- Hosts +
= Cluster

Export existing cluster into blueprint
/api/v1/clusters/:clusterName?format=blueprint


- Blueprint Host Discovery
```POST /api/v1/clusters/MyCluster/hosts
[
  {
    "blueprint" : "single-node-hdfs-test2",
    "host_groups" :[
      {
      "host_group" : "slave",
      "host_count" : 3,
      "host_predicate" : "Hosts/cpu_count>1”
      }, {
		"host_group" : "super-slave",
		"host_count" : 5,
		"host_predicate" : "Hosts/cpu_count>2&       Hosts/total_mem>3000000"
      }
    ] 
  }
]

```


## Create a cluster with Blueprints

```POST /api/v1/blueprints/my-blueprint
{
 "configurations" : [
    {
      "hdfs-site" : {
		"dfs.datanode.data.dir" : "/hadoop/1,/hadoop/2,/hadoop/3"
      }
    }
  ],
 "host_groups" : [
    {
      "name" : "master-host",
      "components" : [
      { "name" : "NAMENODE” },
      { "name" : "RESOURCEMANAGER” },
      ...
      ],
      "cardinality" : "1"
    },
    {
      "name" : "worker-host",
      "components" : [
      { "name" : "DATANODE" },
      { "name" : "NODEMANAGER” },
      ...
      ],
      "cardinality" : "1+"
    },
  ],
  "Blueprints" : {
    "stack_name" : "HDP",
    "stack_version" : "2.5"
  }
}
```

```POST /api/v1/clusters/my-cluster
{
  "blueprint" : "my-blueprint",
  "host_groups" :[
    { 
      "name" : "master-host",  
      "hosts" : [          
        { 
          "fqdn" : "master001.ambari.apache.org"
        }
      ]
    },
    { 
      "name" : "worker-host",  
      "hosts" : [          
        { 
          "fqdn" : "worker001.ambari.apache.org"

  },
        { 
          "fqdn" : "worker002.ambari.apache.org"

  },
        ...
        { 
          "fqdn" : "worker099.ambari.apache.org"

  }
      ]
    }
  ]
}
```


basic structure:
```
  "configurations" : [{ ... }, { ... }, ... ],
  "host_groups" : [{ ... }, { ... }, ... ],
  "Blueprints" : { ... }
}
```

```GET   /api/v1/clusters/c1/configurations 
	- shows you which configuration types and tags you are using
```
```GET   /api/v1/clusters/c1/configurations?type=INSERT_TYPE&tag=INSERT_TAG
	- then shows you the setting values (tag normally equals 1)
```

```
"host_groups":[
  { "name":"host_group_1",
    "components":[
      { "name":"ZOOKEEPER_SERVER" },
      { "name":"ZOOKEEPER_CLIENT" },
      { "name":"AMBARI_SERVER" },
      { "name":"NAMENODE" },
      { "name":"HDFS_CLIENT" },
      { "name":"SECONDARY_NAMENODE" },
      { "name":"DATANODE" }, ... ],
    "cardinality":"1" }, ... ]
```

The component names are Ambari specific, for convenience you can find the the HDP-2.1 services with their components below.

- HDFS		DATANODE, HDFS_CLIENT, JOURNALNODE, NAMENODE, SECONDARY_NAMENODE, ZKFC
- YARN		APP_TIMELINE_SERVER, NODEMANAGER, RESOURCEMANAGER, YARN_CLIENT
- MAPREDUCE2	HISTORYSERVER, MAPREDUCE2_CLIENT
- GANGLIA		GANGLIA_MONITOR, GANGLIA_SERVER
- HBASE		HBASE_CLIENT, HBASE_MASTER, HBASE_REGIONSERVER
- HIVE		HIVE_CLIENT, HIVE_METASTORE, HIVE_SERVER, MYSQL_SERVER
- HCATALOG	HCAT
- WEBHCAT		WEBHCAT_SERVER
- NAGIOS		NAGIOS_SERVER
- OOZIE		OOZIE_CLIENT, OOZIE_SERVER
- PIG		PIG
- SQOOP		SQOOP
- STORM		DRPC_SERVER, NIMBUS, STORM_REST_API, STORM_UI_SERVER, SUPERVISOR
- TEZ		TEZ_CLIENT
- FALCON		FALCON_CLIENT, FALCON_SERVER
- ZOOKEEPER	ZOOKEEPER_CLIENT, ZOOKEEPER_SERVER

> GET   /api/v1/clusters/YOUR_CLUSTER_NAME?format=blueprint
	- gives you the exact component combination of a cluster as raw blueprint
		(without the cluster configuration!)

# Host Mapping

```
{ "blueprint":"blueprint-c1",
  "host-groups":[
    { "name":"host_group_1",
      "hosts":[
        { "fqdn":"one.cluster",
          "ip":"192.168.0.101" }, ... ] }, ... ] }
```

to create the cluster

```
POST  /api/v1/blueprints/BLUEPRINT_NAME    blueprint.json
	- makes the blueprint available to ambari
 
POST  /api/v1/clusters/CLUSTER_NAME        hostmapping.json
	- merges the blueprint with the host mapping into a cluster
```

```
GET /api/v1/hosts
```


Repositories registration:

First, register your HDP repositories to use for the deployment.

```
curl -H "X-Requested-By: ambari" -u $user:$password -X PUT -d '{
  "Repositories" : {
    "base_url" : "$HDP_base_url",
    "verify_base_url" : true
  }
}' http://${ambari_host}:8080/api/v1/stacks/HDP/versions/${HDP_version}/operating_systems/${OS}/repositories/HDP-${HDP_version}
curl -H "X-Requested-By: ambari" -u $user:$password -X PUT -d '{
  "Repositories" : {
    "base_url" : "$HDP-UTILS_base_url",
    "verify_base_url" : true
  }
}' http://${ambari_host}:8080/api/v1/stacks/HDP/versions/${HDP_version}/operating_systems/${OS}/repositories/HDP-UTILS-${HDP-UTILS_version}
```

e.g. to register HDP 2.6 for RedHat 7 from hortonworks’ public repositories.

```
curl -H "X-Requested-By: ambari" -u admin:admin -X PUT -d '{
  "Repositories" : {
    "base_url" : "http://public-repo-1.hortonworks.com/HDP/centos7/2.x/updates/2.6.1.0",
    "verify_base_url" : true
  }
}' http://${ambari_host}:8080/api/v1/stacks/HDP/versions/2.6/operating_systems/redhat7/repositories/HDP-2.6

curl -H "X-Requested-By: ambari" -u admin:admin -X PUT -d '{
  "Repositories" : {
    "base_url" : "http://public-repo-1.hortonworks.com/HDP-UTILS-1.1.0.21/repos/centos7",
    "verify_base_url" : true
  }
}' http://${ambari_host}:8080/api/v1/stacks/HDP/versions/2.6/operating_systems/redhat7/repositories/HDP-UTILS-1.1.0.21
```



# Other examples

https://github.com/hortonworks/ansible-hortonworks/blob/master/playbooks/roles/ambari-blueprint/templates/blueprint_dynamic.j2
https://github.com/uprush/ambari-blueprint-examples/tree/master/blueprints/small-cluster
https://github.com/dstreev/hdp-blueprints-tutorial/blob/master/home-ha/README.md

https://github.com/uprush/ambari-blueprint-examples/blob/master/blueprints/streaming/streaming.json
https://opendev.org/openstack/sahara/src/commit/ca1d7c461b4d9304149e593859901faa72edd513/sahara/plugins/ambari/resources/configs-2.2.json

```
$ find / -name *-logsearch-conf.xml
	/var/lib/ambari-server/resources/common-services/ACCUMULO/1.6.1.2.2.0/configuration/accumulo-logsearch-conf.xml
	/var/lib/ambari-server/resources/common-services/AMBARI_INFRA/0.1.0/configuration/infra-logsearch-conf.xml
	/var/lib/ambari-server/resources/common-services/AMBARI_METRICS/0.1.0/configuration/ams-logsearch-conf.xml
	/var/lib/ambari-server/resources/common-services/ATLAS/0.1.0.2.3/configuration/atlas-logsearch-conf.xml
	/var/lib/ambari-server/resources/common-services/FALCON/0.5.0.2.1/configuration/falcon-logsearch-conf.xml
	/var/lib/ambari-server/resources/common-services/FLUME/1.4.0.2.0/configuration/flume-logsearch-conf.xml
	/var/lib/ambari-server/resources/common-services/HBASE/0.96.0.2.0/configuration/hbase-logsearch-conf.xml
	/var/lib/ambari-server/resources/common-services/HDFS/2.1.0.2.0/configuration/hdfs-logsearch-conf.xml
	/var/lib/ambari-server/resources/common-services/HIVE/0.12.0.2.0/configuration/hive-logsearch-conf.xml
	/var/lib/ambari-server/resources/common-services/KAFKA/0.8.1/configuration/kafka-logsearch-conf.xml
	/var/lib/ambari-server/resources/common-services/KNOX/0.5.0.2.2/configuration/knox-logsearch-conf.xml
	/var/lib/ambari-server/resources/common-services/LOGSEARCH/0.5.0/configuration/logfeeder-custom-logsearch-conf.xml
	/var/lib/ambari-server/resources/common-services/OOZIE/4.0.0.2.0/configuration/oozie-logsearch-conf.xml
	/var/lib/ambari-server/resources/common-services/RANGER/0.4.0/configuration/ranger-logsearch-conf.xml
	...
	/var/lib/ambari-agent/cache/common-services/HIVE/0.12.0.2.0/configuration/hive-logsearch-conf.xml
	/var/lib/ambari-agent/cache/common-services/KAFKA/0.8.1/configuration/kafka-logsearch-conf.xml
	/var/lib/ambari-agent/cache/common-services/KNOX/0.5.0.2.2/configuration/knox-logsearch-conf.xml
	/var/lib/ambari-agent/cache/common-services/LOGSEARCH/0.5.0/configuration/logfeeder-custom-logsearch-conf.xml
	/var/lib/ambari-agent/cache/common-services/OOZIE/4.0.0.2.0/configuration/oozie-logsearch-conf.xml
	/var/lib/ambari-agent/cache/common-services/RANGER/0.4.0/configuration/ranger-logsearch-conf.xml
	/var/lib/ambari-agent/cache/common-services/RANGER_KMS/0.5.0.2.3/configuration/ranger-kms-logsearch-conf.xml
	/var/lib/ambari-agent/cache/common-services/SPARK/1.2.1/configuration/spark-logsearch-conf.xml
	/var/lib/ambari-agent/cache/common-services/SPARK2/2.0.0/configuration/spark2-logsearch-conf.xml
	/var/lib/ambari-agent/cache/common-services/STORM/0.9.1/configuration/storm-logsearch-conf.xml
	/var/lib/ambari-agent/cache/common-services/YARN/2.1.0.2.0/configuration/yarn-logsearch-conf.xml
	/var/lib/ambari-agent/cache/common-services/YARN/2.1.0.2.0/configuration-mapred/mapred-logsearch-conf.xml
	/var/lib/ambari-agent/cache/common-services/ZEPPELIN/0.6.0/configuration/zeppelin-logsearch-conf.xml
	/var/lib/ambari-agent/cache/common-services/ZEPPELIN/0.7.0/configuration/zeppelin-logsearch-conf.xml
	/var/lib/ambari-agent/cache/common-services/ZOOKEEPER/3.4.5/configuration/zookeeper-logsearch-conf.xml
```


# Comprehensive Security

Kerberos
- MIT KDC
- Keytab management
LDAP/AD
- User auth
- Sync
Ranger
- Security policies
- Audit
- Authorization
Atlas
- Governance
- Compliance
- Linage & history
- Data classification
Knox
- Perimeter security
- Supports LDAP/AD
- Sec. for REST/HTTP
- SSL



TODO:

https://medium.com/@deepeshtripathi/completely-uninstall-and-delete-hadoop-from-hosts-hortonworks-1a3f755afa20

