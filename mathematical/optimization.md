
# 組合せ最適化問題
REF: https://www.msiism.jp/article/tanabe-combinatorial-optimization1.html

下の3例とも、結果は表のセルに適切な数字（0、1、2、3、4）や記号（「日」「休」「夜」「－」）を書き込めば表現できます。
すなわちこれらの問題を解くということは、何らかの条件を満たすセルの数字や記号の離散的な組合せを探すことと同じ。
このような問題のことを組合せ最適化問題と言います。

居酒屋ランチ営業バイト募集問題
	constraints
		各時間帯で必要な人数を定めておく	e.g. 仕込みの時間では4人、ピークのお昼時には8人は欲しい。
	rules
		シフト設定: いずれも4時間勤務で9:00スタートから13:00スタートの5パターンとする
	objective functions
		min f(x)
		x = x_shift_{1..5}
	algorithm
		???
	result
		最適シフト
			シフトパターンごとに何人必要かを算出する
			各パターンの人たちがそれぞれ供給する労働力を重ねたグラフを描いて(グラフ: 横軸時間帯,縦軸人数,色はパターン)みて、各時間帯で必要な人数のグラフと比較すればわかる
	application
		現人員と彼らの希望パターンを入れて、不足しているのを算出するのもできる
	feedback
		人数が多くなると、これって最適なのって直感的にわからない可能性がある
		経験次第かもだが、managerが全く白紙の状態から作ってみろと言われてもどうすればよいのかとっかかりが掴みにくいだろ、
		エクセルにでも向かってとにかく数字をいれてなんとなく調べて答えを出すしかないが、これで自動化、最適化できる

シフトスケジュール問題
	A、B、C、D、E さんの一週間の勤務シフト表があるとする。表には「日」、「夜」、「休」、「―」で埋める。「日」は日勤、「休」は休暇、「夜」は夜勤、「－」は夜勤の翌日に入る非番を示しています。
	constraints
		- 職場をうまく回すためには日勤は2人以上、夜勤は必ず1人が必要		
		- 夜勤は一週間で2回以下に抑える	職場の都合だけを優先するわけにもゆかず、みなさん体が辛いので
	rules
		- 夜勤の翌日に入る非番
		- Eさんは新人なので誰か（この答えではDさん）と一緒に夜勤する、という制約もある
	objective functions
		???
	algorithm
		???
	feedback
		エクセルの得意な人なら勤務が足りないところの色が変わるといったシートをあっという間に作ってしまいそうです。ただ、これも全く白紙の状態から出すとなるとやはりあれこれ試行錯誤してみるしかない感じです。

段取り替えコスト最小化問題
	4種類の製品を決められた数だけ作ろうとしています。
	あなたの工場には等しい能力を持つ A から F の6つのラインがあって、どのラインでどの製品を作ることもできる前提とする
	作る製品の「並び」によってはラインの機器の設定を変更したりと結構なコストがかかる、どの程度のコストがかかるかは並びの組み合わせによって違うから、整理してみる
	切り替えコストがあるため、作る順番にはかなり慎重にならねばならない。製品を過不足なく作って、製品並びに起因するコストを最小にせよとの問題です
	constraints
		段取り替えコスト表: 両軸に製品番号のMatrixを作り、セルにはある製品から別製品に切り替えコストを書く。当然対角線は0(同じ製品なのでコスト0)
			e.g. 製品4→製品3を並べたらコストは1だが、製品4→製品1と並べるとコストが10
		製品個数表		製品番号と個数の表
	result
		割り当て表	縦軸がA~Fの6のライン、横軸が時間(1時間ごと変えられるとする)
	feedback
		問題を根本に変えて、各ラインで作るものをFIXし、人を別のラインにシフトさせる場面もありそう。面白い問題だね

Sum up
	一週間のシフト表のケースでは、マス目の数が35、入る記号の種別が4つであることから計算すると、有り得る設定の種類は10の21乗通り!
	1億を2乗してもまだ足りず、それをさらに10万倍した膨大な通り数になります。

	ラインへの製品割り当ての問題ではマス目数が60、書き込む製品の種類が何もやらないときを含めて5通り、という大雑把な計算で
	（左詰めにするという制約を考えるともうすこし小さいですが）シフト表の通り数を2乗しただけの通り数になります。

	この「全組合せ数」はセルや書き込む数字の数を増やすとあっという間に膨大な数になる（組合せ爆発、と言います）ので、
	組合せ問題の難しさを強調するときにはじつに便利な数字であります。
	「一兆（とかなんとか、とにかく天文学的に大きな数）通り以上の膨大な組合せからアルゴリズムが正解を選び取る」とかいう文言を目にされた方もきっと多いでしょう。

	人間の経験と勘によるヒューリスティクスはかなり優秀で、何度か似たような問題設定で答えの探索を繰り返していると、「慣れ」てきて、それほど苦労なく比較的満足行く結果の一つや二つ、出すことができます。
	でも、普段そうやって出している答えがどの程度良いものなのか、もっと良いものがあるのではないか、考え始めるときりがないのではないでしょうか。

	NOTE: It is not to challenge people. Like compare the optimizer's result with people's and then decide the ROI is not recommended.


