
# Debian 9

ZONE=asia-southeast1-b
gcloud compute instances create test-docker --machine-type n1-standard-2 --boot-disk-size=20GB --zone $ZONE --maintenance-policy=TERMINATE
gcloud compute ssh test-docker --zone $ZONE
	useradd -s /bin/bash -d /home/aaa -g aaa -G aaa,google-sudoers -m aaa

sudo apt update
sudo apt install apt-transport-https ca-certificates curl gnupg2 software-properties-common
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable"
sudo apt update
apt-cache policy docker-ce
sudo apt install docker-ce
sudo systemctl status docker
sudo usermod -aG docker ${USER}
su - ${USER}

# CentOS 7.7

$ sudo dnf config-manager --add-repo=https://download.docker.com/linux/centos/docker-ce.repo

sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo

dnf list docker-ce --showduplicates | sort -r
sudo dnf -y  install docker-ce --nobest

yum list docker-ce --showduplicates | sort -r
sudo yum install -y docker-ce docker-ce-cli containerd.io

//sudo systemctl enable --now docker
sudo systemctl start docker

 

# Ubuntu 18

lsb_release -a

sudo apt update
sudo apt install apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable"

sudo apt update
apt-cache policy docker-ce
sudo apt install docker-ce



sudo systemctl status docker
sudo usermod -aG docker ${USER}
su - ${USER}
id -nG

docker info
docker login

sudo mkdir /opt/oradata
sudo chmod 777 /opt/oradata
docker run -d -p 8080:8080 -p 1521:1521 --name oracleDB store/oracle/database-enterprise:12.2.0.1-slim
docker cp oracleDB:/ORCL /opt/oradata/ORCL 


docker run -d -p 8080:8080 -p 1521:1521 --name oracleDB -v /opt/oradata:/ORCL store/oracle/database-enterprise:12.2.0.1-slim
docker exec -it oracleDB bash
docker exec -it oracleDB bash -c "source /home/oracle/.bashrc; sqlplus /nolog"

	connect sys as sysdba;
	-- Here enter the password as 'Oradoc_db1'
	alter session set "_ORACLE_SCRIPT"=true;
	create user dummy identified by dummy;
	GRANT CONNECT, RESOURCE, DBA TO dummy;
	--Now create a sample table.
	create table Docker (id int,name varchar2(20));
	--Start inserting values in to the table.

	select value from v$parameter where name='service_names';
		ORCLCDB.localdomain

sqlplus / as sysdba
SQL> startup



/home/oracle/setup/log/
/home/oracle/setup/DB_ENV

ORCLCDB
ORCLPDB1




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
			alter pluggable database all open;
			alter pluggable database ORCLPDB1, ORCLPDB2 open;
			alter pluggable database all except ORCLPDB2 open;
			alter pluggable database all open force;
			alter pluggable database all close;
			alter pluggable database all close immediate;
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


docker inspect oracleDB | fgrep IPAddress
docker run -ti --rm store/oracle/database-instantclient:12.2.0.1 sqlplus system/Oradoc_db1@172.17.0.2/ORCLCDB.localdomain
docker run -ti --rm store/oracle/database-instantclient:12.2.0.1 sqlplus system/Oradoc_db1@172.17.0.2/ORCLPDB1.localdomain

docker run -ti --rm store/oracle/database-instantclient:12.2.0.1 sqlplus system/Oradoc_db1@172.17.0.1/ORCLCDB.localdomain
docker run -ti --rm store/oracle/database-instantclient:12.2.0.1 sqlplus system/Oradoc_db1@172.17.0.1/ORCLPDB1.localdomain


docker network create --subnet 172.27.1.0/24 --ip-range 172.27.1.0/30 temp-network
docker run -ti --rm store/oracle/database-instantclient:12.2.0.1 sqlplus system/Oradoc_db1@172.17.0.1/ORCLPDB1.localdomain

docker network connect temp-network oracleDB
docker network disconnect temp-network oracleDB
docker network connect --alias db --alias oracle-db temp-network oracleDB

docker run -ti --rm --network=temp-network store/oracle/database-instantclient:12.2.0.1 sqlplus system/Oradoc_db1@db/ORCLPDB1.localdomain


