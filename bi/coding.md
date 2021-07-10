
# Hive

```
hiveuser> $HADOOP_HOME/contrib/hive/bin/hive
hive>

hive> CREATE TABLE pref (id int, pref STRING)
    >    ROW FORMAT DELIMITED FIELDS TERMINATED BY ','
    >               LINES TERMINATED BY '\n';

hive> LOAD DATA LOCAL INPATH '/home/hiveuser/localfiles/pref.csv'
    >       OVERWRITE INTO TABLE pref;

```


```
hive> SELECT z.zip, z.pref, z.city, z.town FROM zip z WHERE z.ver = '2008-12-26';

hive> SELECT z.zip, z.pref, z.city, z.town FROM zip z
    >     WHERE z.ver = '2008-12-26' AND z.town LIKE '銀座';

hive> SELECT z.zip, p.pref, z.city, z.town FROM zip z
    >    LEFT OUTER JOIN pref p ON (p.id = z.pref)
    >     WHERE z.ver = '2008-12-26' AND z.town REGEXP '銀座';
```

```
hive> CREATE TABLE ginza_zip (zip STRING, pref INT, city STRING, town STRING)
	> ROW FORMAT DELIMITED FIELDS TERMINATED BY ','
	> LINES TERMINATED BY '\n';

hive> FROM zip z
	> INSERT OVERWRITE TABLE ginza_zip
	> SELECT z.zip, z.pref, z.city, z.town
	> WHERE z.ver = '2008-12-26' AND z.town REGEXP '銀座';

hive> SELECT g.* FROM ginza_zip g;

hive> FROM zip z
	> INSERT OVERWRITE DIRECTORY '/user/hive/ginza'
	> SELECT z.zip, z.pref, z.city, z.town
	> WHERE z.ver = '2008-12-26' AND z.town REGEXP '銀座';

hiveuser> $HADOOP_HOME/bin/hadoop dfs -lsr /user/hive/ginza


hive> FROM zip z
	> INSERT OVERWRITE LOCAL DIRECTORY '/home/hiveuser/localfiles/ginza'
	> SELECT z.zip, z.pref, z.city, z.town
	> WHERE z.ver = '2008-12-26' AND z.town REGEXP '銀座';

hiveuser> ls -la /home/hiveuser/localfiles/ginza/
```


```
hive> CREATE TABLE pref_new (id int, pref STRING)
    >    ROW FORMAT DELIMITED FIELDS TERMINATED BY ','
    >               LINES TERMINATED BY '\n';
```

```
hive> FROM (
    >   FROM pref
    >   SELECT TRANSFORM(pref.id, pref.pref) AS (oid, opref)
    >          USING '/bin/sed s/県//'
    >   CLUSTER BY oid
    > ) tmap
    > INSERT OVERWRITE TABLE pref_new SELECT tmap.oid, tmap.opref;
```

```
hive> FROM (
    >   FROM pref
    >   SELECT TRANSFORM(pref.id, pref.pref) AS (oid, opref)
    >          USING '/home/hiveuser/test.pl'
    >   CLUSTER BY oid
    > ) tmap
    > INSERT OVERWRITE TABLE pref_new SELECT tmap.oid, tmap.opref;
```




