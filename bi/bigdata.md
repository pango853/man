

Big Data definition : Big Data is defined as data that is huge in size.
Bigdata is a term used to describe a collection of data that is huge in size and yet growing exponentially with time.

なので、ビッグデータというのはデータのサイズではなく、収集するデータが持つ大まかな特性に注目したほうが良いと思います。
	データ量の多さを示すVolume、種類の多さを示すVariety、リアルタイム性を示すVelocity
	今はむしろ「活用によってどういう効用が期待できるのか？」という点に


Definition
	there’s no universal definition, but there are multiple ways to think about it.
	we can’t define it in quantifiable terms alone. The actual size isn’t important in this definition
Examples
	IDC predicts that by 2025, the world’s data will grow to 175 Zettabytes. (To put that in perspective, if you attempted to download 175ZB at the average current internet connection speed, it would take you 1.8 billion years to download!)
	On average, there are about 500 million tweets sent every day.
	According to Nerdwallet, the average smartphone owner uses 2 to 5 GB on his or her cell phone plan each month.
	Walmart processes one million customer transactions per hour.
	Amazon records $283,000 in sales per minute.
	On average, office workers each receive 110 to 120 emails per day, equaling approximately 124 billion emails on any given day.
	According to the 2019 Federal Reserve Payments Study, total card payment transactions reached 131.2 billion with a value of $7.08 trillion in 2018, representing growth of 8.9 percent in volume year-over-year.


ビッグデータの特徴/Characteristics
	ビッグデータ4つのV
		Volume	現状では数テラバイトから数ペタバイト程度のデータ量という見方が多いようです
		Variety	これら非構造化データの中には以前から存在し蓄積されてきたものもあります。今後は、単に蓄積するだけでなく、これを分析し、そこから有用な知見を得ようとする取り組みが始まっています
		Velocity	リアルタイムに対応することが求められています
		Value		データを分析することで未来の予測や異変の察知等を行い、利用者個々のニーズに即したサービスの提供、業務運営の効率化や新産業の創出等が可能となっている


https://www.soumu.go.jp/johotsusintokei/whitepaper/ja/h24/html/nc121410.html

鈴木良介著「ビッグデータビジネスの時代」（平成23年11月）p.14参照:
	ビッグデータを
		「事業に役立つ知見を導出するためのデータ」とし、
	ビッグデータビジネスについて、
		「ビッグデータを用いて社会・経済の問題解決や、業務の付加価値向上を行う、あるいは支援する事業」
		と目的的に定義している

総務省｜平成24年版 情報通信白書
https://www.soumu.go.jp/johotsusintokei/whitepaper/ja/h24/html/nc121440.html
	第1部　特集　ICTが導く震災復興・日本再生の道筋
	第1節　「スマート革命」　―ICTのパラダイム転換―
	（4）ビッグデータの戦略的活用に向けた諸外国の取組



「鶴見大学紀要」第 51 号 第 4 部 https://core.ac.uk/download/pdf/229095855.pdf
	レーショナルデータベースのような構造化されたデータに対し、「ビッグデータ」は非構造化データといわれている。 


Examples ("Big" Data, but not really Big Data yet until it is utilized)
	Finance	New York Stock Exchange		one terabyte of new trade data generated per day
	Social	Facebook					500+terabytes of new data in terms of photo and video, messages, comments, get ingested into the databases every day
	Public	Airline company				10+terabytes of data in 30 minutes of flight time generated at a signle jet engine. For all flights a day, it is Petabyte level

Benefits 
	- Businesses can utilize outside intelligence while taking decisions
		Access to social data from search engines and sites like facebook, twitter are enabling organizations to fine tune their business strategies.
	- Improved customer service
		In these new systems, Big Data and natural language processing technologies are being used to read and evaluate consumer responses.
	- Early identification of risk to the product/services, if any
	- Better operational efficiency
		e.g. Big Data technologies can be used for creating a staging area or landing zone for new data before identifying what data should be moved to the data warehouse.



Big data best practices
	Align big data with specific business goals
	Ease skills shortage with standards and governance
	Optimize knowledge transfer with a center of excellence
	Top Payoff is aligning unstructured with structured data
	Plan your discovery lab for performance
	Align with the cloud operating model
	



# File Format
columar file formats store data by column, not by row

row-based: CSV, TSV, JSON, Avro
columnar: Parquet, ORC

```json
{"id": 1, "first_name": "Matthew", "last_name": "Rathbone", "age": 19, "cool": true, "favorite_fruit": ["bananas", "apples"]}
{"id": 2, "first_name": "Joe", "last_name": "Bloggs", "age": 102, "cool": true, "favorite_fruit": null}
```

```csv
1, Matthew, Rathbone, 19, True, ['bananas', 'apples']
2, Joe, Bloggs, 102, True,
```

CCSV (Columnar CSV): Field Name/Field Type/Number of Characters
```ccsv
	ID/INT/3:1,2
	FIRST_NAME/STRING/11:Matthew,Joe
	LAST_NAME/STRING/15:Rathbone,Bloggs
	AGE/INT/6:19,102
	COOL/BOOL/3:1,1
	FAVORITE_FRUIT/ARRAY[STRING]/19:[bananas,apples],[]
```