# Create tablespaces


docker run -d -p 8080:8080 -p 1521:1521 --name oracleDB store/oracle/database-enterprise:12.2.0.1-slim
docker exec -it oracleDB bash

	sqlplus / as sysdba

	SET WRAP OFF
	SET PAGESIZE 999

	column owner format a20
	column table_name format a30
	column column_name format a40
	select owner, table_name, column_name from all_tab_columns where table_name = 'V_$DATABASE';

	SELECT NAME, CDB, CON_ID FROM V$DATABASE;

	COLUMN NAME FORMAT A8
	SELECT NAME, CON_ID, DBID, CON_UID, GUID FROM V$CONTAINERS ORDER BY CON_ID;

	COLUMN PDB_NAME FORMAT A15
	SELECT PDB_ID, PDB_NAME, STATUS FROM DBA_PDBS ORDER BY PDB_ID;

	COLUMN OWNER FORMAT A15
	COLUMN TABLE_NAME FORMAT A30
	SELECT * FROM CDB_TABLES;






$ su - oracle
passwd: *******

$ export ORACLE_HOME=/oracle/app/oracle/product/8.0.5
$ export ORACLE_SID=NRT
$ export PATH=$ORACLE_HOME/bin:$PATH
$ export LD_LIBRARY_PATH=$ORACLE_HOME/lib:$LD_LIBRARY_PATH

$ cp $ORACLE_HOME/dbs/init.ora $ORACLE_HOME/initNRT.ora
$ vim $ORACLE_HOME/initNRT.ora
	db_name=NRT
	control_files = (/control1/ora_control1, /control2/ora_control2, /db/NRT/ora_control3)
$ vim create_db.sql
	startup nomount
	CREATE DATABASE "NRT"
	   maxdatafiles 254
	   maxinstances 8
	   maxlogfiles 32
	   character set JA16SJIS
	   national character set JA16SJIS
	DATAFILE '/db/NRT/system01.dbf' SIZE 100M
	logfile '/redo/redo01.log' SIZE 50M,
		'/redo/redo02.log' SIZE 50M,
		'/redo/redo03.log' SIZE 50M;
$ svrmgrl
	SVRMGR> @create_db

$ svrmgrl
SVRMGR> connect internal
Connected.
SVRMGR> shutdown abort
SVRMGR> quit
$ rm /db/NRT/system01.dbf
$ rm /redo/redo01.log /redo/redo02.log /redo/redo03.log
$ rm /control1/ora_control1 /control2/ora_control2 /db/NRT/ora_control3


CREATE DATABASE test
     DATAFILE 'test_system' SIZE 10M
     LOGFILE GROUP 1 ('test_log1a', 'test_log1b') SIZE 500K,
     GROUP 2 ('test_log2a', 'test_log2b') SIZE 500K;


	sqlplus /nolog
		connect / as sysdba

	alter session set "_ORACLE_SCRIPT"=true;
	create user dummy identified by dummy;
	GRANT CONNECT, RESOURCE, DBA TO dummy;
	--Now create a sample table.
	create table Docker (id int,name varchar2(20));
	--Start inserting values in to the table.

	select value from v$parameter where name='service_names';
		ORCLCDB.localdomain



docker run --rm -d -p 8080:8080 -p 1521:1521 --name odb store/oracle/database-enterprise:12.2.0.1-slim
docker exec -it odb bash
sqlplus / as SYSDBA
```sql
SELECT X.name as name, SUM(nvl(X.free_bytes,0)) as free_bytes, SUM(X.bytes) as bytes, SUM(X.max_bytes) as max_bytes
FROM
(
	SELECT ddf.tablespace_name as name, ddf.status as status, ddf.bytes as bytes, sum(coalesce(dfs.bytes, 0)) as free_bytes, CASE WHEN ddf.maxbytes = 0 THEN ddf.bytes ELSE ddf.maxbytes END as max_bytes
	FROM sys.dba_data_files ddf, sys.dba_tablespaces dt, sys.dba_free_space dfs
	WHERE ddf.tablespace_name = dt.tablespace_name AND ddf.file_id = dfs.file_id(+)
	GROUP BY ddf.tablespace_name, ddf.file_name, ddf.status, ddf.bytes, ddf.maxbytes
) X
GROUP BY X.name
;

NAME                           FREE_BYTES      BYTES  MAX_BYTES
------------------------------ ---------- ---------- ----------
UNDOTBS1                           786432   56623104  536870912
SYSAUX                           34144256  814546944 3.4360E+10
SYSEXT                           40828928   40894464 3.4360E+10
SYSTEM                                  0  853680128 3.4360E+10
```

