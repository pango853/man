


Bigtable	HBaseがGoogleのBigtableをモデルにしたキー/バリュー形式でデータを格納することで動作しているらしい	※HBaseがBigtableを参考に作られたって
	NoSQL, column-based, wide column store
	Google Gmail, Map, Search are using it.


■GCPを利用した理由
・想定を上回る大量のトラフィック・トラッキングのリクエストもスムーズなスケールアウトで対応。
・ライブマイグレーションメンテナンスによる停止・再起動がなく、パケットロスや接続キレが発生しない。
・BigQuery企業向けデータウェアハウスをビッグデータの蓄積と迅速な分析に活用可能。
・Cloud AutoML専門知識がなくと機械学習モデルを簡単に構築できる。
・Google App Engineアプリケーションの作成・実行・管理ができる。（サーバー運用などの業務軽減）
・コストメリットに優れ、GCPは主に秒単位の従量制を採用。利用期間に応じ自動的にディスカウントが適用される。



# Data Lineage
https://cloud.google.com/blog/ja/products/data-analytics/architecting-a-data-lineage-system-for-bigquery
https://cloud.google.com/solutions/building-a-bigquery-data-lineage-solution

	simply put, it is dependencies map. link data by its metadata.
	トレーサビリティの情報はデータリネージと呼ばれ、
		それを追跡、管理、確認できるような環境を整えることで、
			データエラーの追跡や、フォレンジック分析、データの依存関係の特定を簡単に行うことができるようになります。
	データリネージの基本はデータ処理の流れを記録することにある。
	データリネージは、ビジネスデータを保護するためにも欠かせません。
		たとえば、組織ではデータ ガバナンスの手順が定められ、個人情報（PII）などの機密データの流れを完全に追跡できるようにすることが求められています。
		特に重要視されているのは、メタデータが顧客のクラウド組織（またはプロジェクト）の外に出ないようにすることです。

	Data lineage is the process of understanding, recording, and visualizing data as it flows from data sources to consumption.
	-> Combine data discovery with a comprehensive view of metadata, to create a data mapping framework

	demo: https://www.youtube.com/watch?v=a6Xz-EwU9RE
	demo: https://www.youtube.com/watch?v=dfRetdg9444	Data Lineage with Apache Airflow using Marquez
	demo: https://airflow.apache.org/docs/apache-airflow/stable/lineage.html
	demo: https://www.youtube.com/watch?v=XsDAruCimUM	Azure Purview - First Look at Dataset Lineage
	e.g. dependencies map, どのジョブでSELECTされているか、origins,sources/targets

# Data Catalog
https://cloud.google.com/blog/ja/products/data-analytics/cloud-metadata-management-tagging-tips

	Data Catalog は、ビジネス メタデータと各種データアセットの関連を指定するための機能豊富なインターフェースを提供するサービスです。




# MISC

- BigQuery vs. BigTable
	BigQuery is a query Engine for datasets that don't change much, or change by appending.　OLAP, dataware house.
		It's a great choice when your queries require a "table scan" or the need to look across the entire database.
		Think sums, averages, counts, groupings. BigQuery is what you use when you have collected a large amount of data, and need to ask questions about it.
	Bigtableは、低レイテンシと高スループットのワークロードに最適なスケーラビリティの高い NoSQL データベースです。It is designed to be the foundation for a large, scaleable application.
		Use BigTable when you are making any kind of app that needs to read and write data, and scale is a potential issue.

- BigQuery GIS diff?
	RDBMS with spatial features

REF: https://cloud.google.com/free/docs/aws-azure-gcp-service-comparison

- Dataproc vs. Dataflow vs. Dataprep
	All for Data analytics: BigQuery, Dataflow, Dataproc, Dataflow, Dataprep, Cloud Composer, and more...
	proc - Managed Spark and Hadoop. For open source processing
	flow - Stream/batch data processing. Like Amazon Kinesis or Azure Stream Analytics
	prep - Transform/Clean Raw Data. ETL

    BigQuery, a cloud data warehouse
    Google Data Studio, a relatively simple platform for reporting and visualization
	Google Cloud Dataprep, a data service for exploring, cleaning, and preparing structured and unstructured data. It's one of several Google data analytics services, including:
    Google Cloud Datalab, a more robust analytics tool that lets data professionals explore, analyze, transform, and visualize data and build machine learning models
    Google Cloud Dataflow, a platform for ingesting and processing real-time data
    Google Cloud Data Fusion, a cloud-native data integration service. It runs dataproc

	Datafusion and Dataprep can perform the same things. However their execution are different.
		- Datafusion create a Spark pipeline and run it on Dataproc cluster.
		- Dataprep create a Beam pipeline and run it on Dataflow.
		- Datafusion is more designed for data ingestion from one source to another one, with few transformation.
		- Dataprep is more designed for data preparation (as its name means), data cleaning, new column creation, splitting column. Dataprep also provide insight of the data for helping you in your recipes.

	Underlying Tech
		flow	Beam					Serverless		programming
		proc	Spark/Hadoop			GCE deployed	programming
		fusion	Dataproc(Spark/Hadoop)	GCE deployed	for data lake or DWH
		prep	Dataflow(Beam)			Serverless		for agile data exploration

- Cloud Data Fusion vs. Dataprep