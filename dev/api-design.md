
API Driven Development
	サーバとフロントを分けて開発
		スマホアプリの開発など、応用の幅が広い

# Tools
API設計ツールとしては、
- Swagger			Swaggerがほぼデファクトスタンダード
- API Blueprint
- Raml

# Design

- APIドキュメント設計
- API構築フレームワーク
  - APIモック

# Swagger
- Swagger Spec			for documentation
- Swagger Editor		for editing Swagger Spec doc
- Swagger UI			for showing Swagger Spec as HTML
- Swagger Codegen		for generating API stub based on Swagger Spec


# Environment
- SwaggerCodegenなどを使って自前でサーバ構築
- Swagger HubというPaasを利用
- AWS API GatewayというPaasを利用

# Tools
https://openapi.tools/

- https://stoplight.io/p/studio/gh/stoplightio/studio
- https://stoplight.io/open-source/prism
- https://dredd.readthedocs.io



# HOW-TO

https://github.com/swagger-api/swagger-editor
https://github.com/swagger-api/swagger-codegen
$ swagger-codegen generate -i http://petstore.swagger.io/v2/swagger.json -l nodejs-server


SwaggerCodegenを使ってAPIモックアプリケーションを自動生成する
1. swagger.yamlを作成する
2. swagger-codegenをlocalにダウンロード
```
$ git clone https://Github.com/swagger-api/swagger-codegen
$ cd swagger-codegen
$ ./run-in-docker.sh mvn package
```
3. コマンドでモックサーバーアプリケーションを生成する
```
$ cd swagger-codegen
$ java -jar modules/swagger-codegen-cli/target/swagger-codegen-cli.jar generate -i /path/to/swagger.yaml -l nodejs-server -o samples/server/test/nodejs
```
4. 生成したサーバーを立ち上げる
```
$ node ./samples/server/test/nodejs/index.js
=> Your server is listening on port 8080 (http://localhost:8080)
Swagger-ui is available on http://localhost:8080/docs
```
5. /docsと各エントリーポイントを見てみる