SELECT tablespace_name, SUM(bytes) FROM sys.dba_free_space GROUP BY tablespace_name;
TABLESPACE_NAME                SUM(BYTES)
------------------------------ ----------
SYSAUX                          132448256
SYSEXT                           40828928


```sql
SELECT ddf.tablespace_name as name, ddf.status as status, ddf.bytes as bytes, sum(coalesce(dfs.bytes, 0)) as free_bytes, CASE WHEN ddf.maxbytes = 0 THEN ddf.bytes ELSE ddf.maxbytes END as max_bytes
FROM sys.dba_data_files ddf, sys.dba_tablespaces dt, sys.dba_free_space dfs
WHERE ddf.tablespace_name = dt.tablespace_name AND ddf.file_id = dfs.file_id(+)
GROUP BY ddf.tablespace_name, ddf.file_name, ddf.status, ddf.bytes, ddf.maxbytes
;
NAME                           STATUS         BYTES FREE_BYTES  MAX_BYTES
------------------------------ --------- ---------- ---------- ----------
UNDOTBS1                       AVAILABLE   56623104     786432  536870912
SYSEXT                         AVAILABLE   40894464   40828928 3.4360E+10
SYSAUX                         AVAILABLE  814546944   32374784 3.4360E+10
SYSTEM                         AVAILABLE  853680128          0 3.4360E+10
```


```sql

SELECT X.name as name, SUM(nvl(X.free_bytes,0)) as free_bytes, SUM(X.bytes) as bytes, SUM(X.max_bytes) as max_bytes
FROM
(
	SELECT ddf.tablespace_name as name, ddf.status as status, ddf.bytes as bytes, sum(coalesce(dfs.bytes, 0)) as free_bytes, CASE WHEN ddf.maxbytes = 0 THEN ddf.bytes ELSE ddf.maxbytes END as max_bytes
	FROM sys.dba_data_files ddf, sys.dba_tablespaces dt, sys.dba_free_space dfs
	WHERE ddf.tablespace_name = dt.tablespace_name AND ddf.file_id = dfs.file_id(+)
	GROUP BY ddf.tablespace_name, ddf.file_name, ddf.status, ddf.bytes, ddf.maxbytes
) X
GROUP BY X.name



SELECT ddf.tablespace_name AS name, ddf.bytes, ddf.max_bytes, (ddf.user_bytes - coalesce(ds.bytes, 0)) as free_bytes
FROM
 (SELECT tablespace_name, SUM(bytes) as bytes, SUM(maxbytes) as max_bytes, SUM(user_bytes) as user_bytes
  FROM sys.dba_data_files 
  GROUP BY tablespace_name) ddf
LEFT JOIN
 (SELECT tablespace_name, SUM(bytes) as bytes
  FROM sys.dba_segments
  GROUP BY tablespace_name) ds ON (ddf.tablespace_name LIKE ds.tablespace_name)
;

NAME                                BYTES  MAX_BYTES FREE_BYTES
------------------------------ ---------- ---------- ----------
SYSAUX                          821297152 3.4360E+10  129630208
UNDOTBS1                        103809024  536870912    8257536
SYSEXT                           40894464 3.4360E+10   40828928
SYSTEM                          853680128 3.4360E+10          0


```

SELECT tablespace_name, status, file_id, bytes, maxbytes, user_bytes FROM sys.dba_data_files;

TABLESPACE_NAME                STATUS       FILE_ID      BYTES   MAXBYTES USER_BYTES
------------------------------ --------- ---------- ---------- ---------- ----------
SYSTEM                         AVAILABLE          1  853680128 3.4360E+10  853671936
SYSAUX                         AVAILABLE          3  821297152 3.4360E+10  821231616
SYSEXT                         AVAILABLE          6   40894464 3.4360E+10   40828928
UNDOTBS1                       AVAILABLE          2  103809024  536870912  102760448


