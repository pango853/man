# References

- Administrator’s Guide | Database / Oracle / Oracle Database/ Release 20
  https://docs.oracle.com/en/database/oracle/oracle-database/20/multi/administering-a-cdb-with-sql-plus.html#GUID-2E5025EE-BED3-45A4-9EAA-B05C8DA66F97
- Database Concepts Home / Oracle Database Online Documentation Library, 12c Release 1 (12.1.0.2), 
  https://docs.oracle.com/database/121/CNCPT/cdbovrvw.htm#CNCPT89236
- Installation Guide for IBM AIX on POWER Systems (64-bit) | Database / Oracle / Oracle Database / Release 12.2
  https://docs.oracle.com/en/database/oracle/oracle-database/12.2/axdbi/creating-directories-for-oracle-database-files.html#GUID-BAA48B85-7B6D-4482-B2CB-CE3CFC82ABBD
- Database Security Guide | Home / Oracle Database Online Documentation Library, 12c Release 1 (12.1.0.2)
  https://docs.oracle.com/database/121/DBSEG/users.htm#DBSEG573
- Database Administrator’s Guide | Home / Oracle Database Online Documentation Library, 12c Release 1 (12.1.0.2)
  https://docs.oracle.com/database/121/ADMIN/cdb_mon.htm#GUID-208C0C35-D105-443B-B788-381F090B1D11
- Database 2 Day DBA | Home / Oracle Database Online Documentation Library, 12c Release 1 (12.1.0.2)
  https://docs.oracle.com/database/121/ADMQS/GUID-DE8A79BD-FAE4-4364-98FF-D2BD992A06E7.htm#ADMQS0361
- Database 2 Day Developer's Guide | Home / Oracle Database Online Documentation Library, 11g Release 2 (11.2)
  https://docs.oracle.com/cd/E11882_01/appdev.112/e10766/tdddg_connecting.htm#TDDDG99998



# Login
sqlplus "/ as sysdba"

sqlplus /nolog
SQL> connect / as sysdba

# Installation
## Install
https://docs.oracle.com/cd/E11882_01/server.112/e10897/install.htm


## Installing Oracle SQL*Plus on CentOS
https://www.oracle.com/database/technologies/instant-client/linux-x86-64-downloads.html

Download
    oracle-instantclientRELEASE-basic-VERSION.x86_64.rpm
    oracle-instantclientRELEASE-sqlplus-VERSION.x86_64.rpm

rpm -ivh oracle-instantclient12.1-basic-12.1.0.2.0-1.x86_64.rpm
rpm -ivh oracle-instantclient12.1-sqlplus-12.1.0.2.0-1.x86_64.rpm

~/.bash_profile
	ORACLE_HOME=/usr/lib/oracle/12.1/client64
	PATH=$ORACLE_HOME/bin:$PATH
	LD_LIBRARY_PATH=$ORACLE_HOME/lib
	export ORACLE_HOME
	export LD_LIBRARY_PATH
	export PATH

sqlplus "username/password@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=HOSTNAME_OR_IP)(PORT=1521))(CONNECT_DATA=(SID=MY_SID)))"
sqlplus "myuser/pass@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=192.168.10.1)(PORT=1521))(CONNECT_DATA=(SID=ASID)))"



# Commands

```
# systemctl list-units --type=service
OR
# systemctl --type=service
OR
# systemctl list-unit-files
# systemctl list-unit-files --type service --state enabled,generated
```

https://docs.microsoft.com/en-us/azure/virtual-machines/workloads/oracle/oracle-database-quick-create
$ sudo su - oracle
$ lsnrctl start

dbca -silent \
       -createDatabase \
       -templateName General_Purpose.dbc \
       -gdbname cdb1 \
       -sid cdb1 \
       -responseFile NO_VALUE \
       -characterSet AL32UTF8 \
       -sysPassword OraPasswd1 \
       -systemPassword OraPasswd1 \
       -createAsContainerDatabase true \
       -numberOfPDBs 1 \
       -pdbName pdb1 \
       -pdbAdminPassword OraPasswd1 \
       -databaseType MULTIPURPOSE \
       -automaticMemoryManagement false \
       -storageType FS \
       -ignorePreReqs


=> [INS-04008] Invalid combination of arguments passed from command line. One or more mandatory dependent arguments are not passed for the argument: -storageType

dbca -silent -createDatabase -templateName General_Purpose.dbc -gdbname orcl -sid orcl -responseFile NO_VALUE -characterSet AL32UTF8 -sysPassword {password} -systemPassword {password} -createAsContainerDatabase true -numberOfPDBs 1 -pdbName pdb1 -pdbAdminPassword Password1 -databaseType MULTIPURPOSE -automaticMemoryManagement false -storageType FS -ignorePreReqs 

dbca -silent \
 -createDatabase \
 -templateName General_Purpose.dbc \
 -gdbname cdb1 \
 -sid cdb1 \
 -responseFile NO_VALUE \
 -characterSet AL32UTF8 \
 -sysPassword OraPasswd1 \
 -systemPassword OraPasswd1 \
 -createAsContainerDatabase true \
 -numberOfPDBs 1 \
 -pdbName pdb1 \
 -pdbAdminPassword OraPasswd1 \
 -databaseType MULTIPURPOSE \
 -automaticMemoryManagement false \
 -storageType FS \
 -ignorePreReqs \
 -datafileDestination /u01/data


~/.bashrc file using editor of your choice.
	# Add ORACLE_HOME. 
	export ORACLE_HOME=/u01/app/oracle/product/12.2.0/dbhome_1 
	# Add ORACLE_SID. 
	export ORACLE_SID=cdb1


sqlplus / as sysdba
OR
sqlplus sys/{password} as sysdba 

exec DBMS_XDB_CONFIG.SETHTTPSPORT(5502);
select con_id, name, open_mode from v$pdbs;

alter session set container=pdb1;
alter database open;


https://novacontext.com/set-up-oracle-12c-on-linux-vm-in-azure/


SELECT DISTINCT OWNER FROM ALL_OBJECTS;
SELECT * FROM DBA_USERS;
select USERNAME, DEFAULT_TABLESPACE from DBA_USERS;
SELECT NAME FROM v$database;
SELECT TABLESPACE_NAME FROM USER_TABLESPACES;


sqlplus "sys/OraPasswd1@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=127.0.0.1)(PORT=1521))(CONNECT_DATA=(SID=CDB1)))"


//export ORACLE_HOME=/usr/lib/oracle/12.2/client64
export ORACLE_HOME=/usr/lib/oracle/18.5/client64

export LD_LIBRARY_PATH="$ORACLE_HOME/lib"
export PATH="$ORACLE_HOME/bin:$PATH"
sqlplus "sys/OraPasswd1@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=10.0.0.4)(PORT=1521))(CONNECT_DATA=(SID=cdb1)))" as sysdba



https://github.com/iamseth/oracledb_exporter/blob/master/default-metrics.toml
	sessions
	SELECT status, type, COUNT(*) as value FROM v$session GROUP BY status, type

	resource
	SELECT resource_name,current_utilization,limit_value FROM v$resource_limit

    SELECT * FROM sys.dba_data_files ddf;
    SELECT * FROM sys.dba_tablespaces dt;
    SELECT * FROM sys.dba_free_space dfs;

alter session set "_ORACLE_SCRIPT"=true;
CREATE USER prom IDENTIFIED BY PassW0rd;
GRANT ALL PRIVILEGES TO prom;

grant dba to prom;

GRANT ALL ON cdb1 TO prom;

SELECT
    username, 
    default_tablespace, 
    profile, 
    authentication_type
FROM
    dba_users
WHERE 
    account_status = 'OPEN';


# Prometheous Exporter

cd oracledb_exporter.0.2.6-ora18.5.linux-amd64/
	See https://oraclefact.wordpress.com/2018/04/05/client-server-interoperability-support-matrix-for-different-oracle-versions-doc-id-207303-1/

export DATA_SOURCE_NAME=system/OraPasswd1@10.0.0.4/cdb1

export DATA_SOURCE_NAME=sys/OraPasswd1@//10.0.0.4:1521/cdb1
./oracledb_exporter -log.level debug
./oracledb_exporter -log.level error -web.listen-address 9161


