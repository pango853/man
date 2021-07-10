

ADF								ETL, ELT
ADLS(Gen2)						


# Azure Data Lake Storage Gen2	| ADLS
	ADLS Gen2はBlob Storageがベースとなっており、Azureの様々なデータ分析サービスからアクセスしやすい
	「どんなデータでも入れておき、必要に応じて取り出して分析する」というデータレイクの特性に適うサービス
	2018年12月にパブリックプレビューが開始

# Azure Synapse Analytics
	formerly SQL DW (Azure SQL Data Warehouse)

	Synapse SQLプール


# Azure Data Factory	| ADF
	ビッグデータ統合のためのAzure Data Factory - ETL, ELT
	e.g. ログを DWH に移すために使う
	シンプルかつ包括的なETLまたはELTのプロセスを実現できます
	クラウドベースのデータ統合サービスを通じて、データの移動と変換を制御して自動化するデータ主導型のワークフローをクラウドに作成することができる
	コードの生成とメンテナンスはマネージドApache Sparkによって行われ、利用者はコーディングやメンテナンスを必要としません
	オンプレミスとクラウドによるハイブリッド なデータ統合や、ビルドとデプロイを自動化するパイプラインを使うこともできます

	コードの生成とメンテナンスはマネージドApache Sparkによって行われ、利用者はコーディングやメンテナンスを必要としません。オンプレミスとクラウドによるハイブリッド なデータ統合や、ビルドとデプロイを自動化するパイプラインを使うこともできます。

	Azure Data Factory を使えば、
		各種のデータ ストアからデータを取り込むことができるデータ主導型のワークフロー (パイプライン) を作成し、スケジューリングできます。
		そのデータは、Azure HDInsight Hadoop、Spark、Azure Data Lake Analytics、Azure Machine Learning などのコンピューティング サービスを使って処理し、変換することができます。

	DataSets:	// At 2018/08/14
	- Amazon Marketplace Web Service (Preview), Amazon Redshift, Amazon S3
	- Apache Impala (Preview)
	- Azure Blob Storage, Azure Cosmos DB, Azure Data Lake Storage Gen1, Azure Data Lake Storage Gen2 (Preview), Azure Database for MySQL, Azure Database for PostgreSQL, Azure File Storage, Azure SQL Data Warehouse, Azure SQL Database, Azure Search, Azure Table Storage
	- Cassandra, Common Data Service for Apps, Concur (Preview), Couchbase (Preview), DB2, Drill (Preview)
	- Dynamics 365, Dynamics CRM
	- FTP, File System, GE Historian, Google BigQuery, Greenplum, HBase, HDFS, HTTP, Hive, HubSpot (Preview), Informix, Jira (Preview), Magento (Preview), MariaDB, Marketo (Preview), Microsoft Access, MongoDB, MySQL, Netezza, ODBC, OData, Oracle, Oracle Eloqua (Preview), Oracle Responsys (Preview), Paypal (Preview), Phoenix, PostgreSQL, Presto (Preview), QuickBooks (Preview), SAP BW, SAP Cloud For Customer, SAP ECC, SAP HANA, SFTP, SQL Server, Salesforce, Salesforce Marketing Cloud (Preview), Salesforce Service Cloud, ServiceNow, Shopify (Preview), Spark, Square (Preview), Sybase, Teradata, Vertica, Web Table, Xero (Preview), Zoho (Preview)
	Pipelines:
	- Azure Batch Service
	- Azure Databrics
	- Azure Data Lake Analytics
	- Azure HDInsight
	- Azure Machine Learning
	with Copy Data, and looping.

	データを加工する部分については、Azure Batch Service や HDInsight で行い、そこにデータを流し込む機能として、Azure Data Factory
	効率的に使うことで、データの流し込みがやりやすくなる

- Azure Data Factory Integration Runtime
	以前は "Data Management Gateway" と呼ばれていました。

- SSIS Integration Runtime
	Microsoft SSIS (SQL Server Integration Services)

	Azure Data FactoryからSSISパッケージを実行することができ、それによりオンプレミスのデータワークロードを維持することができます。
	これまでオンプレミスでSSISを使用していた場合は、使い慣れたSQL Server Data Tools (SSDT) や SQL Server Management Studio (SSMS) などによって、ほとんど変更を加えずに既存のSSISパッケージをデプロイして管理できます。したがって、OSとサーバーやソフトウェアなどシステム全体にかかる負荷削減にも効果があります。