SELECT tablespace_name, file_id, bytes FROM sys.dba_free_space;



Compare to
NAME                           FREE_BYTES      BYTES  MAX_BYTES
------------------------------ ---------- ---------- ----------
SYSAUX                           34144256  814546944 3.4360E+10
UNDOTBS1                           786432   56623104  536870912
SYSEXT                           40828928   40894464 3.4360E+10
SYSTEM                                  0  853680128 3.4360E+10



https://www.mydbaworld.com/tablespace-usage-oracle-database/
select
    a.tablespace_name,
    round(SUM(a.bytes)/(1024*1024)) CURRENT_MB,
    round(SUM(decode(a.AUTOEXTENSIBLE, 'NO', A.BYTES/(1024*1024), GREATEST (a.MAXBYTES/(1024*1024),A.BYTES/(1024*1024))))) MAX_MB,
    round((SUM(a.bytes)/(1024*1024) - c.Free/1024/1024)) USED_MB,
    round((SUM(decode(a.AUTOEXTENSIBLE, 'NO', A.BYTES/(1024*1024), GREATEST (a.MAXBYTES/(1024*1024),A.BYTES/(1024*1024)))) - (SUM(a.bytes)/(1024*1024) - round(c.Free/1024/1024))),2) FREE_MB,
    round(100*(SUM(a.bytes)/(1024*1024) - round(c.Free/1024/1024))/(SUM(decode(a.AUTOEXTENSIBLE, 'NO', A.BYTES/(1024*1024),GREATEST (a.MAXBYTES/(1024*1024),A.BYTES/(1024*1024)))))) USED_PCT
from
    dba_data_files a,
    (
        SELECT
            d.tablespace_name ,sum(nvl(c.bytes,0)) Free
        FROM
            dba_tablespaces d,
            DBA_FREE_SPACE c
        WHERE
            d.tablespace_name = c.tablespace_name(+)
            --AND d.contents='PERMANENT'
            --AND d.status='ONLINE'
            group by d.tablespace_name
    ) c
WHERE
    a.tablespace_name = c.tablespace_name
GROUP BY a.tablespace_name, c.Free/1024
order by 6;

TABLESPACE_NAME                CURRENT_MB     MAX_MB    USED_MB    FREE_MB  USED_PCT
------------------------------ ---------- ---------- ---------- --------------------
SYSAUX                                783      32768        660   32108.73         2
UNDOTBS1                               99        512         91        421        18
SYSTEM                                814      32768        814   31953.85         2
SYSEXT                                 39      32768          0   32767.98         0


SELECT
	d.tablespace_name ,sum(nvl(c.bytes,0)) Free
FROM
	dba_tablespaces d,
	DBA_FREE_SPACE c
WHERE
	d.tablespace_name = c.tablespace_name(+)
	group by d.tablespace_name
;
TABLESPACE_NAME                      FREE
------------------------------ ----------
SYSAUX                          129695744
TEMP                                    0
UNDOTBS1                          8257536
SYSEXT                           40828928
SYSTEM                                  0




https://blog.zeddba.com/2017/06/27/querying-tablespace-usage/

SELECT df.tablespace_name tablespace_name,
 max(df.autoextensible) auto_ext,
 round(df.maxbytes / (1024 * 1024), 2) max_ts_size,
 round((df.bytes - sum(fs.bytes)) / (df.maxbytes) * 100, 2) max_ts_pct_used,
 round(df.bytes / (1024 * 1024), 2) curr_ts_size,
 round((df.bytes - sum(fs.bytes)) / (1024 * 1024), 2) used_ts_size,
 round((df.bytes-sum(fs.bytes)) * 100 / df.bytes, 2) ts_pct_used,
 round(sum(fs.bytes) / (1024 * 1024), 2) free_ts_size,
 nvl(round(sum(fs.bytes) * 100 / df.bytes), 2) ts_pct_free
FROM dba_free_space fs,
 (select tablespace_name,
 sum(bytes) bytes,
 sum(decode(maxbytes, 0, bytes, maxbytes)) maxbytes,
 max(autoextensible) autoextensible
 from dba_data_files
 group by tablespace_name) df