export DATA_SOURCE_NAME=system/OraPasswd1@//20.188.7.72:1521/cdb1



SELECT resource_name,current_utilization,limit_value FROM v$resource_limit;


# Architecture

## Multitenant

In the multitenant architecture, a container is a collection of schemas, objects, and related structures. A container appears to be a logically separate, independent database. Each container in a CDB has a unique ID and name.
"Enterprise database consolidation leads to greater scalability and improved resource utilization."

A container is classified either as a PDB or root container (also called the root). The root is a collection of schemas, schema objects, and nonschema objects to which all PDBs belong. The root does not store any user data.

A CDB has a single set of background processes and SGA that is used by all PDBs plugged into that CDB. A database instance is associated with a single CDB. A database instance cannot be shared between a non-CDB and CDB.

Every CDB has the following containers:
- One root container, called CDB$ROOT, that stores Oracle-supplied metadata and common users (database users known in every container belonging to that CDB).
- One seed PDB, called PDB$SEED—a system-supplied template that the CDB can use to create new PDBs. The seed PDB cannot be modified.
- 0 or more PDBs.

A PDB is a user-created entity containing a collection of schemas and schema objects that store the data and code required for an application. No PDBs exist when a CDB is first created. A PDB can be plugged into only one CDB at a time.

A CDB can have multiple PDBs plugged in at any given time, and each PDB exists in complete isolation from the other PDBs plugged into the same CDB. Each PDB retains granular control over its schemas and objects.

From the perspective of a user or application, the PDB appears as if it is a traditional non-CDB database. From the operating system perspective, the CDB is the database.


**Horizontal Partitioning of the Oracle Data Dictionary**
Horizontal partitioning of the Oracle data dictionary is at the heart of the multitenant architecture. This is a conceptual partitioning, not a physical table partitioning.

The CDB$ROOT root container contains a set of tablespaces and their data files, which implement the data dictionary tables to hold the metadata only for the Oracle system. The root’s metadata describes each PDB that is plugged into it. This metadata for a PDB is deleted from the root when that PDB is unplugged. The root, therefore, can be considered a metadatabase only.

Each PDB has its own set of tablespaces and corresponding data files that implement the data dictionary tables to hold an application’s metadata, and a set of tablespaces that hold the application’s user-defined data.

The root differs significantly from a PDB in that it never holds any user-defined data. Both the root and the PDBs have distinct data dictionaries and can be the “focus” of a foreground process. Therefore a session, at every moment of its lifetime, has a uniquely defined current container that it can access.


# Misc.

select * from v$database;
select instance_name from v$instance;

ALTER SESSION SET current_schema = other_user;

SELECT banner FROM v$version WHERE ROWNUM = 1;


CREATE TABLE contacts
( contact_id number(10) not null,
  last_name varchar2(50) not null,
  first_name varchar2(50) not null,
  address varchar2(50),
  city varchar2(50),
  state varchar2(20),
  zip_code varchar2(10),
  CONSTRAINT contacts_pk PRIMARY KEY (contact_id)
);
INSERT INTO contacts
(contact_id, last_name, first_name, address)
VALUES
(1000, 'Smith', 'Jane', '10 Somewhere St.');

INSERT ALL
 INTO contacts (contact_id, last_name, first_name, address) VALUES (1001, 'Smith1', 'Jane1', '11 Somewhere St.')
 INTO contacts (contact_id, last_name, first_name, address) VALUES (1002, 'Smith2', 'Jane2', '12 Somewhere St.')
 INTO contacts (contact_id, last_name, first_name, address) VALUES (1003, 'Smith3', 'Jane3', '13 Somewhere St.')
 INTO contacts (contact_id, last_name, first_name, address) VALUES (1004, 'Smith4', 'Jane4', '14 Somewhere St.')
SELECT 1 FROM DUAL;



oracledb_tablespace_bytes{tablespace="SYSAUX",type="PERMANENT"} 6.5011712e+08
oracledb_tablespace_bytes{tablespace="SYSTEM",type="PERMANENT"} 8.4934656e+08
oracledb_tablespace_bytes{tablespace="USERS",type="PERMANENT"} 5.24288e+06
oracledb_tablespace_bytes{tablespace="TEMP",type="TEMPORARY"} 3.4603008e+07
oracledb_tablespace_bytes{tablespace="UNDOTBS1",type="UNDO"} 2.9884416e+08


SET PAGESIZE 120;
SET LINESIZE 200;

SELECT resource_name,current_utilization,limit_value FROM v$resource_limit;


SELECT TABLESPACE_NAME, STATUS, BIGFILE FROM DBA_TABLESPACES;
SELECT FILE_NAME FROM DBA_DATA_FILES;
-- 表領域の使用量
SELECT
  D.TABLESPACE_NAME,
  MB, 
  AVAIL,
  ROUND((1 - (AVAIL / MB)) * 100) "USE%"
FROM
  (SELECT TABLESPACE_NAME, ROUND(SUM(BYTES) / (1024 * 1024)) MB
FROM DBA_DATA_FILES GROUP BY TABLESPACE_NAME) D,
  (SELECT TABLESPACE_NAME, ROUND(SUM(BYTES) / (1024 * 1024)) AVAIL
FROM DBA_FREE_SPACE GROUP BY TABLESPACE_NAME) F
WHERE D.TABLESPACE_NAME=F.TABLESPACE_NAME;



## SET
SQL> set timing on
SQL> set serverout on
SQL> set echo on
SQL> set termout on

## Local and Common Entities

```
SQL> show parameter COMMON_USER_PREFIX

NAME                              TYPE        VALUE
--------------------------------- ----------- -----------------
common_user_prefix                string      C##


SQL> CREATE USER C##CDB_DBA1 IDENTIFIED BY PWD CONTAINER=ALL;

User created.


SQL> SELECT con_id, username, user_id, common

  2  FROM cdb_users where username='C##CDB_DBA1'  ORDER BY con_id;

    CON_ID USERNAME                USER_ID COMMON
---------- -------------------- ---------- ------
         1 C##CDB_DBA1               102    YES
         2 C##CDB_DBA1               101    YES
         3 C##CDB_DBA1               107    YES
		 ...
```

## List all CDB database services

```
SQL> SELECT con_id, name, pdb FROM v$services ORDER BY con_id;

    CON_ID NAME                                     PDB
---------- --------------------------------------- -----------------

         1 EFUXDB                                   CDB$ROOT   <-- CDB Default Service 
         1 SYS$BACKGROUND                           CDB$ROOT   <-- CDB Default Service 
         1 SYS$USERS                                CDB$ROOT   <-- CDB Default Service 
         1 EFU.emilianofusaglia.net                 CDB$ROOT   <-- CDB Default Service 
         1 EFU_ADMIN.emilianofusaglia.net           CDB$ROOT   <-- CDB User-defined Service  
         3 mypdb.emilianofusaglia.net               MYPDB      <-- PDB Default Service 
         3 mypdb_app.emilianofusaglia.net           MYPDB      <-- PDB User-defined Service  

7 rows selected.
```

```
sqlplus <username>/<password>@<host_name>:<local-listener-port>/<service-name>
sqlplus application/pwd@oel7c-scan:1522/mypdb_app.emilianofusaglia.net
```


https://dzone.com/articles/oracle-12c-image-installation-in-docker



sqlplus /nolog
 
SQL> CONN / AS SYSDBA  -- OS認証でアイドルインスタンスに接続
SQL> STARTUP [FORCE] [RESTRICT] [PFILE=filename] NOMOUNT
-- データベースのマウント
SQL> STARTUP MOUNT [dbname]
-- データベースのオープン
SQL> STARTUP OPEN [ READ {ONLY|WRITE [RECOVER]}|RECOVER] [dbname]
-- NOMOUNT→MOUNT→OPEN の状態遷移は可能だが、逆は不可能
 
-- 省略時
SQL> STARTUP -- OPEN処理まで行う

