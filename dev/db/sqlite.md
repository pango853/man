
.show
sqlite>.header on
sqlite>.mode column
sqlite>.timer on

.schema sqlite_master

ANALYZE;
or
ANALYZE database_name;
or
ANALYZE database_name.table_name;

.databases

sqlite> CREATE TABLE COMPANY(
   ID INT PRIMARY KEY     NOT NULL,
   NAME           TEXT    NOT NULL,
   AGE            INT     NOT NULL,
   ADDRESS        CHAR(50),
   SALARY         REAL
);

$sqlite3 testDB.db .dump > testDB.sql
$sqlite3 testDB.db < testDB.sql

.quit

#. JPA

