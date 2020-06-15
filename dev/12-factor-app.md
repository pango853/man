
# The Twelve Factors	published in 2012
I    Codebase             There should be exactly one codebase for a deployed service with the codebase being used for many deployments.
II   Dependencies         All dependencies should be declared, with no implicit reliance on system tools or libraries.
III  Config               Configuration that varies between deployments should be stored in the environment.
IV   Backing services     All backing services are treated as attached resources and attached and detached by the execution environment.
V    Build, release, run  The delivery pipeline should strictly consist of build, release, run.
VI   Processes            Applications should be deployed as one or more stateless processes with persisted data stored on a backing service.
VII  Port binding         Self-contained services should make themselves available to other services by specified ports.
VIII Concurrency          Concurrency is advocated by scaling individual processes.
IX   Disposability        Fast startup and shutdown are advocated for a more robust and resilient system.
X    Dev/Prod parity      All environments should be as similar as possible.
XI   Logs                 Applications should produce logs as event streams and leave the execution environment to aggregate.
XII  Admin Processes      Any needed admin tasks should be kept in source control and packaged with the application.


# Beyond the 12 Factor App		by Pivotal
<https://content.pivotal.io/ebooks/beyond-the-12-factor-app>

- Factor 1. One Codebase, One Application
- Factor 3. Dependency Management
- Factor 4. Design, Build, Release, Run
- Factor 5. Configuration, Credentials, and Code
- Factor 6. Logs
- Factor 7. Disposability
- Factor 9. Environment Parity
- Factor 10. Administrative Processes
- Factor 11. Port Binding
- Factor 12. Stateless Processes
- Factor 13. Concurrency
NEW from the-12-factors:
- Factor 2. API First
- Factor 14. Telemetry
- Factor 15. Authentication an Authorization


## Factor 1. One Codebase, One Application
1つのコードに1つのアプリケーション
アプリケーションごとにバージョン管理されている1つのコードベースがあるか
1つのコードベースから複数の環境(dev/stg/prd)に対してのデプロイが可能か
例) 環境毎に異なる値は環境変数から読み込むようにコーディングする
単一のコードベースに複数のチームが存在する場合、Conwayの法則を利用して、マイクロサービス化してコードベースの分割を検討しても良い

## Factor 2. API First
APIから設計を開始する
最初にAPIを設計することで、Web側、モバイル側、またAPIを利用したい他のチームとの調整も容易になる
APIファースト開発をサポートする為のツールを使用する
例) Swagger, Apiary
CIにより結合点を継続的にテストすることで、チームそれぞれが独自のサービスに注力できる

## Factor 3. Dependency Management
依存関係管理
依存関係が明示的に宣言・分離されているか
例) マニフェストファイルに依存するライブラリを記述し、記述外のライブラリを利用して動作することの無いように起動する
Developerが依存関係を宣言し、それらの依存関係が満たされていることをツールで確認すること
例) Maven, Gradle, NuGet, Bundler, godeps etc
リリース成果物にサーバーまたはコンテナーを埋め込む形が理想

## Factor 4. Design, Build, Release, Run
設計、ビルド、リリース、実行
Design, Build, Release, Run それぞれ個別のフェーズで実施する
自動テストとデプロイを行い、高い信頼性を保ちながらCIスピードを最大化する
Design
依存関係を宣言する。それぞれのライブラリがリリース時にどのようにバンドルされるかを決定する
Build
コードが実行可能アーティファクトに変換される
設計時に宣言された依存関係が含まれ、成果物にまとめられる
ビルドはCIサーバによって作成されるのが理想的
1つのビルドを任意の数の環境にリリースまたは展開できるようにする
1つのビルド、多数のデプロイ
Release
ビルド段階の成果物と環境毎の設定と組み合わせ、実行できる形にする
一意のリリースIDをもたせること
参考) https://semver.org/lang/ja/
問題が発生した場合にそなえ、以前のリリースにロールバックできること
Run
アプリケーションがコンテナに配置されてから、起動するためのプロセスを開始する
アプリケーションが実行されると、マネージドサービスは、実行を監視し、ログを集約し、スケールアウト／インに対応する

## Factor 5. Configuration, Credentials, and Code
設定を環境変数に格納する
環境毎に異なる設定は環境変数に格納しているか

デプロイ時に異なる値をコードから分離する
・URLなどバッキングサービス、Webサービス、SMTPサーバ
・DB接続先
・AWSなどのサードパーティサービスへの認証情報

正しく設定を分離できているかの確認は、 すぐにコードをGitHubに公開できるか否か
注) アプリケーション内部の設定についてはコードに書いてもOK

もしくは設定を公開するように設計されたサーバを使用する。
例) Spring Cloud Configuration Server

環境毎に設定群を定義していないか

クラウドネイティブの場合、環境毎の設定を、
プロパティファイル、YAML、XMLなどに定義することをアンチパターンとしています
例) dev用, stg用, prd用などで用意するとスケールしづらいためNG
設定の外部化はCDパイプラインを介して各環境別にアプリケーションをデプロイする機能をサポートする