## V$SESSION ビューを参照するための権限付与
V$SESSION の実体は正確にはビューではなく PUBLIC シノニム であるため、個別に参照権限を付与するにはビューの本体である SYS.V_$SESSION に対して設定を行なう。 ⇒ ORA-02030: 固定表/固定ビューでは選択のみ可能です。

SQL> GRANT SELECT ON V$SESSION TO rivus;
GRANT SELECT ON V$SESSION TO rivus
                *
行1でエラーが発生しました。:
ORA-02030: 固定表/固定ビューでは選択のみ可能です。
SQL> GRANT SELECT ON SYS.V_$SESSION TO rivus;
 
権限付与が成功しました。



# Docker
REF:
	https://hub.docker.com/_/oracle-database-enterprise-edition?tab=description
	

oracle-database-enterprise-edition
oracle-instant-client
12.2.0.1 
11.2.0.2  12.1.0.2  12.2.0.1  18.3.0  18.4.0  19.3.0

Official:
docker pull store/oracle/database-enterprise:12.2.0.1
	docker run -d -it --name <Oracle-DB> store/oracle/database-enterprise:12.2.0.1-slim

	docker run -d -it --name <Oracle-DB> -v OracleDBData:/ORCL store/oracle/database-enterprise:12.2.0.1
	docker run -d -it --name <Oracle-DB> store/oracle/database-enterprise:12.2.0.1
	docker run -d -it --name <Oracle-DB> -P store/oracle/database-enterprise:12.2.0.1
	docker port <Oracle-DB> 1521/tcp -> 0.0.0.0:<mapped host port>
	docker exec -it <Oracle-DB> bash -c "source /home/oracle/.bashrc; sqlplus /nolog"
		sqlplus sys/Oradoc_db1@ORCLCDB as sysdba

	docker run -d -it --name <Oracle-DB> -P --env-file ora.conf store/oracle/database-enterprise:12.2.0.1
	ora.conf
		DB_SID	default:ORCLCDB
		DB_PDB	default:ORCLPDB1
		DB_MEMORY	default:2GB
		DB_DOMAIN	default:localdomain



docker run --name <container name> \
-p <host port>:1521 -p <host port>:5500 \
-e ORACLE_SID=<your SID> \
-e ORACLE_PDB=<your PDB name> \
-e ORACLE_PWD=<your database passwords> \
-e ORACLE_CHARACTERSET=<your character set> \
-v [<host mount point>:]/opt/oracle/oradata \
oracle/database:19.3.0-ee

docker run --name oracle-ee -p 1521:1521 -v /home/oracle/myScripts:/opt/oracle/scripts/startup -v /home/oracle/oradata:/opt/oracle/oradata oracle/database:19.3.0-ee

## Basesize problem
Need to adjust disk size on Linux not using Overlay2 as storage driver.
```/etc/docker/daemon.json
{
  "storage-opts": ["dm.basesize=20G"]
}
```

## Build it yourself
> git clone https://github.com/oracle/docker-images.git

Download http://www.oracle.com/technetwork/database/enterprise-edition/downloads/index.html

cd docker-images/OracleDatabase/SingleInstance/dockerfiles/12.2.0.1
cp ~/Downloads/linuxx64_12201_database.zip .

cd ..
./buildDockerImage.sh -v 12.2.0.1 -e -i

mkdir ./oradata
chmod 777 ./oradata

vi docker-compose.yaml
```docker-compose.yaml
version: '2'
services:
  db:
    image: oracle/database:12.2.0.1-ee
    container_name: oracle
    ports:
      - 1521:1521
      - 5500:5500
    volumes:
      - ./oradata:/opt/oracle/oradata
    environment:
      - ORACLE_PWD=Oracle12
      - ORACLE_PDB=oracle
```

docker-compose up -d
docker logs -f oracle
docker exec -it oracle bash
	sqlplus SYSTEM/Oracle12@ORCLCDB
docker export --output="oracle12.2.0.1-ee" oracle

## Build it 2

REF: https://qiita.com/comefigo/items/d05c0e1977cc25e6b98a


## Pull from Oracle Registry
Register at https://container-registry.oracle.com/
docker login container-registry.oracle.com
docker pull container-registry.oracle.com/database/standard


## Options

- absolutapps/oracle-12c-ee
- https://github.com/padlik/oracle-12c-base
- https://github.com/bofm/docker-oracle12c
- docker pull mritschel/oracle12cr2_base
- docker pull registry.cn-hangzhou.aliyuncs.com/helowin/oracle_11g
- docker pull wnameless/oracle-xe-11g
- docker pull dockerhelp/docker-oracle-ee-18c


# Deep Dive

docker run -d --name oracleDB -v /home/oracle/oradata:/ORCL store/oracle/database-enterprise:12.2.0.1
docker exec -it oracleDB bash
	$ sqlplus / as sysdba
	SQL> show pdbs;
	SQL> alter session set container=ORCLPDB1;
	SQL> create user user1 identified by PassW0rd;
	SQL> grant connect, resource to user1;
	SQL> alter user user1 quota unlimited on users;
	SQL> conn user1/PassW0rd@ORCLPDB1
	SQL> create table demo1 (col1 number);
	SQL> insert into demo1 values (1);
	SQL> commit;
	SQL> SELECT * FROM demo1;
/u01/app/oracle/product/12.2.0/dbhome_1/admin/ORCLCDB/tnsnames.ora

	SQL> CREATE pluggable database ORCLPDB2 from ORCLPDB1 FILE_NAME_CONVERT=('/u02/app/oracle/oradata/ORCLCDB/orclpdb1/','/u02/app/oracle/oradata/ORCLCDB/orclpdb2/');
	SQL> show pdbs
	SQL> alter pluggable database ORCLPDB2 open;
	SQL> !vi;
	SQL> conn user1/PassW0rd@ORCLPDB2
	SQL> show con_name
	SQL> SELECT * FROM demo1;

	DBの複製
	SQL> conn / as sysdba;
	SQL> shutdown immediate;
	# cp -rp /home/oracle/oradata/* /home/oracle/oradata2/
	SQL> docker run -d --name oracleDB2 -v /home/oracle/oradata2:/ORCL store/oracle/database-enterprise:12.2.0.1
	SQL> docker exec -it oracleDB2 bash


## Create user for oracledb_exporter
> docker run -d --name oracleDB store/oracle/database-enterprise:12.2.0.1-slim

> docker network create --subnet 172.27.1.0/24 --ip-range 172.27.1.0/30 temp-network
> docker network connect --alias db --alias oracle-db temp-network oracleDB

> docker exec -it oracleDB bash
	sqlplus /nolog
		CONN / as sysdba;
		SHOW CON_NAME

		// 12.x以降なら、念のためにコンテナ(CDBかPDB)を指定する
		ALTER SESSION SET container=CDB$ROOT;
		//ALTER database open;

		// 共通ユーザーがを作成する. An attempt was made to create a common user or role with a name that was not valid for common users or roles. In addition to the usual rules for user and role names, common user and role names must start with C## or c## and consist only of ASCII characters.
		CREATE USER c##exporter IDENTIFIED BY PassW0rd_Please_Change;

		// OR
		//ALTER SESSION SET "_ORACLE_SCRIPT"=true;
		//CREATE USER exporter IDENTIFIED BY 'PassW0rd';

		// ログイン権限の付与
		GRANT CREATE SESSION TO c##exporter;
		// (OPTIONAL) 必要に応じてほかの権限付与
		//GRANT connect, resource TO user1;
		//ALTER USER user1 quota unlimited on USERS;

		// oracledb_exporter\default-metrics.tomlより、下記動的パフォーマンスビューへの参照権限が必要
		// - v$session, v$resource_limit, v$asm_diskgroup, v$sysstat, v$process, v$waitclassmetric, v$parameter
		// - gv$sort_segment
		// - sys.dba_data_files, sys.dba_free_space, sys.dba_tablespaces, sys.dba_temp_files
		// 参考: ビュー(別名)の本来の名称は下記クリエより確認可能
		// SELECT owner, object_type FROM dba_objects WHERE object_name LIKE 'V$SESSION';
		// SELECT table_owner, table_name FROM dba_synonyms WHERE synonym_name LIKE 'V$SESSION';

		// 権限付与。注意：直接ビュー名(シノニム)ではなく、本来の名称に対してGRANTする
		GRANT SELECT ON V_$SESSION TO c##exporter;
		GRANT SELECT ON V_$RESOURCE_LIMIT TO c##exporter;
		GRANT SELECT ON V_$ASM_DISKGROUP TO c##exporter;
		GRANT SELECT ON V_$SYSSTAT TO c##exporter;
		GRANT SELECT ON V_$PROCESS TO c##exporter;
		GRANT SELECT ON V_$WAITCLASSMETRIC TO c##exporter;
		GRANT SELECT ON V_$PARAMETER TO c##exporter;
		GRANT SELECT ON GV_$SORT_SEGMENT TO c##exporter;

		GRANT SELECT ON sys.dba_data_files TO c##exporter;
		GRANT SELECT ON sys.dba_free_space TO c##exporter;
		GRANT SELECT ON sys.dba_tablespaces TO c##exporter;
		GRANT SELECT ON sys.dba_temp_files TO c##exporter;

		// ユーザ切り替えて
		CONN c##exporter/PassW0rd@localhost/ORCLCDB.localdomain
		// SELECTできるか、確認
		// 例えば、SELECT resource_name,current_utilization,limit_value FROM v$resource_limit;


		END.