- Mapping Data Flows
	Azure Data Factoryの新しい機能であり、2019年10月に一般リリースされました。データフローのマッピングにより、Azure Data Factoryは、制御フローとデータフローの両方を組み合わせてデータウェアハウスの内外に情報を移行する完全なETLソリューションになりました。
	ETL Activity:
		Join
		Aggregate
		Pivot
		Unpivot
		Split
		Lookup
		Sort
	Debug:
		初めてData Flowを使用する場合は、ブラウザ上部の「Data Flow Debug」のスイッチを右側に切り替えてオンにします。
		この操作によって、対話型のデバッグ、データプレビュー、パイプラインのデバッグを実行するためのAzure Databricksクラスターが起動します。
		デバッグセッションの有効期限は、最後のデータプレビューもしくはデバッグパイプライン実行から最長60分間になります。
		Azure Integration Runtime（IR）の初期値は、コア数4、ワーカーノード数1で、最小限のコストでデータプレビューを行い、短時間でデバッグパイプラインを実行する小規模クラスターの設定になっています。
		大規模のデータを扱う場合には、Azure IRの構成を変更する必要があります。
	

Azure Data Factoryは、Microsoft SQL Server、Azure SQL Database、Azure Blob Storage、Azure Table Storageなどのソースからの構造化、半構造化、および非構造化データを統合するための堅牢で成熟したソリューションです。また、Power BIやAzure HDInsightなどのMicrosoftのBIおよび分析ソリューションともうまく統合できます。

SSISは、かつてはETLデータパイプラインを構築するためのマイクロソフトの推奨ツールでしたが、現在ではAzure Data Factoryの独自のMapping Data Flows機能と競合関係にあります。データフローのマッピングとSSISの長所と短所を比較検討し、目的に合ったデータ移行ソリューションを決定してください。


## Examples:
	- Synapse SQLプールにADFを使うと簡単にPolybaseでデータロードできる
	- Azure Data Factory を使用して SQL Server データベースから SQL Database にデータを移動する
		Azure Blob Storage 経由で SQL Server データベースから Azure SQL Database にデータを移動する方法

# Azure Databricks
	ビッグデータ処理基盤に向く柔軟なデータ分析サービスとしては、Sparkベースの「Azure Databricks」
	ストレージを持たない分、コストを抑えることができる。

	料金は、クラスター用の仮想マシンの費用と「DBU」というライセンス費用で構成される。DBUは仮想マシンのサイズと「Standard/Premium」という機能グレードによって設定される。 
	e.g. 初期値でクラスターを構成した場合の料金は、税別月額13万4332円である. Reserved VM Instancesも利用できる.

	vs. Apache Spark
	- Apache Sparkに対して最大50倍パフォーマンスを向上させるランタイム
	- マネージド型の信頼性の高いデータレイク
	- コラボレーションを実現する統合ワークスペース
	- パイプラインとノートブックと連携したワークフローの自動化
	- アクセス制御や暗号化によるエンタープライズレベルのセキュリティ

	Azure Databricks は、Azure Machine Learningで提供されるAPIなどを中心に、Azure Data Factory、Azure Data Lake Storage、Power BI などを連携させることが可能です。

# Azure Data Catalog
	enable registrants to share data sources
	Developers, data scientists, and analysts can use Data Catalog to discover, verify, and use community datasets.
	provides functionalities for data discovery, data understanding, and data consumption.
	Azure Data Catalog is a service that serves as a central repository for big data.
	Data Catalog is built through crowdsourced data with annotations and metadata and is meant to enable data users and collectors to share their efforts.

	Once data sources are registered in Data Catalog, any user with access can add to the metadata to enrich the set.
		e.g. adding tags, descriptions, processes for requesting access, or documentation.
	
	Use Cases:
	- Registration of central data sources
		By registering data in Data Catalog, organizations can ensure that data is available to all relevant business units.
		This includes benefits for data related to online transaction processing (OLTP) systems, analytics databases, data warehouses, and line-of-business.
	- Data sources for research and business intelligence
		Aggregating data with Azure Data Catalog can enable analysts to skip some or most of the manual work BI typically requires.
		Analysts can collaborate with both internal and external teams to identify sources and ensure that data is accurate and relevant.

	Key Concepts:
	- Data discovery
	- Data understanding
	- Data consumption
	- Data users

# Azure Purview
	can think Purview as the next generation of Azure Data Catalog. like ADC v2
	The roadmap for ADC has been unknow, or dead, for long time. I personally have used it years ago and cannot recommend.

