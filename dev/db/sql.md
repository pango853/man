

■2．索引を使用しない : BAD!
	NULL比較			Unallow NULL
	NOT(!=)を使用		Will be full scan! Better use IN, OR instead
	列を演算している
		SQL> SELECT * FROM tab1 WHERE c1 / 10 < 10000;		-> SELECT * FROM tab1 WHERE c1 < 100000;
		SQL> SELECT * FROM tab1 WHERE SUBSTR(c2,3,4) = 'AAAA';			-> CREATE INDEX ix_c2 ON tab1 (SUBSTR(c2,3,4));

	後方一致（中間一致）条件
	複合インデックスの順番を無視、つまり複数列索引の二個目以降の列に対する検索
		・列c1,c2の複合索引（複数列索引）
		・列c3の索引
		に対して、
		SQL> SELECT * FROM tab1 WHERE c3 LIKE '%AA';	-> 索引は先頭からの条件指定でないと使用されません. できるだけ高速にしたい処理には前方一致条件による索引
		SQL> SELECT * FROM tab1 WHERE c3 LIKE '%A%';	-> OR, 列c3に（チェックする文字位置が固定であればLIKEをSUBSTR関数にして）ファンクション索引を作成する
		SQL> SELECT * FROM tab1 WHERE c2 = 10;			-> 列c2に索引を作成すべき
	INリストまたはORを使用
		SQL> SELECT * FROM tab1 WHERE c1 = 100 OR c2 = 200 OR C3 = 300;
		EXPLAIN PLANしたら、TABLE ACCESS (FULL)になる。
		SQL> SELECT * FROM tab1 WHERE c1 = 100
		  2   UNION ALL
		  3  SELECT * FROM tab1 WHERE c2 = 200
		  4   UNION ALL
		  5  SELECT * FROM tab1 WHERE c3 = 300;
	その他、
	INとEXISTSについて
		以下二つは実行結果が同じだが、
		SQL> SELECT * FROM tab1 WHERE c1 IN (SELECT c1 FROM tab2);                          -> 実行計画を見ると一意性処理（HASH UNIQUE）が行われているのが分かります。一意性処理は、副問合せの結果件数が多いと負荷が大きくなる!
		SQL> SELECT * FROM tab1 WHERE EXISTS (SELECT * FROM tab2 WHERE tab1.c1 = tab2.c1);  -> ???どうでしょうかね
		Better: SQL> SELECT tab1.* FROM tab1, (SELECT DISTINCT c1 FROM tab2) t2 WHERE tab1.c1 = t2.c1; // 結合は件数を絞り込んでから、重複データが多い場合は効率が良い可能性がある

	結合は件数を絞り込んでから
		SELECT A.c2, count(*) FROM tab1 A, tab2 B WHERE A.c1 = B.c1 AND B.c2 = 10 GROUP BY A.c2;
		-> 面倒くさいが、
		SELECT A.c2, SUM(ct) FROM tab1 A, (SELECT c1, count(*) ct FROM tab2 WHERE c2 = 10 GROUP BY c1) WHERE A.c1 = B.c1 GROUP BY A.c2;
	ソート処理はできるだけ少ない件数で
		SELECT * FROM (SELECT ... FROM tab1 ORDER BY c1) WHERE ROWNUM < 101;		-> ソート領域に100件しか格納しないので、ソート処理の負荷を軽減できます

		SELECT c1, COUNT(*) FROM tab1 GROUP BY c1 ORDER BY c1;		// SORT GROUP BY一回だけ
		-> GROUP BYをハッシュ分割で実行（HASH GROUP BY）してレコード数を少なく（GROUP BY列の重複度が高くないと少なくならないので注意）してからORDER BY（SORT ORDER BY）を行った方が効率よい場合もあります。これはハッシュ分割の方が偏りが少ないからです。アクセスする件数が多く、ソート処理でプロセスにデータが偏っている場合は効果が良い可能性がある
		SELECT /*+ NO_MERGE(A) */ * FROM (SELECT c1,COUNT(*) FROM tab1 GROUP BY c1) A ORDER BY A.c1; // HASH GROUP BYを行うよう, NO_MERGEヒントは念のため（インラインビューがマージされないようにするために指定しています）
		SELECT /*+ USE_HASH_AGGREGATION */ c1, COUNT(*) FROM tab1 GROUP BY c1 ORDER BY c1;	// 

【原因①】ORMが生成するSQLを確認していない
【原因②】複合インデックスを適切に使えていない
【原因③】複合インデックスの走査範囲を考慮していないため、大なり小なり記号やBETWEENが遅い
	e.g. 複合インデックスが(誕生日, 部署ID)で設定されているとして、WHERE句として「誕生日（BETWEEN句）」「部署ID(=句)」を使用した場合、まずはBETWEEN句により誕生日の大小比較の走査が走り、その後に部署IDが走査されるため、検索される範囲が非常に広くなってしまうんです。
		-> (部署ID, 誕生日)という順の複合インデックスに変えることで改善
【原因④】LIKE句において、ワイルドカードが文字列の前方についている
	どうしても、それでも後方一致検索をしたいときは？リレーショナルデータベースが苦手とする領域になるので、代わりにElasticsearchやApache Solrなどの全文検索システムを使うことが必要
【原因⑤】テーブル結合が不得意なデータベースで、テーブル結合を多用している
	テーブル結合のアルゴリズムには「ネステッドループ結合（Nested Loop Join）」「ハッシュ結合（Hash Join）」「ソートマージ結合（Sort Merge Join）」という3種類があります。この中で、最もテーブル結合の処理が遅くなる可能性が高いのが「ネステッドループ結合」です。これは、1つ目のテーブルの各行に対して、2つ目のテーブルの対応値を引き当てるアルゴリズムです。
	残念なことは、MySQLはネステッドループ結合のみ。「複雑なアルゴリズムはなるべくサポートしない」という設計思想に基づいて作られているからです。
【原因⑥】ORDER BY / GROUP BYで、大量のソートが発生している
【原因⑦】データ量が増えると処理が重たい。「良くないSQL」を書いているから
【原因⑧】複数クエリの総実行時間が長い
	「処理が重たいけれど、たまにしか発行されないクエリ」を改善するよりも「処理が軽いけれど、頻繁に発行されるクエリ」を改善した方が効果的なケースも多いです。



- 索引スキップ・スキャンについて
    SQL> SELECT * FROM tab1 WHERE c2 = 10;

　このとき列c1の値が'A'と'B'だとすると、内部的には以下のSQL文のように実行して索引スキャンを行います。つまり、先頭の値のカーディナリティが高いと効率が悪いことになります（そのような場合や条件のヒット率が高い場合はオプティマイザが選択しないようにすると思います）。

    SQL> SELECT * FROM tab1 WHERE c1 = 'A' AND c2 = 10
     2   UNION ALL
     3  SELECT * FROM tab1 WHERE c1 = 'B' AND c2 = 10;

- ANSI準拠の結合文
	SQL> SELECT * FROM tab1 left outer join tab2 ON tab1.a = tab2.a WHERE tab2.b = 10;
	SQL> SELECT * FROM tab1 left outer join tab2 ON tab1.a = tab2.a AND tab2.b = 10;    上と結果が違うよ!
	-> わかりやすいかも
	SELECT * FROM tab1 left outer join (SELECT * FROM tab2 WHERE b = 10) B ON tab1.a = B.a;