> docker run -ti --rm --network=temp-network store/oracle/database-instantclient:12.2.0.1 sqlplus system/Oradoc_db1@db/ORCLCDB.localdomain
> docker run -ti --rm --network=temp-network store/oracle/database-instantclient:12.2.0.1 sqlplus c##exporter/PassW0rd@db/ORCLCDB.localdomain

> docker run -d --rm --name oracledb_exporter --network=temp-network -p 9161:9161 -e DATA_SOURCE_NAME=system/Oradoc_db1@db/ORCLCDB.localdomain iamseth/oracledb_exporter
> docker run -d --rm --name oracledb_exporter --network=temp-network -p 9162:9161 -e DATA_SOURCE_NAME=c##exporter/PassW0rd@db/ORCLCDB.localdomain iamseth/oracledb_exporter
curl http://127.0.0.1:9161/metrics > 9161.txt &





CONN user1/PassW0rd@ORCLPDB1
CREATE TABLE demo1 (no NUMBER, msg VARCHAR2(32));
INSERT INTO demo1 VALUES (1, CONCAT('Testing ', TO_CHAR(SYSDATE,'DD/MM/YYYY hh:mm:ss')));
COMMIT;
SELECT * FROM demo1;

CONN / AS SYSDBA;
SHOW CON_NAME;

CREATE USER user2 IDENTIFIED BY PassW0rd;
GRANT connect, resource TO user2;

CREATE TABLESPACE DEMO1 DATAFILE 'DEMO1.dbf' SIZE 100M AUTOEXTEND ON NEXT 500K MAXSIZE 1024M;
SELECT TABLESPACE_NAME,BYTES,MAXBYTES FROM dba_data_files WHERE TABLESPACE_NAME LIKE 'DEMO%';

SELECT USERNAME, DEFAULT_TABLESPACE FROM dba_users where username LIKE 'USER%';
ALTER USER USER1 DEFAULT TABLESPACE DEMO1;
ALTER USER USER2 DEFAULT TABLESPACE DEMO1;

ALTER user user1 quota unlimited on DEMO1;
ALTER user user2 quota 10M on DEMO1;


CONN user2/PassW0rd@ORCLPDB1
alter session set container=ORCLPDB1;

CREATE TABLE demo2 (no NUMBER, msg VARCHAR2(32));
INSERT INTO demo2 VALUES (1, CONCAT('Testing ', TO_CHAR(SYSDATE,'DD/MM/YYYY hh:mm:ss')));
COMMIT;

CONN / AS 

GRANT select,update,delete,insert ON user2.demo2 TO user1;
GRANT select ANY TABLE TO user1;
GRANT all ON user2.demo2 TO user1;


SELECT TABLE_NAME, TABLESPACE_NAME FROM USER_TABLES WHERE TABLESPACE_NAME LIKE 'DEMO%';
SELECT TABLE_NAME, TABLESPACE_NAME FROM ALL_TABLES WHERE TABLESPACE_NAME LIKE 'DEMO%';
SELECT * FROM ALL_TABLES WHERE TABLESPACE_NAME LIKE 'DEMO%';



GRANT SELECT ON v$session TO user1;
SELECT owner, object_type FROM dba_objects WHERE object_name LIKE 'V$SESSION';
SELECT table_owner, table_name FROM dba_synonyms WHERE synonym_name LIKE 'V$SESSION';
GRANT SELECT ON V_$SESSION TO user1;
GRANT SELECT ON V_$RESOURCE_LIMIT TO user1;



alter session set "_ORACLE_SCRIPT"=true; 



> docker network create --subnet 172.27.1.0/24 --ip-range 172.27.1.0/30 temp-network
> docker network connect --alias db --alias oracle-db temp-network oracleDB
> docker run -d -rm --name oracledb_exporter --network=temp-network -p 9161:9161 -e DATA_SOURCE_NAME=system/Oradoc_db1@db/ORCLPDB1.localdomain iamseth/oracledb_exporter


CONN user1/PassW0rd@ORCLPDB1
alter session set container=CDB$ROOT;
SELECT resource_name,current_utilization,limit_value FROM v$resource_limit;


> docker run -ti --rm --network=temp-network store/oracle/database-instantclient:12.2.0.1 sqlplus user1/PassW0rd@db/ORCLPDB1.localdomain





> docker run -ti --rm --network=temp-network store/oracle/database-instantclient:12.2.0.1 sqlplus system/Oradoc_db1@db/ORCLPDB1.localdomain




> docker exec -it oracleDB bash
	$ sqlplus / as sysdba
	SQL> SELECT resource_name,current_utilization,limit_value FROM v$resource_limit;



SELECT TABLE_NAME, TABLESPACE_NAME, STATUS, NUM_ROWS, BLOCKS FROM USER_TABLES WHERE TABLE_NAME LIKE 'DEMO%';
SELECT * FROM USER_TABLES WHERE TABLE_NAME LIKE 'DEMO%';



	SQL> alter session set container=ORCLPDB1;
	SQL> create user user1 identified by PassW0rd;
	SQL> grant connect, resource to user1;
	SQL> alter user user1 quota unlimited on users;
	SQL> conn user1/PassW0rd@ORCLPDB1
	SQL> create table demo1 (col1 number);
	SQL> insert into demo1 values (1);
	SQL> commit;
	SQL> SELECT * FROM demo1;
/u01/app/oracle/product/12.2.0/dbhome_1/admin/ORCLCDB/tnsnames.ora

	SQL> CREATE pluggable database ORCLPDB2 from ORCLPDB1 FILE_NAME_CONVERT=('/u02/app/oracle/oradata/ORCLCDB/orclpdb1/','/u02/app/oracle/oradata/ORCLCDB/orclpdb2/');
	SQL> show pdbs
	SQL> alter pluggable database ORCLPDB2 open;
	SQL> !vi;
	SQL> conn user1/PassW0rd@ORCLPDB2
	SQL> show con_name
	SQL> SELECT * FROM demo1;






sqlplus "myuser/pass@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=192.168.10.1)(PORT=1521))(CONNECT_DATA=(SID=ASID)))"



'CREATE USER user1 IDENTIFIED BY "pass" DEFAULT TABLESPACE users QUOTA unlimited ON users'
'GRANT CREATE SESSION TO user1'
'GRANT CREATE TABLE TO user1'
'GRANT CREATE VIEW TO user1'
'GRANT CREATE SEQUENCE TO user1'

# Common User in CDB
Home / Oracle Database Online Documentation Library, 12c Release 1 (12.1.0.2)
Database 2 Day DBA
https://docs.oracle.com/database/121/ADMQS/GUID-DA54EBE5-43EF-4B09-B8CC-FAABA335FBB8.htm


# HOW-TOs

## Creation of a PDB

From the seed PDB:
> CREATE PLUGGABLE DATABASE hrpdb ADMIN USER dba1 IDENTIFIED BY password