WHERE fs.tablespace_name (+) = df.tablespace_name
GROUP BY df.tablespace_name, df.bytes, df.maxbytes
UNION ALL
SELECT df.tablespace_name tablespace_name,
 max(df.autoextensible) auto_ext,
 round(df.maxbytes / (1024 * 1024), 2) max_ts_size,
 round((df.bytes - sum(fs.bytes)) / (df.maxbytes) * 100, 2) max_ts_pct_used,
 round(df.bytes / (1024 * 1024), 2) curr_ts_size,
 round((df.bytes - sum(fs.bytes)) / (1024 * 1024), 2) used_ts_size,
 round((df.bytes-sum(fs.bytes)) * 100 / df.bytes, 2) ts_pct_used,
 round(sum(fs.bytes) / (1024 * 1024), 2) free_ts_size,
 nvl(round(sum(fs.bytes) * 100 / df.bytes), 2) ts_pct_free
FROM (select tablespace_name, bytes_used bytes
 from V$temp_space_header
 group by tablespace_name, bytes_free, bytes_used) fs,
 (select tablespace_name,
 sum(bytes) bytes,
 sum(decode(maxbytes, 0, bytes, maxbytes)) maxbytes,
 max(autoextensible) autoextensible
 from dba_temp_files
 group by tablespace_name) df
WHERE fs.tablespace_name (+) = df.tablespace_name
GROUP BY df.tablespace_name, df.bytes, df.maxbytes
ORDER BY 4 DESC;

TABLESPACE_NAME                AUT MAX_TS_SIZE MAX_TS_PCT_USED CURR_TS_SIZE USED_TS_SIZE TS_PCT_USED FREE_TS_SIZE TS_PCT_FREE
------------------------------ --- ----------- --------------- ------------ ------------ ----------- ------------ -----------
SYSTEM                         YES    32767.98                       814.13                                                 2
UNDOTBS1                       YES         512            17.8           99        91.13       92.05         7.88           8
SYSAUX                         YES    32767.98            2.01       783.25       659.63       84.22       123.63          16
TEMP                           YES    32767.98             .04           20           13          65            7          35
SYSEXT                         YES    32767.98               0           39          .06         .16        38.94         100



https://sql-oracle.com/?p=375

-- 表領域を表領域単位で確認する
SELECT
  A.TABLESPACE_NAME 表領域
  , ROUND(SUM(BYTES) / 1024 / 1024, 1) "ファイル容量(MB)"
  , ROUND(SUM(BYTES - SUM_BYTES) / 1024 / 1024, 1) "使用容量(MB)"
  , ROUND(SUM(SUM_BYTES) / 1024 / 1024, 1) "空き容量(MB)"
  , ROUND((SUM(BYTES - SUM_BYTES) / 1024) / (SUM(BYTES) / 1024) * 100, 1)
    "使用率(%)" 
FROM
  DBA_DATA_FILES A 
  LEFT JOIN 　( 
    SELECT
      TABLESPACE_NAME
      , FILE_ID
      , NVL(SUM(BYTES), 0) SUM_BYTES 　 
    FROM
      DBA_FREE_SPACE 
    GROUP BY
      TABLESPACE_NAME
      , FILE_ID
  ) B 
    ON A.TABLESPACE_NAME = B.TABLESPACE_NAME 
    AND A.FILE_ID = B.FILE_ID 
GROUP BY
  A.TABLESPACE_NAME 
ORDER BY
  1;





# Check stats
docker run --rm -d -p 8080:8080 -p 1521:1521 --name odb store/oracle/database-enterprise:12.2.0.1-slim
docker exec -it odb bash
	sqlplus / as sysdba
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

	SELECT OWNER, TABLE_NAME, NUM_ROWS, LAST_ANALYZED FROM all_tables ORDER BY OWNER, TABLE_NAME;

SELECT OWNER, TABLE_NAME, NUM_ROWS, LAST_ANALYZED FROM all_tables ORDER BY OWNER, TABLE_NAME WHERE OWNER;
SELECT DISTINCT OWNER FROM all_tables ORDER BY OWNER;
SELECT OWNER, TABLE_NAME, NUM_ROWS, LAST_ANALYZED FROM all_tables WHERE OWNER LIKE 'SYS%' ORDER BY OWNER, LAST_ANALYZED FETCH NEXT 10 ROWS ONLY;


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