# Azure Data Explorer	"Kusto"
	2018年9月にプレビュー提供が始まった「Azure Data Explorer」も同様に、対話型の分析が可能である。これはDatabricksと違ってストレージを備えており、データを格納するタイプである。そのためのコストが発生するが、その分性能が高く、大規模なデータを分析する用途に向く。これも東日本、西日本リージョンで利用できる。 
	Azure Data Explorer was designed as an analytical data platform for telemetry. It allows looking at the fresh raw data from different angles and provide a lot flexibility.
	Azure Stream Analytics -> for Azure IoT, do real-time analytics and detection
	Azure Data Explorer    -> near real-time analysis on large volumes of data streaming from applications, mainly for on-demand/interative real-time analytics
	REF: https://azure.microsoft.com/en-us/blog/azure-data-explorer-and-stream-analytics-for-anomaly-detection/
	REF: https://medium.com/analytics-vidhya/anomaly-detection-patterns-using-azure-stream-analytics-e6acddd25117

Imagine you are challenged with the following task:
	Design a cloud service capable of
	(1) accepting hundreds of billions of records on a daily basis,
	(2) storing this data reliably for weeks or months,
	(3) answering complex analytics queries on the data,
	(4) maintaining a low latency (seconds) of delay from data ingestion to query, and finally
	(5) completing those queries in seconds even when the data is a combination of structured, semi-structured, and free text?

Time-series analysis.
For IoT, Big data logging, SaaS applications


# MDM
REF: https://docs.microsoft.com/en-us/azure/architecture/reference-architectures/data/profisee-master-data-management-data-factory
	https://profisee.com/solutions/azure-master-data-management/

	"A core aspect of how MDM solutions function is that they combine data from multiple sources to create a "golden record master" that contains the best-known and trusted data for each record."



TODO:

Redshift vs. Snowflake
Redshift vs. BigQuery 




# Comparisons
- Azure Databricks / Data Explorer / ADLS / DWH
	https://xtech.nikkei.com/it/atclncf/service/00043/011600002/

	DWH	従来、大規模なデータ分析基盤 -> Azure SQL Data Warehouse

	一般にビッグデータ処理基盤は、
		Data lake	多様なデータを大量に格納できるストレージ				<- ADLSはまさにこれ | Blob Storageと同じ層
		Analytics	対話型やアドホックなデータ分析を実現するデータ分析サービス	<- Azure Databricksは分析のためのデータ処理(コンピュート) | HDInsight, DWHと同じ層
	一方、Azure Data Explorerは上記データレイクとデータ処理両方含まれています
	Azure Data ExplorerもDatabricksと同様に、対話型の分析が可能である。これはDatabricksと違ってストレージを備えており、データを格納するタイプである。そのためのコストが発生するが、その分性能が高く、大規模なデータを分析する用途に向く。


# MISC

## cheaper region

- Managed Disks	<https://azure.microsoft.com/en-us/pricing/details/managed-disks/>
LRS
			Central US		East US 2	East US					East Asia		Southeast Asia		Japan East		Japan West
P10 	128 GiB 	$19.71	$17.92		$19.71				 	$21.68			$19.71				 	$22.67		$20.61
P30 	1 TiB 	$135.17		$122.88		 	$135.17				 	$148.68		$135.17				$155.44			$135.17


- Block Blobs	<https://azure.microsoft.com/en-us/pricing/details/storage/blobs/>

- Azure Data Lake Storage <https://azure.microsoft.com/en-us/pricing/details/storage/data-lake/>



# MDM
Master Data Services - https://www.youtube.com/redirect?event=video_description&redir_token=QUFFLUhqa1FzbTJjMGgyRW5yaTB1NU1naGk1Rndlck5RQXxBQ3Jtc0ttdFRacjBWWVJZcTVDdzk4SHFKRHF1b1NmdHh2ejFfaHZUQzNmQVFqYm80THkwYjdXdGw1VTVfaHhuU2xIdnpjQlltVnZsdHZlZ3VZYkNmOU5NLWU1UVg2ZHV6a2g4THpuMVE5NlJBLUlfNVpKUzcyQQ&q=https%3A%2F%2Fdocs.microsoft.com%2Fen-us%2Fsql%2Fmaster-data-services%2Fmaster-data-services-overview-mds%3Fview%3Dsql-server-ver15
Informatica - www.informatica.com
Profisee -  www.profisee.com
Semarchy - www.semarchy.com

Among many other services listed in the Azure Marketplace - https://www.youtube.com/redirect?event=video_description&redir_token=QUFFLUhqa3VmVWlVTTZrbnhMRHJ1S09QeXpjNVVqOXVkZ3xBQ3Jtc0tub0lMMldyS284eVY0bS12bVZhR2JGdWZvTmQtanh2X01ST3lLY3VMRWFFQ01ZdjJDLWV3T29FMzB3ZEZhbWQwN2hUTzFGamdvX2FYaEZldXVVM3FqdEhxZUp1STI5NlJmZERPTmFPVXJqVy1Jdk9rQQ&q=https%3A%2F%2Fazuremarketplace.microsoft.com%2Fen-us%2Fmarketplace


