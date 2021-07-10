
yum update
timedatectl set-timezone UTC
yum install -y epel-release wget

//wget -O /etc/yum.repos.d/scylla.repo http://repositories.scylladb.com/scylla/repo/034e7e01c68d4fe4400d48ae53744a7d/centos/scylladb-2.0.repo
sudo curl -o /etc/yum.repos.d/scylla.repo -L http://repositories.scylladb.com/scylla/repo/fa13500b-1166-4888-9f40-0a7d0e822d70/centos/scylladb-3.0.repo
yum install -y scylla scylla-server

scylla_setup
vim /etc/scylla/scylla.yaml
@see configutaion: http://docs.scylladb.com/system-configuration/

systemctl start scylla-server

nodetool status
cqlsh
cqlsh> CREATE KEYSPACE newdb WITH REPLICATION = { 'class' : 'SimpleStrategy', 'replication_factor' : 1 };
cqlsh> DESCRIBE KEYSPACES; system_traces system newdb
cqlsh> DESCRIBE KEYSPACES; system_traces system newdb
cqlsh> USE newdb ... ;
cqlsh:newdb> CREATE TABLE emp (id int PRIMARY KEY, name text, year text);
cqlsh:newdb> DESCRIBE tables; emp
cqlsh:newdb> DESC emp; CREATE TABLE newdb.emp ( id int PRIMARY KEY, name text, year text ) WITH bloom_filter_fp_chance = 0.01 AND caching = '{"keys":"ALL","rows_per_partition":"ALL"}' AND comment = '' AND compaction = {'class': 'SizeTieredCompactionStrategy'} AND compression = {'sstable_compression': 'org.apache.cassandra.io.compress.LZ4Compressor'} AND dclocal_read_repair_chance = 0.1 AND default_time_to_live = 0 AND gc_grace_seconds = 864000 AND max_index_interval = 2048 AND memtable_flush_period_in_ms = 0 AND min_index_interval = 128 AND read_repair_chance = 0.0 AND speculative_retry = '99.0PERCENTILE';
cqlsh:newdb> INSERT INTO emp (id, name, year) VALUES (1, 'Krishna', '2017');
cqlsh:newdb> INSERT INTO emp (id, name, year) VALUES (2, 'Chandra', '2317');
cqlsh:newdb> SELECT * FROM emp; id | name | year ----+---------+------ 1 | Krishna | 2017 2 | Chandra | 2317 (2 rows)
cqlsh:newdb> SELECT * FROM emp WHERE id=2; id | name | year ----+---------+------ 2 | Chandra | 2317 (1 rows)
cqlsh:newdb> SELECT * FROM emp; id | name | year ----+-----------+------ 5 | Namita | 2223 10 | Superna | 6623 16 | Olewaf | 3777 1 | Krishna | 2017 19 | Wqkdke | 2637 8 | Jeqya | 8937 2 | Chandra | 2317 15 | Luetea | 6993 9 | Namita | 2223 3 | Prajapati | 2237 (10 rows)
cqlsh:newdb> COPY emp(id, name, year) TO 'emp.csv'; Using 2 child processes Starting copy of newdb.emp with columns [id, name, year]. Processed: 10 rows; Rate: 19 rows/s; Avg. rate: 37 rows/s 10 rows exported to 1 files in 0.277 seconds. cqlsh:newdb> exit krishna@Ubuntu16:~$ cat emp.csv 16,Olewaf,3777 5,Namita,2223 15,Luetea,6993 8,Jeqya,8937 3,Prajapati,2237 1,Krishna,2017 19,Wqkdke,2637 10,Superna,6623 2,Chandra,2317 9,Namita,2223
cqlsh:newdb> SELECT * FROM emp; id | name | year ----+-----------+------ 5 | Namita | 2223 10 | Superna | 6623 16 | Olewaf | 3777 1 | Krishna | 2017 19 | Wqkdke | 2637 8 | Jeqya | 8937 2 | Chandra | 2317 15 | Luetea | 6993 9 | Namita | 2223 3 | Prajapati | 2237 (10 rows)
cqlsh:newdb> TRUNCATE newdb.emp; cqlsh:newdb> SELECT * FROM emp; id | name | year ----+------+------ (0 rows)
cqlsh:newdb> COPY emp(id, name, year) FROM 'emp.csv'; Using 2 child processes Starting copy of newdb.emp with columns [id, name, year]. Processed: 10 rows; Rate: 15 rows/s; Avg. rate: 23 rows/s 10 rows imported from 1 files in 0.430 seconds (0 skipped).
cqlsh:newdb> SELECT * FROM emp; id | name | year ----+-----------+------ 5 | Namita | 2223 10 | Superna | 6623 16 | Olewaf | 3777 1 | Krishna | 2017 19 | Wqkdke | 2637 8 | Jeqya | 8937 2 | Chandra | 2317 15 | Luetea | 6993 9 | Namita | 2223 3 | Prajapati | 2237 (10 rows)




cassandra-stress write -mode cql3 native 

@see monitoring: https://github.com/scylladb/scylla-grafana-monitoring



yum groupinstall -y "Development Tools"
yum install -y cmake
yum install -y libuv libuv-devel
yum install -y openssl openssl-devel
git clone https://github.com/datastax/cpp-driver.git
cd cpp-driver
git tag --list
git checkout 2.7.1
mkdir build
cd build
cmake -DCMAKE_INSTALL_PREFIX:PATH=/usr ..
make
make install

yum install -y gmp gmp-devel php-devel
pecl install cassandra