SET TIMING ON
SELECT TABLESPACE_NAME, SUM(BYTES) FROM dba_free_space GROUP BY TABLESPACE_NAME;
SELECT TABLESPACE_NAME, SUM(BYTES) FROM dba_segments GROUP BY TABLESPACE_NAME;


SELECT trunc(to_date(DROPTIME,'YYYY-MM-DD:HH24:MI:SS')), count(*) from dba_recyclebin group by trunc(to_date(DROPTIME,'YYYY-MM-DD:HH24:MI:SS')) order by 1;
purge dba_recyclebin;


EXEC DBMS_STATS.GATHER_DICTIONARY_STATS;
EXEC DBMS_STATS.GATHER_FIXED_OBJECTS_STATS;

SELECT OWNER, TABLE_NAME, NUM_ROWS, LAST_ANALYZED FROM all_tables WHERE OWNER LIKE 'SYS%' ORDER BY OWNER, LAST_ANALYZED FETCH NEXT 10 ROWS ONLY;

SELECT OWNER, TABLE_NAME, NUM_ROWS, LAST_ANALYZED FROM all_tables WHERE TABLE_NAME LIKE '%DBA%' ORDER BY OWNER, LAST_ANALYZED FETCH NEXT 10 ROWS ONLY;


SELECT allt.OWNER, allt.TABLE_NAME, allt.LAST_ANALYZED FROM all_tables allt LEFT JOIN DICTIONARY dict ON dict.TABLE_NAME LIKE allt.TABLE_NAME WHERE dict.TABLE_NAME IS NOT NULL;


CREATE TABLESPACE my_space DATAFILE '/tmp/my_space.dbf' SIZE 1000M;
SELECT TABLESPACE_NAME FROM USER_TABLESPACES;
CREATE TABLE my_team (my_id number not null, my_name varchar2(32) not null, my_description varchar2(4000), created TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL, updated TIMESTAMP DEFAULT NULL, CONSTRAINT my_team_pk PRIMARY KEY (my_id)) TABLESPACE my_space;

BEGIN 
  FOR x IN 1 .. 9999 LOOP
    INSERT INTO my_team (MY_ID, MY_NAME, MY_DESCRIPTION) VALUES(x*2, 'Test ' || x, 'Testing Testing Testing Testing Testing Testing Testing Testing Testing Testing ' || x);
  END LOOP;
END;
/

DROP TABLE my_team;


EXEC DBMS_STATS.GATHER_DICTIONARY_STATS;
EXEC DBMS_STATS.GATHER_FIXED_OBJECTS_STATS;
SELECT table_name, tablespace_name, num_rows FROM USER_TABLES WHERE tablespace_name in ('USERS', 'MY_SPACE');

SELECT ORIGINAL_NAME  FROM dba_recyclebin;
purge dba_recyclebin;

SELECT dt.tablespace_name, dt.contents, ddf.bytes, ddf.maxbytes, dfs.free/ddf.bytes, ddf.user_bytes - dseg.used AS free2, (ddf.user_bytes - dseg.used - dfs.free)/dfs.free AS err
FROM sys.dba_tablespaces dt
LEFT JOIN(
  SELECT tablespace_name, bytes, maxbytes, user_bytes FROM dba_data_files GROUP BY tablespace_name, bytes, maxbytes, user_bytes
) ddf ON ddf.tablespace_name = dt.tablespace_name
LEFT JOIN(
  SELECT tablespace_name, SUM(bytes) AS free FROM dba_free_space GROUP BY tablespace_name
) dfs ON dfs.tablespace_name = dt.tablespace_name
LEFT JOIN(
  SELECT tablespace_name, SUM(bytes) AS used FROM dba_segments GROUP BY tablespace_name
) dseg ON dseg.tablespace_name = dt.tablespace_name
;