- Saving processing power for searching
- Compression Improvements

- re-constructing a complete record is slower
- more CPU and ram intensive to write

# WHY
- why data lake
	https://aws.amazon.com/big-data/datalakes-and-analytics/what-is-a-data-lake/

- why data governance
	The main challenge with a data lake architecture is that raw data is stored with no oversight of the contents.
	For a data lake to make data usable, it needs to have defined mechanisms to catalog, and secure data.
	Without these elements, data cannot be found, or trusted resulting in a “data swamp."
	Meeting the needs of wider audiences require data lakes to have governance, semantic consistency, and access controls.


# Data Governance
	...is an enterprise framework that aligns people, processes and technology, helping data users understand and transform data into a business asset.
	It also delivers visibility into data, allowing organizations to reduce risk presented by global data privacy laws.

# Data Catalog
	Data catalogs are a dictionary of knowledge about the data and processes an organization uses to manage and consume data.
	Data catalogs arrange data into a simple, easy to understand format so all data users can consume and use it.
	A data catalog is a core component of data governance.


# Market

- https://www.marketwatch.com/press-release/data-lakes-market-to-touch-an-aggregate-of-1201-billion-by-2024-growing-at-a-cagr-of-278-2019-04-18
	According to a recent market study by Advanced Market Analytics, the global data lake market is anticipated to reach $12.01 billion by 2024 at a compound annual growth rate (CAGR) of 27.8%.
	Hence, several public cloud vendors offer data lake solutions, and Amazon is not the only one with a data lake service.
	Microsoft has been offering Azure Data Lake for quite some time, and Google has a suite of data lake processing and analytics tools in Cloud Datalab, Dataproc, and Dataflow. 

- https://www.businesswire.com/news/home/20210210005664/en/Data-Lakes-Market-Report-2021---Global-Forecast-to-2026---ResearchAndMarkets.com
	Data Lakes Market Report 2021 - Global Forecast to 2026 - ResearchAndMarkets.com
	The Data Lakes Market was valued at USD 3.74 billion in 2020 and is expected to reach USD 17.60 billion by 2026, at a CAGR of 29.9% over the forecast period 2021 - 2026. 

- https://www.researchandmarkets.com/reports/4602227/data-lakes-market-growth-trends-covid-19?utm_source=BW&utm_medium=PressRelease&utm_code=358dnf&utm_campaign=1499491+-+Data+Lakes+Market+Report+2021+-+Global+Forecast+to+2026&utm_exec=chdo54prd
	Data Lakes Market - Growth, Trends, COVID-19 Impact, and Forecasts (2021 - 2026)
	The Data Lakes Market was valued at USD 3.74 billion in 2020 and is expected to reach USD 17.60 billion by 2026,
		at a CAGR of 29.9% over the forecast period 2021 - 2026.
	Data lakes have become an economical option for many companies rather than an option for data warehousing.
	Data warehousing involves additional computing of data before entering the warehouse, unlike data lakes.
	The cost of maintaining a data lake is lower than a data lake owing to the number of operations and space involved in building the database for warehouses.

- https://www.grandviewresearch.com/industry-analysis/data-lake-market
	Data Lake Market Size, Share & Trends Analysis Report By Type (Solution, Services), By Deployment (Cloud, On-premise), By Vertical (IT, BFSI, Retail, Healthcare), By Region, And Segment Forecasts, 2020 - 2027


Dremio Corporation



# Dictionary

- Data Enrichment
	In their very practical book about Multi-Domain MDM, Mark Allen & Dalton Cervo elaborate the data enrichment term as a "process of enhancing existing information by supplementing missing or incomplete data."
- Data stewardship
	It is a role, for MDM.
	Data stewardship is the discipline for defining, implementing, and enforcing the accountability and responsibility of the organization’s data stakeholders.
	Quality Data is his responsibility! Data stewardship is to ensure quality data for everyone.
		Incl. Data enriching.
	https://www.youtube.com/watch?v=pR53YPtS454

- MDM
	is the process of defining, managing, and making use of an organization’s master data so it is visible and accessible via a single reference point.
	keep trace sources and maintain its master data
		can matching with scoring machanism (trust score/match score)


MAP:
Data Management
	Incl.
	Data Quality
	Data Integration
	Master Data Management
	Data Modeling
	Data Preparation
	Modernizing data warehouse (Hadoop, Stream, NoSQL, In-Memory db, Data Lakes, etc.)
	Ecosystem Architectures
	Data Security
	+ Data Governance			<- is a key component of data management
		- Who has ownership of the data?
		- Who can access what data?
		- What security measures are in place to protect data and privacy?
		- How much of our data is compliant with new regulations?
		- Which data sources are approved to use?

MDM is one type of Data Management.

REF: https://tdwi.org/portals/master-data-management.aspx


# Relations (Versuses)

Data integration tightly integrated with Data Catalog + Data Governance

Data Lineage vs. Master Data Management
	Data Lineage belongs to Data Catalog, or MDM