From an existing PDB in the same CDB:
> CREATE PLUGGABLE DATABASE salespdb FROM hrpdb

By Plugging In an Unplugged PDB:
> CREATE PLUGGABLE DATABASE salespdb USING '/disk1/usr/financepdb.xml' NOCOPY

From a Non-CDB:
- DBMS_PDB.DESCRIBE function to generate XML metadata, CREATE PLUGGABLE DATABASE ... USING statement to create and run noncdb_to_pdb.sql script to convert.
- Oracle Data Pump to import the data set defined in old non-CDB into the newly created PDB.
- Oracle GoldenGate replication to replicate the data from the non-CDB to a PDB.


## Change password

For SYS and SYSTEM you have to log into Oracle as internal or sysdba.
```
$ svrmgrl command="connect internal"
OR
$ sqlplus "/ as sysdba"
	SQL> ALTER USER SYS IDENTIFIED BY [password]; 
	SQL> ALTER USER SYSTEM IDENTIFIED BY [password];
```

For ordinary user e.g. ‘oracle’ -- usually the oracle software owner. You can simply login and
```
	SQL> passwd
```



# Maintenance

## Add a disk to diskgroup
```
sudo fdisk /dev/xvdl
n    (new partition)
p    (primary )
<enter>   (default  1 )
<enter>  (default xxx) 
w    (write partition)      
    
sudo /etc/init.d/oracleasm createdisk DATA7 /dev/xvdl1

sudo su – oracle
. oraenv 
+ASM
sqlplus / as sysasm
alter diskgroup data add disk 'ORCL:DATA7';
```

## ASMディスクグループ状態、空き容量の確認方法

```
$ sqlplus / as sysasm
	SQL> select name,state from v$asm_diskgroup;

	NAME　　　　　　　　　　　　　　　　　　　　　　　STATE
	------------------------------------------------------------------
	DG1　　　　　　　　　　　　　　　　　　　　　　　　MOUNTED
	DG2　　　　　　　　　　　　　　　　　　　　　　　　MOUNTED
	DG3　　　　　　　　　　　　　　　　　　　　　　　　MOUNTED
	DG4　　　　　　　　　　　　　　　　　　　　　　　　DISMOUNTED
	DG5　　　　　　　　　　　　　　　　　　　　　　　　MOUNTED

	SQL> select group_number,name,state,type,total_mb as "TOTAL(MB)",
	2 free_mb as "FREE(MB)" ,round(free_mb/total_mb,4)*100 as "FREE(%)"
	3 from v$asm_diskgroup;

	GROUP_NUMBER NAME STATE TYPE TOTAL(MB) FREE(MB) FREE(%)
	------------ ----- ---------- ------- ---------- ---------- ----------
	1 DG1 MOUNTED EXTERN 1000 679 67.9
	2 DG2 MOUNTED EXTERN 1000 679 67.9
	3 DG3 MOUNTED EXTERN 9000 1116 14.82
	5 DG5 MOUNTED NORMAL 6000 5074 84.57
	4 DG4 MOUNTED EXTERN 5000 4740 98.56

	SQL> select group_number,name,state,type,total_mb as "TOTAL(MB)",
	2 free_mb as "FREE(MB)" ,round(free_mb/total_mb,4)*100 as "FREE(%)"
	3 from v$asm_diskgroup;

	GROUP_NUMBER NAME STATE TYPE TOTAL(MB) FREE(MB) FREE(%)
	------------ ----- ---------- ------- ---------- ---------- ----------
	1 DG1 MOUNTED EXTERN 1000 679 67.9
	2 DG2 MOUNTED EXTERN 1000 679 67.9
	3 DG3 MOUNTED EXTERN 9000 1116 14.82
	5 DG5 MOUNTED NORMAL 6000 5074 84.57
	4 DG4 MOUNTED EXTERN 5000 4740 98.56	

	SQL> select * from v$asm_disk;
```

## Determining Whether a Database Is a CDB
The following simple query determines whether the database to which an administrative user is currently connected is a non-CDB, or a container in a CDB:
```
SQL> SELECT NAME, CDB, CON_ID FROM V$DATABASE;
 
NAME      CDB     CON_ID
--------- --- ----------
CDB1      YES          0
```

# Slow query

1. Find the SQL_ID
If the query is still running: query v$session to get its information.
	> SQL> select SQL_ID from v$session where sid = 3089;

If completed: for this we use AWR/ASH report.
	ask application team that at what time the query was running and for that duration we generate the AWR
	In ASH report we find all kind of information regarding the top SQL’s. Basically we see SQL STATISTIS section of the AWR report. In this section there is SQL ORDERED BY ELAPSED TIME which matters most to us.
	If the query which is reported by application team is present in this section then we note down the sql_id of the query. Otherwise we generate ASH report for that particular time and get the sql_id.
	??? How to generate AWR report.

2. Run the SQL Tuning advisor for that SQL_ID
	...


Find SQL plan:				DBA_HIST_SQLSTAT, DBA_HIST_SNAPHOT
Find locking in Standalone:	v$lock, v$session
Find locking In RAC:		gv$lock, gv$session
History of wait events in a specific session:	v$session_event



# Troubleshooting

- Lost SYS and SYSTEM password?
  Log into the database server as a user belonging to ‘dba’ [unix ] or ‘ora_dba’ [windows ] group , typically ‘oracle’, or an administrator on your windos machine. You are able to log into Oracle as SYS user, and change the SYSTEM password by doing the following:
	```
	$ sqlplus "/ as sysdba"
	SQL> show user
	SQL> passw system
	SQL> quit
	$ sqlplus "/ as system"
	SQL> passw sys
	SQL> quit
	```
- Reset pwd file on Windows Oracle
  First stop the Oracle service of the instance.
  Find the PWD###.ora file for this instance which is located at C:\oracle\ora81\database\, where ### is the SID of the database.
  Rename the PWD###.ora file to PWD###.ora.bak and create a new pwd file by issuing the command:
  orapwd file=C:\oracle\ora81\database\PWD###.ora password=XXXXX
  where ### is the SID and XXXXX is the password you would like to use for the SYS and INTERNAL accounts.
  Start the Oracle service and get in with the SYS user and change other passwords from there.

- Find 
```
--
-- Show CPU Usage for Active Sessions <http://www.oracle-wiki.net/startsqlshowcpuusagebysess>
--
 
SET PAUSE ON
SET PAUSE 'Press Return to Continue'
SET PAGESIZE 60
SET LINESIZE 300
 
COLUMN username FORMAT A30
COLUMN sid FORMAT 999,999,999
COLUMN serial# FORMAT 999,999,999
COLUMN "cpu usage (seconds)"  FORMAT 999,999,999.0000
 
SELECT
   s.username,
   t.sid,
   s.serial#,
   SUM(VALUE/100) as "cpu usage (seconds)"
FROM
   v$session s,
   v$sesstat t,
   v$statname n
WHERE
   t.STATISTIC# = n.STATISTIC#
AND
   NAME like '%CPU used by this session%'
AND
   t.SID = s.SID
AND
   s.status='ACTIVE'
AND
   s.username is not null
GROUP BY username,t.sid,s.serial#
/
```

-  検証のための設定を行う

検証をやり易くするような設定や結果を見易くするような設定。
実行統計を残すための設定も行います。下記のコマンドをSQL*Plusにて実行してください。
```
-- SQLBLANKLINESはSQL内に空行を許容するか否かの設定、別に設定しなくてもOK
set SQLBLANKLINES ON

-- 以下の５つは表示に関する設定
set linesize 5000
set pagesize 1000
set newpage none
col plan_plus_exp for a120
set trimspool on

-- 内部的なSQLの実行計画を取ってしまうのを避ける設定
set serveroutput off
-- セッション内の実行統計を残すための設定
alter session set statistics_level=all;

-- example
var myNumber CHAR(10);
exec :myNumber := '0000000001';
select * from PERSON where MY_NUMBER = :myNumber;
SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY_CURSOR(format=>'ALL ALLSTATS LAST' ));
SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY_CURSOR(format=>'ADVANCED ALLSTATS LAST' ));
SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY_CURSOR('XXXXXX', null, 'ADVANCED ALLSTATS' ));
```

