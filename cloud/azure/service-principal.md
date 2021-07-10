

# 演習 - Azure VM にシステム割り当てマネージド ID を構成する

REF: https://docs.microsoft.com/ja-jp/learn/modules/authenticate-apps-with-managed-identities/5-exercise-configure-managed-identity-for-vm

環境を設定する

1. 会社の非公開データを格納するために Azure Key Vault のインスタンスを作成します。
	すべての Azure Key Vault 名はグローバルに一意である必要があります。
```Azure CLI
export VMNAME=prodserver
export KVNAME=furniture-secrets$RANDOM

az keyvault create --name $KVNAME \
	--resource-group learn-0fd35617-65fb-4d3b-b39c-d0ff870cd8ed \
	--default-action Allow \
	--location $(az resource list --output tsv --query [0].location) \
	--sku standard
```

2. 会社のアプリをホストする VM を作成します。 環境変数にパブリック IP アドレスを格納します。
```Azure CLI
	export publicIP=$(az vm create \
		--name $VMNAME \
		--resource-group learn-0fd35617-65fb-4d3b-b39c-d0ff870cd8ed \
		--image UbuntuLTS \
		--generate-ssh-keys \
		--output tsv \
		--query "publicIpAddress")
```

注意: VM の作成には数分かかることがあります。

Azure VM にシステム割り当てマネージド ID を構成する

1. システム割り当てマネージド ID を VM に割り当てます。

```Azure CLI

az vm identity assign \
  --name $VMNAME \
  --resource-group learn-0fd35617-65fb-4d3b-b39c-d0ff870cd8ed
```

このコマンドは、マネージド ID を示す応答を返します。 応答の例を次に示します。
```JSON
	{
		"systemAssignedIdentity": "a78ddd60-183b-4e27-9f0d-c11a11c417d8",
		"userAssignedIdentities": {}
	}
```

キーコンテナーを使用してシークレットを格納する

	キー コンテナーに接続文字列を追加します。

```Azure CLI
az keyvault secret set \
  --vault-name $KVNAME \
  --name DBCredentials \
  --value "Server=tcp:prodserverSQL.database.windows.net,1433;Database=myDataBase;User ID=mylogin@myserver;Password=examplePassword;Trusted_Connection=False;Encrypt=True;"
```

キー コンテナー名をメモしておきます。
```Bash
	echo $KVNAME
```

会社の在庫追跡アプリ用に VM を設定する

	SSH を使用して VM にアクセスします。
```Bash
ssh $publicIP
```

プロンプトで「yes」と入力します。

次の演習のために、VM に .NET Core をインストールします。

```Bash
wget -q https://packages.microsoft.com/config/ubuntu/18.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
sudo dpkg -i packages-microsoft-prod.deb
sudo add-apt-repository universe
sudo apt-get update
sudo apt-get install apt-transport-https
sudo apt-get update
sudo apt-get install dotnet-sdk-3.1
```

このモジュールのサンプル アプリのソース コードをダウンロードします。
```Bash
git clone https://github.com/MicrosoftDocs/mslearn-authenticate-apps-with-managed-identities identity
```

SSH セッションを終了します。
```Bash
	exit
```


# Azure AD マネージド ID を使用してアプリケーションをビルドする


ユーザー割り当て ID の作成と管理

ユーザー割り当て ID は、Azure portal で、またはコマンド ラインから作成できます。 次の例では、Azure CLI を使用しています。

```Azure CLI
az identity create \
  --name <identity name>
  --resource-group <resource group>
```

次のコマンドを使用して、システム割り当て ID を含む ID のリストを表示します。 自分の ID のプリンシパル ID をメモします。 Azure では、この ID を使用して、権限の割り当てと認証が行われます。

```Azure CLI
az identity list \
  --resource-group <resource group>
```

ID を作成すると、プリンシパル ID を使用して ID をリソースに関連付けることができます。