data quality vs. data integrity
data governance vs. data catalog
	data catalog is an conponent in data governance
	Data catalogs have become the standard for metadata management
metadata management vs. master data management
data analytics vs. business intelligence




Data Management
	The technologies, architectures, and practices needed to manage data as a critical enterprise asset. It is a broad field, within which there are specialized disciplines.
	TOPICS INCLUDE:
	- Data Quality
	- Data Integration
	- Master Data Management
	- Data Modeling
	- Data Preparation
	- Modernizing data warehouse (Hadoop, Stream, NoSQL, In-Memory db, Data Lakes, etc.)
	- Ecosystem Architectures
	- Data Security


Analytics, Data Science & Business Intelligence
	The technologies, techniques, and algorithms for analyzing all kinds of data to derive insights and take action for better decision making and enterprise success.
	TOPICS INCLUDE:
	- OLAP
	- Dashboards
	- Visual Analytics/Discovery
	- Geospatial Analytics
	- Click Stream Analytics
	- Data Mining/Predictive/Machine Learning/Neural Networks
	- Text Analytics/Social Analytics
	- Stream Analytics
	- IoT Analytics
	- Other Big Data Approaches
	- Cognitive Computing

Methodologies & Strategies
	The processes and approaches to deliver business value through data and analytics. Includes a strong focus on leadership strategies and organizational management to maximize data management and analytics impact.
	TOPICS INCLUDE:
	- Agile Development
	- Performance Management
	- Change Management
	- Leadership Strategies
	- Organizational Models for Analytics Execution
	- Programming Skills: R, Python, Java for Data Science
	- LifeCycle Management
	- Storytelling with Data
	- Governance
	- Ethics

Development, Deployment & Delivery
	Languages and software environments for analytics development as well as analytics deployment and delivery models to help organizations achieve their goals.
	TOPICS INCLUDE:
	- On Premises, Public, Private, Hybrid Cloud
	- As a Service, IaaS, PaaS, SaaS
	- Operationalizing Analytics and Decision Science
	- DevOpps


REF: https://www.altexsoft.com/blog/analytics-maturity-model/

Stages of analytics maturity

	1. No analytics - refers to companies with no analytical processes whatsoever.
	2. Descriptive analytics - lets us know what happened, gathering and visualizing historical data.
	3. Diagnostic analytics - identifies patterns and dependencies in available data, explaining why something happened.
	4. Predictive analytics - creates probable forecasts of what will happen in the future, using machine learning techniques to operate big data volumes.
	5. Prescriptive analytics - provides optimization options, decision support, and insights on how to get the desired result.


# ROI
First, Big data is not a product or a service! It's a per-basis approach. Set an expectation/objective -> analyze data -> convert into actionable insights.
Big Data projects, like any other business investment, need to prove their worth.
Most organizations define worth as ROI, which presents a problem for Big Data.
Measuring the return on investment is a process developed by the manufacturing industry -- one that quantifies tangible results.
Big Data is to make people smarter, accurately predict the future, and drive better decision-making -> How to measure?! At least are not immediately measurable

From other Surveys:
	89% of those surveyed believe that Big Data analytics is an essential factor in remaining competitive and increasing market share.
	75% saying that growth is the key value of analytics.
	reduce operational expenditures: Computing costs dropped an average of 33% annually
	cut the cost of storage by 38%
	and slashed bandwidth costs by 27%
Two Paths to Big Data ROI:
	1. Assess the cost of big data projects against alternative approaches
		e.g. vs OLTP technology to expand DWH, ERP -> millions <--> achieve the same result using a Hadoop framework for about $200,000
	2. Measure the value of big data insight
		Run an PoC to measure using cloud storage and resources.
		If the results from the proof of concept are promising, you can move to the next stage.
	3. Measure Time-to-Insight as Well as ROI
		

# Architectures
		REF: https://www.altexsoft.com/blog/real-time-analytics/
	- Streaming Analytics -> Stream Processing, Data Streaming, and Real-time Analytics
		NOTE: Stream and batch processing can be combined into one analytical platform
		<AWS>
			Kinesis Streams, Kinesis, and Firehose
		<GCP>
			Google Cloud Stream Analytics - Pub/Sub, Dataflow, BigQuery + Google Cloud BI / Google Data Studio
		<Azure>
			Azure Stream Analytics + Power BI		
		Example:
			- Uber: Chaperone auditing tool -> tracking location , fraud detection for user payments
			- Netflix: Keystone Streaming Platform and Mantis
			- IoT sensors
			- Server and security logs
			- Real-time advertising
			- Click-stream data from apps and websites		
	- OLAP
	- Dashboards
	- Visual Analytics/Discovery
	- Geospatial Analytics
	- Click Stream Analytics
	- Data Mining/Predictive/Machine Learning/Neural Networks
	- Text Analytics/Social Analytics
	- IoT Analytics
	- Other Big Data Approaches
	- Cognitive Computing




# Other products

- Oracle Stream Analytics, Oracle GoldenGate
- IBM Streaming Analytics, IBM Streams, IBM Cloud


