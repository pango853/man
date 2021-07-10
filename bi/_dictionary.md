

Data HUB
	とは?	企業の標準データを一時的に蓄積し、複数のシステム間インタフェースを一カ所で管理するシステム. 近代的なデータセントリック・ストレージアーキテクチャ
	なに？	企業の複数のシステム間のデータを非同期で連携する機能や、コード（文字コード/値）やフォーマット（ファイル形式/レイアウト）、スキーマ（データ構造）の変換機能を提供
	なぜ必要?	システム間連携の見直しという共通のテーマがあり、組織全体のデータ・フローが大幅に効率化
	課題	1. 各アプリケーションのデータ要件が異なり、データのサイロが拡散してしまう。システム間インタフェースの管理が追い付かなくなった	2. 今日のビジネスに必要なスピードを備え、DXに対応したい	3. 非構造化データを用いたデータ分析を行いたい
	メリット：
		サイロを単一の統合インターフェースに統合し、すべてのデータに対応
		高速、高スループット、高性能のデータ・パイプライン
		全てのデータの可視性とアクセス性
		統合されたデータ・ストレージ管理インタフェース
	例	MarkLogic

データレイク
	膨大なデータを未加工のネイティブ形式で保存する一元管理のリポジトリです。そこから蓄積した非構造化データを活用できる。あらゆるデータタイプに対応！
	for both streaming and batch operations. By replacing data silos with a single home for structured, semi-structured and unstructured data, 
	
	Data Model	複数のデータモデル対応のファイルシステムであるHDFS
	例	Cloudera、Hortonworks、MapR -> Cloudera only, Amazon S3(多くの組織にとってオブジェクトストアが事実上のデータレイクとなり), SparkとKafka(for streaming)
		Confluent: Apache Kafka & Event Streaming Platform for the Enterprise
		Databricks - The Data and AI Company <- Powered by Delta Lake, the Databricks Lakehouse combines the best of data warehouses and data lakes
		Delta Lake - Reliability, security and performance for your data lake
	ユーザー	データサイエンティスト

データの仮想化
	SAS、Tibco、Denodo、Cambridge Semantics. Oracle、Microsoft、SAP、Informaticaなどその他のベンダーは、主力製品の一機能としてデータの仮想化を組み込んでいます。
	TIBCO Data Virtualization

DWH
	とは	データの分析を行う「ビジネスの観察」用のデータストア
	Use-Case	構造化データに関するBIとレポーティング
	Data	リレーショナル
	例	Snowflake, Redshift, Netezza, Teradata
	Case-Studies
		- 大手銀行が、トランザクションを扱うために、リアルタイムトレーディングシステムを稼働させています。これらのトランザクションは銀行内の複数のOLTPシステムで発生します。これらは、ETL（データの抽出/変換/読み込み）ツールを使用して、中心となるOLAP（オンライン分析処理）用データウェアハウスに集約されます。
	データハブと併用が多い。データがしっかり構造化され、きちんと定義されており、データウェアハウスの目的も定まっている場合には、データウェアハウスが便利です。
	ユーザー	ビジネス担当者


データマート
	データウェアハウスから派生した
	企業などで情報システムに記録・蓄積されたデータから、利用部門や用途、目的などに応じて必要なものだけを抽出、集計し、利用しやすい形に格納したデータベースのこと
	martは小売店


データハブ vs データレイク vs データの仮想化
	三つとも、データ統合の現代的なアプローチ
	

	REF:
		https://jp.marklogic.com/product/comparisons/data-hub-vs-data-lake/
		https://jp.marklogic.com/product/comparisons/data-hub-vs-data-warehouse/


Databricks
	例
		Azure Databricks - Azure用のApache Sparkベースの分析プラットフォーム



DX
	とは、	デジタルによりビジネスモデルや組織、業務プロセスなどを変革し、業績や顧客満足度を向上させること
	DXを実現するためには、SoR(Systems of Record)とSoE(Systems of Engagement) / SoI(Systems of Insight)を、必要なタイミングで連携できるような仕組みを備えておく必要があります。
		SoR	簡単に言うと、基幹系システムに代表されるような「記録のためのシステム」	IT部門が保守運用しています
		SoE	「顧客と繋がるためのシステム」	事業部門などIT部門以外が主体で導入～構築を行っています
		SoI	「洞察を得るためのシステム」