# Q&A
- Who is SYS?
  The SYS user is granted the SYSDBA privilege, which enables a user to perform high-level administrative tasks such as backup and recovery and even database upgrade.
  You can also think of the SYSDBA and SYSOPER privileges as types of connections that enable you to perform certain database operations for which privileges cannot be granted in any other way. For example, if you have the SYSDBA privilege, then you can connect to the database using AS SYSDBA.
  REF: https://docs.oracle.com/cd/B28359_01/server.111/b28310/dba006.htm#ADMIN11047
  REF: https://docs.oracle.com/cd/E11882_01/server.112/e10897/users_secure.htm#ADMQS12004
- What is the difference between DBA and SYSDBA?
  They are completely different privileges.
  - DBA ia a role (role privilege) and this privilege is stored in the Oracle Dictionary. It allows you to do almost everything you can "inside" the database.
  - SYSDBA is a privilege that is stored in the password file. When you connect "XXX as SYSDBA", Oracle DB will check if the user is granted this priv in the `pwfile` and will log you in as `SYS`, not as the user himself.
    SYSDBA allows you to do "everything" you can "inside" (as you are connect as SYS, that is a DBA), but also "outside" the Database, like mounting, starting and stopping oracle servers, run RMAN, alter the database, etc.
  
- Can I grant SYSDBA to an ordinary user?
  Yes. To grant SYSDBA, you must me logged in as SYS.
  However you should not easiler grant DBA or SYSDBA roles to ordinary users, and certainly not a generic out-of-the-box user.
  Better grant specific permissions required to the user on an individual basis. e.g. if the user needs to be able to create tables then grant CREATE TABLE privilege.

- Multi CDBs vs. PDBs
  Running multiple databases (database instances = CDBs) on modern enterprise servers can be an inefficient use of both hardware and human resources.
  The multitenant container database feature (PDB) in Oracle Database 12c Release 1 consolidates data and code from multiple databases—without changing existing schemas or applications—to improve resource utilization, manageability, and data security.

  One use case for multiple CDBs is to support multiple database versions. Acutally for migration between versions, you can unplug the PDBs from the 12.1.0.2 CDB and plug them into the 12.2.0.1 CDB.
  Others like
	- Licensing. Afaik you can use 1pdb per cdb without paying the multitenant option. If you consolidate them, you need the multitenant option.
	- Charactersets
	- Different CDB level parameters
- Which statement is true about a PDB that is created from a non-CDB?				=> d	The Oracle Multitenant option uses the managing-many-as-one concept for activities such as backup and patching.
	a. The data stored in all schemas of the PDB is visible by default to all other PDBs connected to the same CDB.				<- although a CDB shares resources such as background processes, SGA, and Oracle metadata, each PDB maintains granular control over its data and applies its own security policies to data visibility.
	b. Applications that use the PDB require code modification to enable them to access the PDB.								<- the Oracle Multitenant option allows any existing non-CDB to be converted to a PDB with no changes to the database or the applications that access it.
	c. A PDB can be cloned only within the CDB to which it is connected.														<- PDBs can be cloned within the same CDB or from one CDB to another.
	d. The data in a PDB is backed up automatically in accordance with the backup policies and schedule defined at the CDB level.

- Which statements are true about the Oracle Multitenant option?			=> A and C
	a. A PDB can be cloned across CDBs.
	b. After a patch is applied at CDB level, the patch should then be applied to each PDB in the CDB.
	c. The Oracle Database Resource Manager feature plans defined at the CDB level can assign different priorities to the applications supported by various PDBs within the same CDB.
	d. PDBs in a CDB share background processes and shared memory but no Oracle metadata.
	e. The Oracle Multitenant option can be used with Oracle Real Application Clusters but not Oracle Active Data Guard.
  // Only options A and C are correct, because PDBs can be cloned within the same CDB, or from one CDB to another. The Oracle Database Resource Manager feature has been enhanced to allow a CDB-level plan to manage the distribution of resources between the PDBs plugged into that CDB.
  // Answer B is incorrect because the managing-many-as-one concept allows patching to be done at the CDB level, which automatically patches all the PDBs plugged into it. Answer D is incorrect because all PDBs plugged into a CDB share the Oracle metadata that is stored in the CDB. Answer E is incorrect because the Oracle Multitenant option is compatible with and complements both Oracle Real Application Clusters and Oracle Active Data Guard.

- Which statements are true about a CDB?
	a. A CDB cannot exist without a PDB.
	b. A CDB can contain multiple seed PDBs.
	c. A CDB can share a database instance with a non-CDB.
	d. A CDB cannot exist without a root container.
	e. A CDB can have PDBs that have a user with the same username across the PDBs.
  // The correct answers are D and E. The minimal contents of a CDB are the root container CDB$ROOT and PDB$SEED. Because PDBs exist in isolation from one another, users and objects with the same names can be stored within each PDB.
  // Answer A is incorrect because a CDB can contain zero PDBs. Answer B is incorrect because a CDB can have only a single seed PDB, which cannot be modified and exists as a template for the creation of new PDBs. Answer C is incorrect because although both a CDB and a non-CDB can exist on the same server, they function as independent entities because of their architectural differences. A CDB shares a set of background processes and SGA with its PDBs, but a non-CDB requires a nonsharable set of background processes and SGA.

- Which statement explains how the root container, CDB$ROOT, differs from a PDB?
	a. CDB$ROOT contains only the Oracle system metadata, whereas a PDB contains metadata from the CDB into which it is plugged and application metadata.
	b. CDB$ROOT contains both Oracle system metadata and application metadata, whereas a PDB contains only user-defined data.
	c. CDB$ROOT contains all the Oracle system metadata and a part of the application metadata, whereas a PDB contains all application metadata along with the user-defined data for that application.
	d. CDB$ROOT contains only the Oracle system metadata, whereas a PDB contains all application metadata and the user-defined data for that application.
  // The correct answer is D. The root contains metadata only for the Oracle system and is a metadatabase with no user-defined data. A PDB is typically created for an application and therefore contains that application’s metadata and user-defined data. PDBs access required Oracle system metadata from the CDB that they are plugged into.

- How to create a non-CDB?
  The CREATE DATABASE ... ENABLE PLUGGABLE DATABASE SQL statement creates a new CDB. If you do not specify the ENABLE PLUGGABLE DATABASE clause, then the newly created database is a non-CDB and can never contain PDBs.
  You cannot transform a non-CDB into a CDB, or a CDB into a non-CDB. You must define a database as a CDB at creation,

- 統計情報、いつ取りますか?
https://books.google.com.my/books?id=lpaNDwAAQBAJ&pg=PA75&lpg=PA75&dq=DBMS_STATS%E3%80%80%E5%AE%9A%E6%9C%9F%E7%9A%84%E3%81%AB%E5%AE%9F%E8%A1%8C%E3%80%80%E6%8E%A8%E5%A5%A8&source=bl&ots=UAvVPd4h4n&sig=ACfU3U3N9-VMvYjHTEhZInBc_vvgnCjARw&hl=en&sa=X&ved=2ahUKEwiQn_3z7OboAhXFb30KHU95A1YQ6AEwBHoECAwQLw#v=onepage&q=DBMS_STATS%E3%80%80%E5%AE%9A%E6%9C%9F%E7%9A%84%E3%81%AB%E5%AE%9F%E8%A1%8C%E3%80%80%E6%8E%A8%E5%A5%A8&f=false



# Dict
- CDB:			(multitenant) container database. includes zero, one, or many customer-created pluggable databases (PDBs)
- PDB:			Pluggable database. a portable collection of schemas, schema objects, and nonschema objects that appears to an Oracle Net client as a non-CDB.
- non-CDB:		All Oracle databases before Oracle Database 12c were non-CDBs.
- container:	A container in a CDB is either a PDB or the root.
- CDB$ROOT:		The root container. Exactly one. It is a collection of schemas, schema objects, and nonschema objects to which all PDBs belong.
- PDB$SEED		The seed PDB. Exactly one. The seed PDB is a system-supplied template that the CDB can use to create new PDBs. The seed PDB is named PDB$SEED. You cannot add or modify objects in PDB$SEED.
- Database Home Page:	is the main database management page in Oracle Enterprise Manager Database Control (Database Control). Its URL is `https://HOST:PORT/em`
- VPD:			virtual private database. ???
- SGA :			???