特徴
	たまたま正解につながる探し方を思いつくか、思いついて見つけるまでどれくらいかかるかなんて、あらかじめ読めない
	どうなるか「読む」のが大変、という「難しい」問題
	幸い計算機は多少の面倒なら代わりに引き受けてくれて目にも止まらぬ速度で結果を出してくれるので、我々は計算機に解き方の指針を与えて「難しい」問題を「面倒」に変換する技を繰り出すのです。

	例えば5万変数でも1分と待たずに結果が得られるようになった線形計画問題を我々は「難しい」とは認識しません。コンピューターが計算が得意だから。難しいかった問題を「面倒」に変え、そしてコンピュータで「読める」範囲にする



線形計画問題



難しくても向き合う「組合せ最適化」

	セールスマンが幾つかの都市をもれなく重複なく回る順路で、経路の総延長が一番短いものを求めなさい、という問題には「巡回セールスマン問題」という名前が付いて、厳密に解こうとするとどんなに時間があっても足りない
	確かにこれを全列挙（すべての都市の並べ替えをもれなく探索する）という方法で解こうとすると、都市の数が20個でも順路の総数は 100万×100万×100万 くらい(2^20)、という莫大な数になるので、確かにちょっとしたものです。
	物流・配送のご相談によく現れる車両巡回問題（ヴィークル・ルーティング）という問題は、この問題をさらに一般化したものに相当します。
	具体的に言うと「セールスマン（配送車）」が複数になり、「各都市（配送先）」を訪れる時刻に制限（タイムウインドウ）がついて、何かしらのアクション（荷卸しや積み込み）とかもあわせて考え、回る順路を計画する問題ですから一般的に考えればこちらも輪をかけた難問、ということになるでしょう。




# Q&A
https://www.msiism.jp/article/b-backstage21.html

- 「お客さんに数学が役に立つことをどうやって知ってもらうのか」
	そのためにこういうイベントに参加したり、セミナーやったりしているけれど、一番難しいポイントです。
- 「取り組むべきプロジェクトをどうやって選んでいるのか」
	要求が具体的か、データがあるか、結果が出せそうか、という尺度でしょうか。
- 「良い答がでなかったらどうするのか」
	エキスパートの答に勝つのは大変ですが、自動化によって業務のプロセス自体を変革できることは確かなので、それを含めて評価してもらうようにしています。
- 「大域的な「最適化」と、今より改善する「最適化」の違いをどうやって説明するのか」
	正直言いますと、大域的な方で人を引き付けておいて、やっていることは「改善」というのが実際のところという場合が多いですね。大域的な方を意識するとなかなか話がまとまらないですし。
- 「フリーソフトは産業界ではどのように受け入れられているのか」
	我々のような商用ソルバーベンダーには脅威という側面はあるけど、手軽に使えるという意味で最適化を広めてくれている存在とも言えます。産業界は動作の保証が重要だからメンテナンスが必要とされることで商用が志向される部分はあるでしょうか。
- 「機械学習がやはり産業界でも注目されているのか」
	深層学習は細かなエンジニアリングをしなくてもある程度の精度の結果が出せる、という結果が驚きと期待に繋がっているように見えます。新しい有効な手法の発見であることは確かだと思うけど何でも解けるわけではないです。

という一般的な質問（私の行った回答の趣旨を下に書きました）の他、当社の業態に対して

- 「ソルバー作り」と「数理最適化案件のコンサル」は要求されるスキルが違うけれど、異なるチームがやっているのですか。
	という質問も受けました。我々は、同じ組織で両方やっていて、同じ人がソルバーを実装したり、コンサルティングしたりすることも多いので、アルゴリズムと実装を知っていることがコンサルティングにも確実に役に立つ、と答えましたが、確かに両方やっているのは珍しくも見えるのかな、とちょっと嬉しいような気もしました。




# TODO

https://www.youtube.com/watch?v=SBfns7LWRmQ&feature=youtu.be