Azure 関数アプリで ID を使用するには、次のコマンドを使用します。

```Azure CLI
az functionapp identity assign \
  --name <function app name> \
  --resource-group <resource group> \
  --role <principal id>
```

関数アプリでは、実行にこの ID が使用されます。 ID で使用可能なリソースにアクセスできます。

必要なコマンドは、リソースによって異なります。 たとえば、Azure Key Vault からキーを読み取り、一覧表示する機能を ID に付与するには、次のコマンドを使用します。

```Azure CLI
az keyvault set-policy \
	--name <key vault name> \
	--object-id <principal id> \
	--secret-permissions get list
```

ユーザー割り当て ID を削除するには、次のコマンドを実行します。

```Azure CLI
az identity delete \
  --name <identity name>
  --resource-group <resource group>
```

Azure Key Vault でのマネージド ID の使用

以下に示す DefaultAzureCredential プロバイダーを使用すると、運用環境でマネージド ID を使用して認証できます。
また、開発中はローカル開発者の資格情報を利用することもできます。 これを使用するには、次のように、Azure.Identity パッケージをインストールする必要があります。

```PowerShell
dotnet install Azure.Identity
```

DefaultAzureCredential を使用して、認証済みの SecretClient を作成できるようになりました

```C#
var client = new SecretClient(new Uri(keyVaultUrl), new DefaultAzureCredential());
```

クライアントを作成した後は、名前付きのシークレットを取得します。

```C#
KeyVaultSecret secretWithValue = await client.GetSecretAsync(secret.Name).ConfigureAwait(false);
```


# 演習 - マネージド ID を使用して .NET でカスタム アプリケーションを構成する

Key Vault からシークレット情報をフェッチするアプリを作成する

	先ほど作成した VM にサインインします。

```Bash
ssh $publicIP
```

注意: 環境変数 publicIP が設定されていない場合は、次のコマンドを使用してリセットします。

```Azure CLI
export publicIP=$(az vm show \
	--name prodserver \
	--resource-group learn-0fd35617-65fb-4d3b-b39c-d0ff870cd8ed \
	--show-details \
	--query [publicIps] \
	--output tsv)
```

そして、ssh $publicIP コマンドを再度実行します。

identity/secretapp フォルダーに移動します。

```Bash
cd ~/identity/secretapp
```

nano エディターを使って、Program.cs ファイルを開きます。

```Bash
nano Program.cs
```

このファイルには、サンプル アプリの C# ソース コードが含まれています。

Main メソッドを調べます。

```C#
static async Task Main(string[] args)
{
	await GetSecretFromKeyVault().ConfigureAwait(false);
}
```

このメソッドは、GetSecretFromKeyVault メソッドを呼び出すだけのアプリケーションのエントリ ポイントです。

GetSecretFromKeyVault メソッドまで下に移動します。 メソッドの最初のコード ブロックを調べます。

```C#
private static async Task GetSecretFromKeyVault()
{
	var keyVaultName = "<key vault name>";
	Uri keyVaultUri = new Uri($"https://{keyVaultName}.vault.azure.net");

	SecretClient secretClient = new SecretClient(keyVaultUri, new DefaultAzureCredential());
	...
}
```

"<key vault name>" を自分のキー コンテナーの名前("furniture-secrets20376")に置き換えます。 このコードでは、DefaultAzureCredential を使用して、要求を行うクライアントを認証します。
このコードはバックグラウンドで、コードを実行する VM のシステム マネージド ID を取得します。 次に、この認証スキームを使用する SecretClient のインスタンスを生成します。
この SecretClient インスタンスを使用して、キー コンテナーのシークレットにアクセスできます。

コードの次の部分を見てください。

