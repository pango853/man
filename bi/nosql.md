
When it comes to NoSQL, the decision becomes difficult because every NoSQL database offers different solutions and you have to understand which one is best suited for your app/system requirements.
For example,
	- MongoDB is fit for use cases where your system demands a schema-less document store.
	- HBase might be fit for search engines, analyzing log data, or any place where scanning huge, two-dimensional join-less tables is a requirement.
	- Redis is built to provide In-Memory search for varieties of data structures like trees, queues, linked lists, etc and can be a good fit for making real-time leaderboards, pub-sub kind of system.
		Similarly there are other databases in this category (Including Cassandra) which are fit for different problem statements.
	- Cassandra offers a solution for problems where one of your requirements is to have a very heavy write system and you want to have a quite responsive reporting system on top of that stored data. Consider the use case of Web analytics where log data is stored for each request and you want to built an analytical platform around it to count hits per hour, by browser, by IP, etc in a real time manner.

