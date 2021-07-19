

Azure サービス プリンシパル
	Azure サービス プリンシパルは、アプリまたはサービスを表すプロキシ アカウント (ID) と考えることができます。 このアカウントは、Azure Active Directory (Azure AD) によって管理されています。 必要な Azure リソースへのアクセス権をサービス プリンシパルに付与します。 資格情報を埋め込んだり、アプリのダミー アカウントを作成したりする代わりに、サービス プリンシパルを使用します。
	サービス プリンシパルは、Azure のテナント レベルに存在します。 これらは、そのテナント内のリソースへのアクセスを許可するために使用されます。
	Azure portal で、アプリを表す Azure AD アプリケーションを作成します。 次に、このアプリケーション オブジェクトをサービス プリンシパルに関連付けます。

Azure マネージド ID
	Azure マネージド ID は、無料で使用できる Azure Active Directory (Azure AD) の機能です。
	この機能により、アプリが Azure のリソースとサービスで認証されるようにするための ID が自動的に作成されます。

	マネージド ID を使用して、この機能をサポートする任意の Azure サービスを認証します。 マネージド ID を使用するために、コードで認証資格情報を提供する必要はありません。
	マネージド ID は、Azure AD 認証と Azure のロールベースのアクセス制御 (RBAC) を組み合わせたものです。


	マネージド サービス ID" (MSI) という用語 = "Azure リソースではマネージド ID"

    クライアント ID:Azure AD アプリケーションと、ID をプロビジョニングしたときに作成されたサービス プリンシパルにリンクされている一意の ID。
    オブジェクト ID:マネージド ID のサービス プリンシパル オブジェクト。
    Azure Instance Metadata Service:Azure Resource Manager で VM がプロビジョニングされるときに有効にされる REST API。 エンドポイントには、VM 内からのみアクセスできます。

	2 種類:
		システム割り当て ID と ユーザー割り当てマネージド ID