```C#
	var keyVaultSecretName = "<secret name>";

	try
	{
		var secret = await secretClient.GetSecretAsync(keyVaultSecretName).ConfigureAwait(false);

		Console.WriteLine($"Secret: {secret.Value}");
	}
	catch (Exception exp)
	{
		Console.WriteLine($"Something went wrong: {exp.Message}");
	}
```

	<secret name> を "DBCredentials" に置き換えます。これは、キー コンテナーで作成したシークレットの名前です。

	このコード ブロックは、SecretClient の GetSecretAsync メソッドを呼び出して、特定のシークレットを取得し、その値を表示します。 キーにアクセスするためのアクセス許可がクライアントにない場合、このコードは例外をスローし、エラー メッセージを表示します。

	注意: パスワード、証明書、またはクライアント シークレットは、コードに格納されません。

	変更を保存するには、CTRL+O キーを押してから Enter キーを押します。

	nano エディターを閉じるには、CTRL+X キーを押します。

アプリケーションをテストする

	次のコマンドを実行して、アプリケーションをビルドします。

```Bash
dotnet restore
dotnet build
```

プログラムを正しく編集した場合は、エラーが発生せずにアプリがビルドされるはずです。

アプリケーションを実行します。
```Bash
	dotnet run
```

	キー コンテナーにアクセスするための VM のサービス プリンシパルをまだ承認していません。 そのため、アプリケーションは、次のエラー メッセージを表示して応答するはずです。

	Something went wrong: Operation returned an invalid status code 'Forbidden'

サービス プリンシパルが Key Vault からシークレットを取得できるようにするためにアクセス許可を付与する

	VM への接続を閉じます。

```Bash
exit
```

前の演習で、ご自分の VM のプリンシパル ID をメモしました。 プリンシパル ID を覚えていない場合は、次のコマンドを実行して、VM のシステム割り当て ID を検索します。 <vm name> をご自分の VM の名前に置き換えます。

```Azure CLI
az vm identity show \
  --name <vm name> \
  --resource-group learn-0fd35617-65fb-4d3b-b39c-d0ff870cd8ed
```

次のコードは、戻り値の例です。 ご自分の ID とは異なります。

```JSON
{
	"principalId": "aba6da53-9180-47fc-8fc4-4b35f154e845",
	"tenantId": "a95baa51-dcb1-4b9a-8312-8774a8afddbe",
	"type": "SystemAssigned",
	"userAssignedIdentities": null
}
```

この値を使用して、次のコマンドでプリンシパル ID のみを返します。

キー コンテナー内のシークレットを取得して一覧表示するには、このプリンシパル ID を使用して VM を承認します。
```Azure CLI
	az keyvault set-policy \
		--name $KVNAME \
		--secret-permissions get list \
		--object-id $(az vm identity show \
						--name prodserver \
						--resource-group learn-0fd35617-65fb-4d3b-b39c-d0ff870cd8ed \
						--output tsv \
						--query principalId)
```
	戻り値は JSON 形式になります。 これには、ID、場所、名前、および関連付けられているすべてのプロパティが含まれます。

再度アプリケーションをテストする

VM にサインインします。

```Bash
ssh $publicIP
```

identity/secretapp フォルダーに移動します。

```Bash
cd ~/identity/secretapp
```

アプリケーションを実行します。
```Bash
	dotnet run
```

	今回は、アプリケーションが Key Vault からシークレットを取得し、その値を表示できているはずです。

	Database connection string:: Server=tcp:prodserverSQL.database.windows.net,1433;Database=myDataBase;User ID=mylogin@myserver;Password=examplePassword;Trusted_Connection=False;Encrypt=True;


まとめ、
つまり、アプリの中で、"<key vault name>"と"<secret name>"だけで、Key Vault からシークレットを取得できるぞとのことだね。Key Vaultの典型的な一例。
こんなユースケースが、「マネージド ID を使用して .NET でカスタム アプリケーションを構成する」ことで実現できる。





# Configure and manage secrets in Azure Key Vault

NEXT
REF: https://docs.microsoft.com/en-us/learn/modules/configure-and-manage-azure-key-vault/