## Factor 6. Logs
ログはイベントストリームとして扱う
ログを標準出力(stdout)として扱っているか
ログファイルに書き込んだりしていないか。ログは外部のログ解析サービスなどに送信する
クラウドネイティブなアプリケーションはログのルーティングや保存に関与しない
ログの集約、処理、保存はアプリではなく、クラウド上のサービスを使用する
ELKスタック（ElasticSearch、Logstash、およびKibana）、Splunk、Sumologic、またはその他の様々なツールを使用して、分析することができる
スケーラビリティメリットが得られる
動的にアプリケーションが増えても、ログを処理するドライバがあれば処理できる

## Factor 7. Disposability
破棄容易性
迅速に起動し、迅速に停止できるように作成する
クラウドインスタンスではアプリケーションの寿命は短期間


## Factor 8. Backing Services
バックエンドサービス
コード内でローカルのサービスとサードパーティのサービスを区別していないか

例) コードを変更することなく、ローカルのMySQLDBからAWS RDSなどに切り替えられること

ファイルストレージもバッキングサービスとして扱う。

エンタープライズアプリのようにディスク上のファイルにI/Oしない
アプリケーションとバッキングサービスとの結合は外部設定によって行われる

アプリケーションを再デプロイせずに、バックサービスを切り替えることが可能であるべき
サーキットブレーカー：バッキングサービスが落ちている場合、通信を停止しフォールバックorフォールセーフパスを提供できる

バッキングサービスと疎結合にすることで柔軟な回復性をもたせることができる


## Factor 9. Environment Parity
環境一致
Time

コードcommit後、デプロイされるまでの時間を短くすること
多くの組織では開発者がコードをチェックインしてからリリースまで数週間から数ヶ月かかることがある 時間的なギャップが生じると、人は変更の内容を忘れてしまう。 CDサイクルを回し、時間ギャップを小さくすることで、品質を上げる
People

人がデプロイプロセスに関与してはいけない
適切なビルドパイプラインが存在すれば、アプリケーションは全ての環境に自動的にデプロイされる
Resources

バッキングサービスなどローカルと本番での差異を増やすと、いいことはない。
クラウドネイティブアプリを構築しながら開発ライフサイクルのステップを評価する際には、環境間のギャップ全てに注意を払い、なるべく生じないようにする

## Factor 10. Administrative Processes
管理プロセス
管理プロセスはアプリケーションから分離する

アドホックな機能を呼び出すために使用できるRESTfulエンドポイントを公開すること
メインアプリからバッチ関連のコードを切り出し別のマイクロサービスにする
トリガーはアプリケーション外におく
管理、メンテナンスタスクを利用する場合、マネージドサービスが提供している機能で実現してないか検討する

好きな言語でプログラミングして実現しようとすることは避ける
AWS Lambdaはいい選択

## Factor 11. Port Binding
ポートバインディング
サービスをコンテナ化して公開する
1つのコンテナ内で複数のアプリケーションを起動しないこと
公開するエンドポイントは、コードを変更せずに外部から設定できるようにすること

## Factor 12. Stateless Processes
ステートレスプロセス
アプリケーションを1つのステートレスなプロセスとして実行しているか

スティッキーセッション(アプリケーションプロセスのメモリにセッション情報を持たせる)は使用しないこと。
セッション状態のデータは、有効期限を持つデータストア(MemcachedやRedis)に格納し、バッキングサービスを通じて利用する
プロセスの起動時に頻繁に使用されるデータをキャッシュするパターンは、破棄容易性の原則に違反する為

## Factor 13. Concurrency
並行性
垂直スケーリングでなく、水平スケーリングを行う
破棄容易性とステートレスプロセスの原則を満たしている場合、水平スケーリングを最大限に活用する

## Factor 14. Telemetry
監視、計測
アプリケーションパフォーマンスモニタリング
アプリケーションが処理している1秒あたりのHTTPリクエストの平均数など
ビジネスに意味のある予測、分析をする為にイベントとデータを収集する
例えば過去20分以内にiPadでユーザーに販売したウィジェットの数など
アプリケーションが正常動作しているかを監視する
アプリケーションの起動、シャットダウン、スケーリング、Webリクエストの追跡、定期的なヘルスチェックの結果など
監視戦略を計画するときは、どの程度の情報を集約するのか、それがどのくらいの割合で蓄積されるのか、そしてどれだけの量を保存するのかを考慮する

## Factor 15. Authentication an Authorization
認証／認可
クラウドネイティブアプリケーション全てがRBAC（Role Based Access Control ロールベースのアクセス制御）でエンドポイントを保護するのが理想
アプリケーションのリソースに対するすべてのリクエストは、誰がリクエストを行っているのか、およびそのコンシューマが属するロールを知っている必要があり、そのロールに応じて操作を実行する許可を与えるかどうかを決定する
