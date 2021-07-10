

# Hive

Hive is a data warehouse system built on top of Hadoop.
can access to files stored either directly in Apache HDFS™ or in other data storage systems such as Apache HBase™
query execution via Apache Tez™, Apache Spark™, or MapReduce
procedural language with HPL-SQL
sub-second query retrieval via Hive LLAP, Apache YARN and Apache Slider

## Use Cases
Hive は、一定期間に収集されたデータの分析的なクエリに使用されます - 例えば、傾向やウェブサイトのログを計算するために。

通常、Hive のユースケースは 2 つあります。
- HDFS の SQL クエリ エンジンとして:
	Hive は、SQL クエリの重要なソースになります。Hive を活用して Hadoop データレイクに取り組み、BI ツール (Tableau など) に接続して可視化することができます。
- HBase、Pig、Spark、またはTezとのテーブルストレージレイヤーとして：
	多くの HDFS ツールがテーブルストレージ層として Hive を使用しています。技術的には、これがおそらく世界で最も多いユースケースです。

## 事例
現在、4,330以上の企業ブランドがHiveを活用しています。これは HBase を使用している企業よりは少ないですが、それでも多くのブランドが利用しています。（特にほとんどの企業は依然SQLスタックを実行しているので）

    Scribdは、Hadoopを使ってHiveで典型的なデータサイエンスのユースケースを使用しています。これには、機械学習、データマイニング、BIツールのアドホッククエリなどが含まれます。実際、Scribd は Hadoop スタック全体の一部として Hive を使用しており、それがもっともうまくフィットする場所です。あなたはストレージ、処理、アドホッククエリのために、Hive と HBase を同じクラスタに置くことができます。
    MedHelpは、医師検索機能にHiveを使用しています。彼らはHadoopスタックで1日に何百万ものクエリを処理していますが、Hiveはそれをプロのように処理しています。
    Last.fmもアドホッククエリにHiveを使用しています。ここでも、Hiveの強みが発揮されています。Hadoop上でアドホッククエリが必要な場合は、Hiveを利用してください。
    HubSpot、hi5、eHarmony、およびCNETがHiveをクエリー実行に使用しています。これが最もよく議論されているユースケースだと言ってもいいでしょう。繰り返しになりますが、あえて言うならば、ほとんどがテーブルストレージ層として使用されているということです。しかし、実際それについては話している人はいません。

## Architecture
UI, JDBC/ODBC - browse, quey, DDL				Hive CLI for HiveSesrver2 called Beeline
MetaStore - thrift API							The Metascore stores the system catalog and metadata about tables, columns, partitions and so on. 
Hive QL - parse, planner, optimizer, exectution
User-defined Map-reduce Scripts	- map reduce
UDF/UDAF - substr,sum,average
SerDe	- csvm thrift, regex
HDFS FileFormats - text file, sequence file, rcfile

+ HCatalog is built on top of the Hivemetastore and incorporates Hive’s DDL. H
- The Hive Driver, Compiler, Optimizer, and Executor work together to turn a query into a set of Hadoop jobs.
- The Query Compiler compiles HiveQL queries into a DAG of MapReduce tasks.

## Examples

Function MySQL Hive Retrieving Information (General)
	SELECT from_columns FROM table WHERE conditions;
	SELECT from_columns FROM table WHERE conditions;
Retrieving All Values
	SELECT * FROM table;
	SELECT * FROM table;
Retrieving Some Values
	SELECT * FROM table WHERE rec_name = "value";
	SELECT * FROM table WHERE rec_name = "value";
Retrieving With Multiple Criteria
	SELECT * FROM TABLE WHERE rec1 = "value1" AND rec2 ="value2";
	SELECT * FROM TABLE WHERE rec1= "value1" AND rec2 ="value2";
Retrieving Specific Columns
	SELECT column_name FROM table;
	SELECT column_name FROM table;
Retrieving Unique Output
	SELECT DISTINCT column_name FROM table;
	SELECT DISTINCT column_name FROM table;
Sorting
	SELECT col1, col2 FROM table ORDER BY col2;
	SELECT col1, col2 FROM table ORDER BY col2;
Sorting Reverse
	SELECT col1, col2 FROM table ORDER BY col2 DESC;
	SELECT col1, col2 FROM table ORDER BY col2 DESC;
Counting Rows
	SELECT COUNT(*) FROM table;
	SELECT COUNT(*) FROM table;
Grouping With Counting
	SELECT owner, COUNT(*) FROM table GROUP BY owner;
	SELECT owner, COUNT(*) FROM table GROUP BY owner;
Maximum Value
	SELECT MAX(col_name) AS label FROM table;
	SELECT MAX(col_name) AS label FROM table;
Selecting from multiple tables (Join same table using alias w/”AS”)
	SELECT pet.name, comment FROM pet, event WHERE pet.name =event.name;
	SELECT pet.name, comment FROM pet JOIN event ON (pet.name =event.name)

see https://cwiki.apache.org/confluence/display/Hive/Tutorial