実験:
CREATE TABLESPACE my_space DATAFILE '/tmp/my_space.dbf' SIZE 1000M;
CREATE TABLE table1 (col1 number not null) TABLESPACE my_space;
SELECT tablespace_name, SUM(bytes) AS free FROM dba_free_space GROUP BY tablespace_name;
CREATE TABLE table2 (col2 number not null) TABLESPACE my_space;
CREATE TABLE table3 (col3 number not null) TABLESPACE my_space;
CREATE TABLE table4 (col4 number not null) TABLESPACE my_space;
CREATE TABLE table5 (col5 number not null) TABLESPACE my_space;
SELECT tablespace_name, SUM(bytes) AS free FROM dba_free_space GROUP BY tablespace_name;

DROP TABLE table5;
SELECT tablespace_name, SUM(bytes) AS free FROM dba_free_space GROUP BY tablespace_name;
DROP TABLE table4;
SELECT tablespace_name, SUM(bytes) AS free FROM dba_free_space GROUP BY tablespace_name;
DROP TABLE table3;
SELECT tablespace_name, SUM(bytes) AS free FROM dba_free_space GROUP BY tablespace_name;
DROP TABLE table2;
SELECT tablespace_name, SUM(bytes) AS free FROM dba_free_space GROUP BY tablespace_name;
DROP TABLE table1;
SELECT tablespace_name, SUM(bytes) AS free FROM dba_free_space GROUP BY tablespace_name;

purge dba_recyclebin;
SELECT tablespace_name, SUM(bytes) AS free FROM dba_free_space GROUP BY tablespace_name;

EXPLAIN PLAN FOR
  SELECT tablespace_name, SUM(bytes) AS free FROM dba_free_space GROUP BY tablespace_name;
SELECT PLAN_TABLE_OUTPUT FROM TABLE(DBMS_XPLAN.DISPLAY());



SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY_CURSOR(format=>'ALL ALLSTATS LAST' ));



SELECT tablespace_name, SUM(bytes) AS free FROM dba_free_space WHERE tablespace_name LIKE 'MY_SPACE' GROUP BY tablespace_name ;



> docker network create --subnet 172.27.1.0/24 --ip-range 172.27.1.0/30 temp-network
//> docker network connect --alias db --alias oracle-db temp-network oracleDB

> docker run --rm -d --network=temp-network --network-alias db --network-alias oracle-db -p 8080:8080 -p 1521:1521 --name odb store/oracle/database-enterprise:12.2.0.1-slim


> docker run -ti --rm --network=temp-network store/oracle/database-instantclient:12.2.0.1 sqlplus system/Oradoc_db1@db/ORCLCDB.localdomain
//> docker run -ti --rm --network=temp-network store/oracle/database-instantclient:12.2.0.1 sqlplus c##exporter/PassW0rd@db/ORCLCDB.localdomai

> docker run --rm --name odbexp --network=temp-network -p 9161:9161 -e DATA_SOURCE_NAME=system/Oradoc_db1@db/ORCLCDB.localdomain -e DEFAULT_METRICS=metrics-lite.toml oracledb_exporter/12.2:4a363d13-patched
//> docker run --rm --name odbexp --network=temp-network -p 9161:9161 -e DATA_SOURCE_NAME=system/Oradoc_db1@db/ORCLCDB.localdomain iamseth/oracledb_exporter
docker exec -it odbexp bash
curl http://127.0.0.1:9161/metrics




rpm -ivh oracle-instantclient18.5-basic-18.5.0.0.0-3.x86_64.rpm
cd oracledb_exporter.0.2.7-ora18.5.linux-amd64
export DATA_SOURCE_NAME=system/Oradoc_db1@172.27.1.2/ORCLCDB.localdomain
LD_LIBRARY_PATH=/usr/lib/oracle/18.5/client64/lib ./oracledb_exporter -log.level debug -web.listen-address :9161
	-custom.metrics


SELECT TABLESPACE_NAME, SUM(BYTES), SUM(USER_BYTES) FROM dba_data_files GROUP BY TABLESPACE_NAME;
SELECT TABLESPACE_NAME, SUM(BYTES) FROM dba_segments GROUP BY TABLESPACE_NAME;
SELECT TABLESPACE_NAME, SUM(BYTES) FROM dba_free_space GROUP BY TABLESPACE_NAME;
SELECT TABLESPACE_NAME, SUM(blocks) FROM dba_temp_files GROUP BY TABLESPACE_NAME;