Oracle 11g系统自动收集统计信息的一些知识
[日期：2014-11-21] 	来源：Linux社区  作者：stevendbaguo 	[字体：大 中 小]

   在11g之前，当表的数据量修改超过总数据量的10%，就会晚上自动收集统计信息，如何判断10%，之前的帖子有研究过：Oracle自动统计信息的收集原理及实验。这个STALE_PERCENT=10%，是无法修改的，如果表非常大，10%是非常多的数据，非常有可能造成统计信息不准确。

    在11g之后，STALE_PERCENT=10%是可以修改的，分为全局（DBMS_STATS.SET_GLOBAL_PREFS ）和表级别（DBMS_STATS.SET_TABLE_PREFS）。表级别的设定：

    修改为5%（范围从1-100）: exec dbms_stats.set_table_prefs(null,'table_name','STALE_PERCENT',5);
    恢复为10%: exec dbms_stats.set_table_prefs(null,'table_name','STALE_PERCENT',null);
    查询百分比:select dbms_stats.get_prefs('STALE_PERCENT',null,'table_name') from dual; 

---11g的是 周一到周五 22：00-2：00 周六周日 6：00-4：00

SELECT w.window_name, w.repeat_interval, w.duration, w.enabled
FROM dba_autotask_window_clients c, dba_scheduler_windows w
WHERE c.window_name = w.window_name
AND c.optimizer_stats = 'ENABLED';
WINDOW_NAME          REPEAT_INTERVAL                                              DURATION
-------------------- ------------------------------------------------------------ ---------------
SUNDAY_WINDOW        freq=daily;byday=SUN;byhour=6;byminute=0; bysecond=0        +000 20:00:00
FRIDAY_WINDOW        freq=daily;byday=FRI;byhour=22;byminute=0; bysecond=0        +000 04:00:00
WEDNESDAY_WINDOW    freq=daily;byday=WED;byhour=22;byminute=0; bysecond=0        +000 04:00:00
SATURDAY_WINDOW      freq=daily;byday=SAT;byhour=6;byminute=0; bysecond=0        +000 20:00:00
THURSDAY_WINDOW      freq=daily;byday=THU;byhour=22;byminute=0; bysecond=0        +000 04:00:00
TUESDAY_WINDOW      freq=daily;byday=TUE;byhour=22;byminute=0; bysecond=0        +000 04:00:00
MONDAY_WINDOW        freq=daily;byday=MON;byhour=22;byminute=0; bysecond=0        +000 04:00:00

--禁用自动收集
exec DBMS_AUTO_TASK_ADMIN.DISABLE(client_name => 'auto optimizer stats collection',operation => NULL,window_name => NULL);
--启用自动收集
exec DBMS_AUTO_TASK_ADMIN.ENABLE(client_name => 'auto optimizer stats collection',operation => NULL,window_name => NULL);
--查看job

select client_name,status from dba_autotask_client;

CLIENT_NAME                                                      STATUS
---------------------------------------------------------------- --------
auto optimizer stats collection                                  ENABLED
auto space advisor                                              ENABLED
sql tuning advisor                                              ENABLED


--收集当前数据库下所有用户的统计信息
exec dbms_stats.gather_database_stats(user);
--收集当前数据库用户下所有对象的统计信息
exec dbms_stats.gather_schema_stats(user);
--收集数据字典的统计信息
exec dbms_stats.gather_dictionary_stats();
--当系统有很大的分区表时，如果总是全部收集则会比较慢，11g之后可以设置INCREMENTAL只对数据有变动的分区做收集

exec dbms_stats.set_table_prefs(user,'table_name','INCREMENTAL','TRUE');--只收集数据变动的分区

exec dbms_stats.set_table_prefs(user,'table_name','INCREMENTAL','FALSE');--都要收集

select dbms_stats.get_prefs('INCREMENTAL',null,'table_name') from dual;--查看分区表INCREMENTAL的值


--获取global的统计信息收集设置选项
select dbms_stats.get_prefs('method_opt') from dual;
select dbms_stats.get_prefs('concurrent') from dual;
select dbms_stats.get_prefs('GRANULARITY') from dual;

select dbms_stats.get_prefs('INCREMENTAL') from dual;
--设置global的统计信息收集选项


exec DBMS_STATS.SET_PARAM('DEGREE',4);

exec DBMS_STATS.SET_PARAM('INCREMENTAL','TRUE');


+++
自動オプティマイザ統計収集を有効化、無効化する方法

自動化メンテナンス・タスクが有効になっているかは、下記のように確認:
	SQL> select client_name, status from dba_autotask_client;
		CLIENT_NAME STATUS
		------------------------------------------------------ --------
		auto optimizer stats collection ENABLED
		auto space advisor ENABLED
		sql tuning advisor ENABLED
自動オプティマイザ統計収集を無効化するには、
	SQL> BEGIN
	2 dbms_auto_task_admin.disable(
	3 client_name => 'auto optimizer stats collection',
	4 operation => NULL,
	5 window_name => NULL);
	6 END;
	7 /

	SQL> select client_name, status from dba_autotask_client;
		CLIENT_NAME STATUS
		------------------------------------------------------ --------
		auto optimizer stats collection DISABLED
		auto space advisor ENABLED
		sql tuning advisor ENABLED

テーブルの統計情報が取得された日付を確認する:
	SELECT
		a.TABLE_NAME --テーブル名
		,a.NUM_ROWS --件数
		,a.LAST_ANALYZED --統計情報を取得した日付
	FROM
		all_tables a
	WHERE
		a.OWNER = '' --オーナー名
		and a.TABLE_NAME = '' --テーブル名

SELECT OWNER, TABLE_NAME, NUM_ROWS, LAST_ANALYZED FROM all_tables ORDER BY OWNER, TABLE_NAME WHERE OWNER;
SELECT DISTINCT OWNER FROM all_tables ORDER BY OWNER;
SELECT OWNER, TABLE_NAME, NUM_ROWS, LAST_ANALYZED FROM all_tables WHERE OWNER LIKE 'SYS%' ORDER BY OWNER, LAST_ANALYZED FETCH NEXT 10 ROWS ONLY;



OWNER      TABLE_NAME                                                                                                                         NUM_ROWS LAST_ANAL
---------- -------------------------------------------------------------------------------------------------------------------------------- ---------- ---------
SYS        ACLMV$                                                                                                                                    0 26-JAN-17
SYS        ACLMV$_REFLOG                                                                                                                             0 26-JAN-17
SYS        ACLMVREFSTAT$                                                                                                                             0 26-JAN-17
SYS        ACLMVSUBTBL$                                                                                                                              0 26-JAN-17
SYS        APPLY$_AUTO_CDR_COLUMN_GROUPS                                                                                                             0 26-JAN-17
SYS        APPLY$_CDR_INFO                                                                                                                           0 26-JAN-17
SYS        APPLY$_BATCH_SQL_STATS                                                                                                                    0 26-JAN-17
SYS        APPLY$_CONF_HDLR_COLUMNS                                                                                                                  0 26-JAN-17
SYS        APPLY$_CHANGE_HANDLERS                                                                                                                    0 26-JAN-17
SYS        APPLY$_CONSTRAINT_COLUMNS                                                                                                                 0 26-JAN-17

10 rows selected.


SET TIMING ON
SELECT TABLESPACE_NAME, SUM(BYTES) FROM dba_free_space GROUP BY TABLESPACE_NAME;
SELECT TABLESPACE_NAME, SUM(BYTES) FROM dba_segments GROUP BY TABLESPACE_NAME;


SELECT trunc(to_date(DROPTIME,'YYYY-MM-DD:HH24:MI:SS')), count(*) from dba_recyclebin group by trunc(to_date(DROPTIME,'YYYY-MM-DD:HH24:MI:SS')) order by 1;
purge dba_recyclebin;


