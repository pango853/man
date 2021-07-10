

Amazon Athena	Querying
Amazon S3
Redshift
AWS Glue		ETL Tool



Amazon EMR


# Redshift
Redshift is OLAP whereas Aurora is OLTP.

Online Transactional Processing	vs Online Analytic Processing

Common use cases for an OLAP database are:
    What’s the customer lifetime value of my e-commerce application?
    What’s the median duration of play time for my mobile game?
    What’s the conversion rate for various landing pages based on the referrer?

To improve performance, OLAP databases are designed to to be columnar.

Since OLAP is optimized for analyzing data, basic transactional procedures like writes or updates tend to be done in infrequent batches, typically once a day or an hour. OLAP shines when it comes to reads and analytical calculations like aggregation. 
Diff:
	Scaling				- concurrency scaling feature, automatical scaling, add more nodes
	Storage Capacity	- petabytes
	Data Loading		- COPY command for inserting, ETL
	Data Structure		- columnar, ACID
	Performance			- fast read performance and over a larger amount of data
	Pricing				- starts from .25$ per hour while Aurora starts with .041$ per hour

When to use Amazon Redshift?
    The requirement is an Online analytical processing workload and not transactional.
    You have a high analytical workload and running on your transactional database will hurt the performance.
    Your data volume is in hundreds of TBs and you anticipate more data coming in.
    You are willing to let go of the consistency compliance and will ensure the uniqueness of your keys on your own.
    You are ready to put your head into designing SORT KEYS and DIST KEYS to extract the maximum performance.

Products:
    Amazon Redshift
    HP Vertica
    Teradata
    IBM Netezza
    KDB+


## COPY Command
	https://get.treasuredata.com/Redshift_COPY_Command_Guide-Request.html



# Databricks
https://www.quora.com/What-is-the-advantages-disadvantages-of-Databricks-vs-AWS-EMR-spark
Price: Databricks is expensive. The per-node markup on top of EC2 charges is $0.40 / hours. EMR pricing is an add-on on top of EC2 pricing - you will pay anywhere from $0.09 to $0.27 on top of EC2 pricing.
Best bet —- Use Amazon EMR for core ML and ETL workflows, and Databricks for the unbeatable notebook interface.

Databricks runs standard Spark applications inside a user’s AWS account, similar to EMR, but it adds a variety of features to create an end-to-end environment for working with Spark. These include:

    Interactive UI (includes a workspace with notebooks, dashboards, a job scheduler, point-and-click cluster management)
    Cluster sharing (multiple users can connect to the same cluster, saving cost)
    Security features (access controls to the whole workspace, clusters)
    Collaboration (multi-user access to the same notebook, revision control, and IDE and GitHub integration)
    Data management (support for connecting different data sources to Spark, caching service to speed up queries)


# Amazon EMR
industry-leading cloud big data platform for processing vast amounts of data using open source tools such as Apache Spark, Apache Hive, Apache HBase, Apache Flink, Apache Hudi, and Presto. Amazon EMR makes it easy to set up, operate, and scale your big data environments by automating time-consuming tasks like provisioning capacity and tuning clusters. With EMR you can run petabyte-scale analysis at less than half of the cost of traditional on-premises solutions and over 3x faster than standard Apache Spark. You can run workloads on Amazon EC2 instances, on Amazon Elastic Kubernetes Service (EKS) clusters, or on-premises using EMR on AWS Outposts.
Apache Hudi simplifies pipelines for change data capture (CDC) and privacy regulations
Amazon EMR on Amazon EC2 | Amazon EKS | AWS Outposts



# Amazon Kinesis
https://trojrobert.medium.com/azure-and-amazon-data-stream-analytics-and-processing-amazon-kinesis-azure-stream-analytics-and-a6b42b213eb7
	Types:
	Kinesis Video Streams — capture, process, and store video streams.
	Kinesis Data Streams- capture, process, and store data streams.
	Kinesis Data Firehose — capture, transform, and load data streams into AWS data stores.
	Kinesis Data Analytics — process data streams in real-time with SQL or Apache Flink.

Amazon Kinesis Data Analytics for SQL Applications
	allow you process and analyze streaming data using standard SQL

# Glue
## Glue Data Catalog

## Blueprint
	https://github.com/awslabs/aws-glue-blueprint-libs/tree/master/samples


# AWS Amplify
	managed UI. Amplify makes it easy to create, configure, and implement scalable web applications on AWS.
	https://github.com/aws-samples/amazon-deequ-glue


# AWS Lake Formation		2018/11-intro, 2019/8-ga
	a fully managed service that makes it much easier for customers to build, secure, and manage data lakes.
		including collecting, cleaning, and cataloging data, and securely making that data available for analytics.
	data sources using pre-defined templates
	define policies to govern access
	analyze this data using their choice of AWS analytics and machine learning services, including Amazon Redshift, Amazon Athena, and AWS Glue, with Amazon EMR, Amazon QuickSight, and Amazon SageMaker.

	Database - a db is registered in the `Glue Data Catalog`. It holds the metadata required to analyze the raw data, such as the structure of the tables that are going to be automatically generated during data ingestion.
	Blueprint - users can make the data ingestion easier by using blueprints that create the necessary workflows, crawlers and jobs on AWS Glue
	Pricing - there is no extra cost to using AWS Lake Formation; customers only pay for the use of the underlying services such as Amazon S3 and AWS Glue.


# Redshift Spectrum vs. Athena
	same: querying S3 using standard SQL, and storing the results of that query
	Redshift Spectrum - store to Redshift, can join tables directly
	Athena - store to S3, later can be loaded in to Redshift


# Example
Data Sources		e.g. server logs
Event Processing	Amazon Kinesis
ETL+Storage			Amazon S3
Querying			Amazon Athena
BI, Analystics		tableau, looker, Amazon QuickSight



# Solutions
	Amazon Macie	Discover and protect your sensitive data at scale		<-> Azure Security Center