Business Intelligence vs. Business Analytics

		BI	BA
	-	o	o	Collects, Analyzes and Visualizes Data
	-	o	o	Identifies Pain Points
	-	o	o	Reporting
	-	o	x	Descriptive Analytics
	-	o	x	Diagnostic Analytics
	-	x	o	Predictive Analytics
	-	x	o	Prescriptive Analytics

	BI: In broad terms, business intelligence systems are used to maintain, optimize and streamline current operations. The term refers to technologies, applications and practices for the collection, integration, analysis and presentation of business information. The purpose of business intelligence is to support data-driven business decision making. 
		Popular business intelligence solutions include: QlikView, SAP BusinessObjects, Microsoft Power BI, IBM Cognos and Microstrategy.
	BA: Like business intelligence, BA collects and analyzes data, employs predictive analytics, and generates richly visualized reports in custom dashboards. The aim of these features is to help identify and address an organization’s weak points. 
		Popular business analytics solutions include: SAP Business Analytics Suite, Pentaho BA, Birst BI and Tableau Big Data Analytics.

Data Harvesting vs. Data Mining
	Data harvesting means getting the data and information from the online resource. Simply put it is just "data extraction".
	Data mining is the process to discover fact-based patterns you generate from a large set of data. It is not just  a process to obtain the data, but involves algorithms, machine learning, nor statistics.
		Four Key Applications: Regression, Clustering, Anomaly detection, Association learning
		


名寄せ
	e.g. 異なる言葉が同じ事象を表現しているかを判定するタスク　と定義
		e.g. Sansanで名刺のグルーピング
	レコード間の名寄せ(Entity Recognition/Deduplication)
		自然言語処理機械学習名寄せデータクレンジング
	Wikipediaより作成した日本語の名寄せデータセット
		https://github.com/yagays/nayose-wikipedia-ja
		結論としては、やっぱりかなり難しいタスクですし、対象とするドメイン依存だなというのが正直な感想です。
		ディープラーニングの成功事例でよく見かけるような、大規模なデータがあれば解決する問題ではないのは確かです。
	名寄せ（record linkage, Entity Resolution, Deduplication)タスクの研究で性能を測るデータセット
		Wisconsin-Madison大学のAnHai's GroupによるMagellan Project
		DBLP-ACM
		DBLP-Scholar
		https://dbs.uni-leipzig.de/en
		https://www.cs.utexas.edu/users/ml/riddle/data.html
		https://hpi.de/naumann/projects/repeatability/datasets/dblp-dataset.html
		https://archive.ics.uci.edu/ml/datasets/record+linkage+comparison+patterns
		https://sites.google.com/site/anhaidgroup/useful-stuff/data


# data-driven organization ...

# Data Mesh
	- a new, transformative architecture paradigm to break siloed data warehouses and data lake
	- Data Mesh can be described as a data-centric version of microservices <-> traditional perspective that big data must be centralized
	4 Core Principles:
		- Domain-oriented decentralized data ownership and architecture
		- Data-as-a-product
		- Self-serve data infrastructure as a platform
		- Federated computational governance
	- time to Data Mesh-based strategy? first ascertain based on the quality of data, the number of data domains, data teams and their size, bottlenecks in data engineering and data governance practices

# Dictionary
	キュレーション	データの エンリッチ、マスター管理、ハーモナイズ
	ELT			抽出/読み込み/変換
	DataOps		アジャイル開発の原則をデータレイヤーでのデータの管理に適用
	スキーマオンリード	スキーマは、キュレーション済みのデータに対して定義することも、クエリ実行時に定義することもできます
	オフロード		また使用頻度の低いデータを低コストなストレージであるHadoopにオフロードする
	データ・フェデレーション	とは社内に分散したさまざまなデータを仮想的に統合し、システム内のデータの可視化を実現する製品のこと
	データ・マイニング
	テキスト・マイニング
	ETL
	データ・クレンジング	データ形式の統一、正規化

	Semi-structured	Example of semi-structured data is a data represented in an XML file. We can see semi-structured data as a structured in form but it is actually not defined with e.g. a table definition in relational DBMS.