# HBase 

- Google's BigTable
- DIstributed computing, can integration with MapReduce

Why Hadoop need this as database?


## Use Cases

HBaseはビッグデータのリアルタイムクエリに最適です。Facebookはメッセージングやリアルタイム分析に使用していました（現在はFacebookのオープンソースプロジェクトであるMyRocksを使用しています）。Hiveは結果が返ってくるまでに時間がかかる可能性があるので、リアルタイムクエリには使うべきではありません。

HBaseは主に構造化されていないHadoopデータをレイクとして保存・処理するために使用されます。HBaseをすべてのHadoopデータのウェアハウスとして使用することもできますが、私たちは主に書き込みの多い操作に使用されているのを見ています。

## 事例

これらのケースのほぼすべてが、Hadoopのためのストレージと処理ツールとしてHBaseを使用することになりますが、それが自然にフィットする場所だといえます。

    AdobeはHBaseを立ち上げ時から運用しています。最初のノードは2008年に起動し、現在は30台のHDFSノードにHBaseを活用しています。内部構造化データと非構造化外部データの両方にHBaseを使用しています。
    Flurryは50台のHDFSノードをHBaseで運用しており、数百億行の行に対してHBaseを使用しています。
    HubSpotは主に顧客データの保存にHBaseを使用しています。また、HDFSスタックの一部としてHBaseデータに対してクエリを実行するためにHiveを使用しています。
    TwitterはHadoopスタックでもHBaseを使用しています。そして、ユーザー検索から生成された内部データにも使われています。
    StreamyはSQLからHBaseを使ったHadoopスタックに切り替えました。これまでよりも高速に処理できるようになったと主張しています。
    Sematext（HBase用のSMPを作った）は、HBaseとMapReduceスタックを使っています。繰り返しになりますが、この2つはお互いの長所と短所を完璧に補完し合っているため、うまく連携しています（Hiveを介して活用されていることが多い）。
    10,000社以上の企業がHBaseを活用しています。そして、そのほとんどが大企業です。現在のテックエコシステムでは、大手ブランドはHadoopを利用することが多いので、HBaseはいくつかの大手企業（TCS、Marin Software、Taboola、KEYW Corpなど）で利用されている傾向があります。

# Pig
Another Hive alternative is Apache Pig. Pig is a high-level programming language, best described as a “data flow language” and not a query language.








# TUTORIAL - Example of ETL Application Using Apache Spark and Hive
REF: https://dzone.com/articles/example-of-etl-application-using-apache-spark-and

DATA: https://www.kaggle.com/kyanyoga/sample-sales-data#sales_data_sample.csv

hadoop fs -mkdir samplesales
hadoop fs -copyFromLocal sales_sample_data.csv samplesales
hadoop fs -ls samplesales/

/user/spark-2.1.0-bin-hadoop2.7/bin/pyspark --master yarn-client --num-executors 4 --driver-memory 2g --executor-memory 4g
```
from pyspark import SparkContext, SparkConf
from pyspark.sql import SQLContext
from pyspark.sql import Row
from pyspark.sql import HiveContext
from pyspark.sql.functions import *

hive_context = HiveContext(sc)
sqlContext = SQLContext(sc)

// create the line format
RecSales = RecSales = Row('ordernumber','quantityordered','priceeach','orderlinenumber','sales','orderdate','status','qtr_id','month_id','year_id','productline','msrp','productcode','customername','phone','addressline1','addressline2','city','state','postalcode','country','territory','contactlastname','contactfirstname','dealsize')

// read the data from HDFS and have written it into a data frame object
dataSales = sc.textFile("/user/samplesales/")
header = dataSales.first()
dataSales= dataSales.filter(lambda line: line != header)
recSales = dataSales.map(lambda l: l.split(","))
dataSales = recSales.map(lambda l: RecSales(l[0],l[1],l[2],l[3],l[4],l[5],l[6],l[7],l[8],l[9],l[10],l[11],l[12],l[13],l[14],l[15],l[16],l[17],l[18],l[19],l[20],l[21],l[22],l[23],l[24]))
dfRecSales = hive_context.createDataFrame(dataSales)
dfRecSales.registerTempTable("sales")

// simple queries with the data we uploaded with Spark SQL.
hive_context.sql("select count(*) from sales").collect()
hive_context.sql("select * from sales").head()
hive_context.sql("select ordernumber,priceeach  from sales").head(2)

// group the sales by territory, and write the results to a Hive table.
dfterriroty = hive_context.sql("select territory,sum(priceeach) total from sales group by territory")
dfterriroty.registerTempTable("sumterr")
dfterriroty.show()

// create a Hive table and write the result.
hive_context.sql("CREATE TABLE IF NOT EXISTS territory_sum (territory String, total INT)")
hive_context.sql("insert into territory_sum select * from sumterr")

// Finally, check the data written to Hive.
hive_context.sql("select * from territory_sum").show()
hive_context.sql("select count(*) from territory_sum").show()
hive_context.sql("select count(*) from sumterr").show()
```



