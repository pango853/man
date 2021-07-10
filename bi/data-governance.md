

データ・ガバナンスとは、企業内のデータの可用性、関連性、使いやすさ、保全性、セキュリティーの全体的な管理を指します。

組織がデータを管理し、以下のような質問に答えられるようにします。
    データに関する情報をどこまで把握しているか?
    このデータはどこから入手したか?							Data catalog
    このデータは会社のポリシーとルールに準拠しているか?				Also for quality


Data Governance framework -> for Data Driven organization

大数据的特点是3V，即大量化（Volume）、多种类（Variety）和高采集速度（Velocity）。大量化意味着传统的数据质量算法，除非有非常大的性能提升，是难以用在大数据环境下的，因为扫描一次的时间可能都是无法接受的；多种类更增加了这种难度，因为传统的数据质量算法基本上是基于关系数据的，对于象XML、文档、图数据等等类型，目前还没有太好的数据质量算法；高采集速度更是一个严峻的挑战，因为采集过程本来就是数据质量问题的主要来源，采集速度快，又不能及时进行数据质量处理，会导致数据质量问题的堆积，越来越严重。

       同时，数据质量是一个综合性的问题，一般认为其包括三个方面：元数据的质量、数据内容的质量和数据使用方式的质量，而大数据的特点恰恰是元数据的弱化和未来使用方式的不确定性。


Data Governance includes the people, processes, and technologies needed to manage and protect the company’s data assets to guarantee generally understandable, correct, complete, trustworthy, secure, and discoverable corporate data.
At its core, data governance is about establishing methods and spearheading an organization with clear responsibilities and processes to standardize, integrate, protect and store corporate data – which makes data governance necessary, not just for regulatory compliance.
It is pivotal that the data sciences partner comprehensively addresses evolving data governance requirements.


While management is the implementation, data governance provides the guidelines – they complement each other. 
	Data management without data governance would be chaotic, and data governance without data management would be a book of rules.

Oversea cloud first - We can only ask ourselves about how and when the shift should be made.
Industry studies suggest that nearly 70% of enterprises are moving traditional warehouse data and applications onto a public cloud. 


Data governance comes with inherent challenges that commonly include:
    Lack of Data Leadership
    Understanding Business Value of Data Governance
    Recognizing the Need / Pain Caused by Data
    Senior Management Support, Sponsorship, and Understanding
    Budgets and Ownership
    People assume IT Owns the Data
    Lack of Data Documentation
    Resources to Apply to Data Governance

Four pillars
1. Data stewardship
2. Data quality
3. Master data management
4. Data governance use cases

regulatory compliance initiatives
GDPR CCPA



# Master Data Management (MDM)
	which is a method used to define and manage the critical data of an organization to provide data integration and a single point of reference.
	MDM streamlines data sharing among personnel and departments.




# An Example of Azure Data Catalog POC (approx. 5 elapsed days)
	includes:
	Establishing/configuring the Data Catalog service within your Azure subscription
	Training and support to harvest and import Technical Metadata into your catalog
	Training and support to configure your Business Glossary for Business Metadata and subsequent tagging of Data Assets in the Registry
	Training and support in adopting the key pragmatic templates that underpin data governance activities:
		Data Governance Lifecycle
		Subject Area Information Model
		Data Visualisation Planning
		Data Set Planning


# Data governance on AWS
REF: https://www.yash.com/blog/data-governance-aws/

Some AWS Services in Data Governance:
	Amazon CloudWatch - monitoring and logs
	AWS Config - a fully managed service that provides you with an AWS resource inventory, configuration history, and configuration change notifications to enable security and governance.
	AWS Personal Health Dashboard -  is a service that provides timely alerts and guidance that offers suggestive remedies, when AWS is experiencing events that it “thinks” might affect the application.
	AWS Managed Services - provides guidance on ongoing management of existing AWS infrastructure.

# for Azure SQL
REF: https://www.youtube.com/watch?v=NYL991eybzs
apply Row Level Security and Data Masking to your Azure SQL Database

Azure security offers 3 levels of protection:
    Security 1: Protect the Data
    Security 2: Control Access
    Security 3: Monitor Activity

-> Data discovery & classification is part of the Advanced Data Security (ADS) offering, which is a unified package for advanced SQL security capabilities.



# Change Data Capture
データ・ウェアハウスでは、1つ以上の本番データベースからリレーショナル・データを抽出し、分析のためにデータ・ウェアハウスに転送することが必要になることがよくあります。
CDCは、変更があったデータのみを瞬時に識別して処理し、変更データをさらに利用できるようにします。

In the context of data replication, Change Data Capture (CDC) is the technique of systematically tracking incremental change in data at the source,
and subsequently applying these changes at the target to maintain synchronization.

https://github.com/wushujames/mysql-cdc-projects/wiki

https://www.slideshare.net/Hadoop_Summit/prenting-money-laundering-due-to-realtime-change-data-capture-cdc-and-the-quality-of-big-data
ユースケースはいろいろだが、BigDataとしては
	・AML(資金洗浄防止)		資金の移動を繰り返すことで誤魔化すのを検知
	Prenting money laundering due to Real-Time Change Data Capture (CDC) and the quality of big data
	チェンジをAIエンジンで分析
CDC(Change Data Capture)を使えば、変更があったデータのみを瞬時に識別して処理し、その変更データをさらに再利用することができるものです。 
	https://dev.classmethod.jp/articles/talend_cdc_-data_coordination_1/

a hypothetical scenario for the retail industry
	a loyalty program to its customers
https://www.qlik.com/ja-jp/data-streaming/data-streaming-cdc#RealTimeChange
	- 情報源からターゲットにリアルタイムでデータを移動
	- 複製の一連作業を完全に自動化するシンプルかつグラフィカルインターフェイスを介して、すべてのデータを管理します
	- 合理化されたエージェントレス構成により、データエンジニアは最先端の変更データキャプチャ（CDC）テクノロジーに基づいて、データパイプラインを容易に設定、制御、監視できます







# Components

## Data Quality
- https://aws.amazon.com/blogs/big-data/test-data-quality-at-scale-with-deequ/
	https://github.com/awslabs/deequ/
	some issues are:
		Missing values can lead to failures in production system that require non-null values (NullPointerException).
		Changes in the distribution of data can lead to unexpected outputs of machine learning models.
		Aggregations of incorrect data can lead to wrong business decisions.
	features:
		allows you to calculate data quality metrics on your dataset
		define and verify data quality constraints, and be informed about changes in the data distribution
	Scenario:
		The system computes data quality metrics on a regular basis (with every new version of a dataset), verifies constraints defined by dataset producers, and publishes datasets to consumers in case of success. In error cases, dataset publication can be stopped, and producers are notified to take action. Data quality issues do not propagate to consumer data pipelines, reducing their blast radius.


