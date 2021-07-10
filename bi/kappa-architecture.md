

データをストリームとして処理すること
	However, ユースケースが当てはまる場合を除き、Lambdaアーキテクチャーの代替にはなりません!
	Lambdaアーキテクチャーには多くのリアルタイムユースケースが適合しますが、Kappaアーキテクチャーについて同じことは言えません。
	バッチ分析とストリーミング分析が同じ場合は、Kappaを使用するのが最善の解決策です。
	ただし、場合によっては、バッチウィンドウで完全なデータセットにアクセスすると特定の最適化が起こるため、
	Lambdaの方がパフォーマンスに優れ、実装が簡単になる可能性があります。



https://www.oreilly.com/ideas/the-world-beyond-batch-streaming-101

ストリームデータ:
	時間とともに記録される
		-> doing something at time T
	変更されない
		-> record as 2 events: before at time1, after from time2


https://www.oreilly.com/ideas/questioning-the-lambda-architecture

	ストリームデータに対する操作は
		作成と閲覧
			だけ考えれば良い
	CRUDの中でも特に基本的なCRのみに操作を限定できるため、ストリーム処理エンジンは非常にシンプルな操作のみで済ませる


システムの中心となるストリーム処理エンジンについて、
	非ストリーム処理の発展である
		LambdaArchitectureと、		Lambda Architecture：ストリーム処理とバッチ処理を並行活用する処理エンジン
	ストリーム処理をより直接的に実現するための
		KappaArchitecture			Kappa Architecture：全てストリームで処理する処理エンジン



Log-structured data flow：ログを１つに集約する
	https://engineering.linkedin.com/distributed-systems/log-what-every-software-engineer-should-know-about-real-time-datas-unifying

KARTEにおけるストリーム処理
	https://codezine.jp/article/detail/10401