EXEC DBMS_STATS.GATHER_DICTIONARY_STATS;
EXEC DBMS_STATS.GATHER_FIXED_OBJECTS_STATS;


CREATE TABLESPACE my_space DATAFILE '/tmp/my_space.dbf' SIZE 1000M;
SELECT TABLESPACE_NAME FROM USER_TABLESPACES;
CREATE TABLE my_team (my_id number not null, my_name varchar2(32) not null, my_description varchar2(4000)) TABLESPACE my_space;

BEGIN 
    FOR x IN 1 .. 3 LOOP
         INSERT INTO enum (identifier, language_id, code, data, company_limit)
         SELECT 'BUSINESS_UNIT', 0, x*100, bname, 126 FROM temp_business_area;
    END LOOP;
END;

SELECT table_name, tablespace_name, num_rows FROM USER_TABLES WHERE tablespace_name in ('USERS', 'MY_SPACE');




SELECT w.window_name, w.repeat_interval, w.duration, w.enabled
FROM dba_autotask_window_clients c, dba_scheduler_windows w
WHERE c.window_name = w.window_name
AND c.optimizer_stats = 'ENABLED';
WINDOW_NAME          REPEAT_INTERVAL                                              DURATION
-------------------- ------------------------------------------------------------ ---------------
SUNDAY_WINDOW        freq=daily;byday=SUN;byhour=6;byminute=0; bysecond=0        +000 20:00:00
FRIDAY_WINDOW        freq=daily;byday=FRI;byhour=22;byminute=0; bysecond=0        +000 04:00:00
WEDNESDAY_WINDOW    freq=daily;byday=WED;byhour=22;byminute=0; bysecond=0        +000 04:00:00
SATURDAY_WINDOW      freq=daily;byday=SAT;byhour=6;byminute=0; bysecond=0        +000 20:00:00
THURSDAY_WINDOW      freq=daily;byday=THU;byhour=22;byminute=0; bysecond=0        +000 04:00:00
TUESDAY_WINDOW      freq=daily;byday=TUE;byhour=22;byminute=0; bysecond=0        +000 04:00:00
MONDAY_WINDOW        freq=daily;byday=MON;byhour=22;byminute=0; bysecond=0        +000 04:00:00



SQL> SELECT COLUMN_NAME, NUM_DISTINCT, NUM_NULLS, NUM_BUCKETS, DENSITY
	FROM DBA_TAB_COL_STATISTICS
	WHERE TABLE_NAME ="PA_EXPENDITURE_ITEMS_ALL"
	ORDER BY COLUMN_NAME;
		COLUMN_NAME                    NUM_DISTINCT  NUM_NULLS NUM_BUCKETS    DENSITY 
		------------------------------ ------------ ---------- ----------- ---------- 
		BURDEN_COST                            4300      71957           1 .000232558 
		BURDEN_COST_RATE                        675    7376401           1 .001481481 
		CONVERTED_FLAG                            1   16793903           1          1 
		COST_BURDEN_DISTRIBUTED_FLAG              2      15796           1         .5 
		COST_DISTRIBUTED_FLAG                     2          0           1         .5 
		COST_IND_COMPILED_SET_ID                 87    6153143           1 .011494253 
		EXPENDITURE_ID                      1171831          0           1 8.5337E-07 
		TASK_ID                                8648          0           1 .000115634 
		TRANSFERRED_FROM_EXP_ITEM_ID        1233787   15568891           1 8.1051E-07
像上面這個範例中,我們查詢的是table 中column的statistics值,其中, CONVERTED_FLAG欄位就表示值都有一種, EXPENDITURE_ID欄位就很適合建b-tree的index, COST_DISTRIBUTED_FLAG欄位很適合建bitmap的index。

當沒有沒有做過analyze時,當系統收到SQL查詢時,會依照下列的預設值進行cost的計算來選擇要走的execution plan。
	Default Table Values When Statistics are Missing
		Table Statistic					Default Value Used by Optimizer
		Cardinality						num_of_blocks * (block_size - cache_layer) / avg_row_len
		Average row length				100 bytes
		Number of blocks				
		Remote cardinality				2000 rows
		Remote average row length		100 bytes

	Default Index Values When Statistics are Missing
		Index Statistic			Default Value Used by Optimizer
		Levels					1
		Leaf blocks				25
		Leaf blocks/key			1
		Data blocks/key			1
		Distinct keys			100
		Clustering factor		800 (8 * number of blocks)

	所以,一個有經過analyze跟沒有經過analyze所影響的統計值是非常大的,因此建議放入系統排程工作中,定期執行objecst的analyze。


Analyze table蒐集的資訊:
    - Number of rows (NUM_ROWS)
    - Number of data blocks below the high water mark (that is, the number of data blocks that have been formatted to receive data, regardless whether they currently contain data or are empty) (BLOCKS)
    - Number of data blocks allocated to the table that have never been used (EMPTY_BLOCKS) 
	透過上述兩個參數值可以了解HWM水位是否太高,需不需要進行調整。

   -  Average available free space in each data block in bytes (AVG_SPACE)
   - Number of chained rows (CHAIN_COUNT)
   - Average row length, including the row's overhead, in bytes (AVG_ROW_LEN) 
	以上的資訊均可透過USER_TABLES, ALL_TABLES, and DBA_TABLES Views來查出。

Analyze index蒐集的資訊:

    *Depth of the index from its root block to its leaf blocks (BLEVEL)
    Number of leaf blocks (LEAF_BLOCKS)
    Number of distinct index values (DISTINCT_KEYS)
    Average number of leaf blocks for each index value (AVG_LEAF_BLOCKS_PER_KEY)
    Average number of data blocks for each index value (for an index on a table) (AVG_DATA_BLOCKS_PER_KEY)
    Clustering factor (how well ordered the rows are about the indexed values) (CLUSTERING_FACTOR) 

	以上的資訊均可透過USER_INDEXES, ALL_INDEXES, and DBA_INDEXES Views來查出。

Analyze的語法:
	The following statement computes statistics for the sample table oe.orders:
	ANALYZE TABLE orders COMPUTE STATISTICS;
	收集的資訊最完整,執行時的效能也最慢。

	The following statement computes only system statistics on the sample table oe.orders:
	ANALYZE TABLE orders COMPUTE SYSTEM STATISTICS;

	The following statement estimates (% or row counts) statistics for the sample table oe.orders and all of its indexes:
	ANALYZE TABLE orders ESTIMATE STATISTICS; 

	The following statement deletes statistics about the sample table oe.orders and all its indexes from the data dictionary:
	ANALYZE TABLE orders DELETE STATISTICS; 

	You can also collect histograms for a single partition of a table. The following statement analyzes partition sales_q2_2000 of the sample table sh.sales:
	ANALYZE TABLE sales PARTITION (sales_q2_2000) COMPUTE STATISTICS;

	The following statement validates the structure of the sample index oe.inv_product_ix:
	ANALYZE INDEX inv_product_ix VALIDATE STRUCTURE; 

	The following statement analyzes the sample table hr.employees and all of its indexes:
	ANALYZE TABLE employees VALIDATE STRUCTURE CASCADE; 

	For a table, the VALIDATE REF UPDATE clause verifies the REFs in the specified table, checks the rowid portion of each REF, and then compares it with the true rowid. If the result is an incorrect rowid, then the REF is updated so that the rowid portion is correct.
	The following statement validates the REFs in the sample table oe.customers:
	ANALYZE TABLE customers VALIDATE REF UPDATE;
	Customer reference 相關的table均 validate.

	The following statements validates the structure of the sample table oe.customers while allowing simultaneous DML:
	ANALYZE TABLE customers VALIDATE STRUCTURE ONLINE;


analyze table employee compute statistics; 

set autotrace on
select count(*) from employee; ※大量データがある前提で

analyze table employee delete statistics;
select count(*) from employee;

analyze table employee ESTIMATE statistics;
select count(*) from employee;

analyze table employee delete statistics; 
exec DBMS_STATS.GATHER_table_STATS(ownname => user,tabname => 'employee', method_opt => 'for all indexed columns size 1');
select count(*) from employee;



