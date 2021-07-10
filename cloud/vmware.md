

# vSphere HA


HAを有効にするための要件

vSphereHAを有効にする前に確認事項があるので羅列していく。
必須事項

	Essentials Plusから？ (Free Hypervisor < Essentials < Essentials Plus < Standard < Enterprise)
    最低ESXiは2つ以上用意すること
    ESXi1台につき最低メモリは5GB
    VMware vCenter Serverを使用していること
    VM用の共有ストレージがあること
    pingが通るゲートウェイや、信頼できる宛先があること

推奨事項

    冗長化されたマネジメント用ネットワークがESXiに接続されていること
    ESXi1台につき8GB以上のメモリ
    複数の共有データストアがあること

続いてファイヤーウォールに関する要件も挙げる。
FW要件

vSphereHAを有効する環境にファイヤーウォールが含まれている場合は、HA機能を正常に使用するために下記のポートを空けておく必要がある。
Port 	Protocol 	Direction
8182 	UDP 	Inbound
8182 	TCP 	Inbound
8182 	UDP 	Outbound
8182 	TCP 	Outbound

HAを構成する要素

 HAを構成しているコンポーネントは、「FDM」、「HOSTD」、「vCenter」の3つである。これらの3つが連携し合うことでHA機能が成り立っている。

## 特徴

    仮想マシンの停止に対し、仮想マシンを再起動することでダウンタイムを短縮化する
    メリットは、管理者が不在な状況に置いてもvSphere HAは仮想マシンの再起動を行ってくれる
    仮想マシン内で発生したブルースクリーンやアプリケーションの停止などに対しても監視を行う
    保護出来る仮想マシンのサイズには、機能性質上制限は無い

vSphere HAの特徴

    物理サーバーで障害があった時に、自動的に別の物理サーバーで稼働させる機能
    →非計画的な障害に対して、可用性を確保する機能
    障害が発生し、別の物理サーバーで起動するまでに数分時間がかかる（＝数分サービスが停止）
    物理マシンに障害が発生した際に、クラスタ内の別ホスト（別の物理マシン）に仮想マシンが移動します（※再起動発生）！（安全地帯へ避難）
    設定対象：クラスタ単位 (<-- ここがVMotion, FTとの違い)
    ダウンタイム：数分

## Example
	1. vmkernel 01 goes down
	2. VM on vmkernel 01 goes down
	3. vmkernel 02 try to reboot VM using VM data on VMFS
	4. VM comes back

HAは構成に必要なものは次の通りです。

    vCenter Serverは必要
    ESXiホスト(2～64台)
    ESXiのライセンスはEssentials Plus以上
    HAクラスターノード間での通信用のvmkernel portが最低1つ(各ホストごとに)
    共有データストア(仮想マシン保存領域、HAクラスターノードからアクセスが可能であること)

ポイント: vSphere HAは仮想マシンの動作に対し問題が発生した場合、仮想マシンの再起動によってそれを迅速にリカバリする機能である、ということ

# Tutorial

VMware HA のカスタマイズを適用する - vSphere 5.x, 6.x および 7.0.x

vSphere Web Client の使用

    VMware vSphere Web Client にログインします。
    [ホーム] > [vCenter] > [クラスタ] に移動します。
    [オブジェクト] で、変更するクラスタをクリックします。
    [管理] をクリックします。
    [vSphere HA] をクリックします。
    [編集] をクリックします。
    [詳細オプション] をクリックします。
    [追加] をクリックし、[オプション] と [値] のフィールドに適宜入力します（下記参照）。
    [vSphere HA をオンにする] を選択解除します。
    [OK] をクリックします。
    HA が構成解除されるのを待ってから、[編集] をクリックし、[vSphere HA をオンにする] チェック ボックスを選択します。
    [OK] をクリックし、クラスタが再構成されるのを待ちます。

vSphere Client の使用

    vCenter Server に vSphere Client で、管理者としてログインします。
    [インベントリ] でクラスタを右クリックし、[設定の編集] をクリックします。
    [VMware HA] をクリックします。
    [詳細オプション] をクリックします。
    [オプション] と [値] のフィールドに適宜入力します（下記参照）。
    [OK] をクリックします。
    もう一度 [OK] をクリックします。
    クラスタの再構成のタスクが完了するのを待ってから、[インベントリ] のクラスタをもう一度右クリックします。
    [プロパティ] をクリックします。
    VMware HA を無効化し、クラスタの再構成のタスクが完了するのを待ちます。
    クラスタを右クリックし、[vSphere HA の有効化] を選択して、設定を有効化します。

個々の仮想マシンのカスタマイズ


手順
    vSphere Clientで、vSphere HA クラスタに移動して参照します。
    [設定] タブをクリックします。
    [構成] の下で、[仮想マシンのオーバーライド] を選択して、[追加] をクリックします。
    [+] ボタンを使用して、オーバーライドを適用する仮想マシンを選択します。
    [OK] をクリックします。
    （オプション） [自動化レベル]、[仮想マシン再起動の優先順位]、[ホスト隔離への対応]、VMCP 設定、[仮想マシンの監視]、または [仮想マシン監視の感度] などの設定を変更できます。
    注： まず [関連するクラスタ設定] を展開してから [vSphere HA] を展開することで、これらの設定についてクラスタのデフォルトを表示できます。
    [OK] をクリックします。


トラブルシューティング
	VMware HAを組む全ESXiホストに対して同様に確認
	- ESXi > ネットワーク > vmk(VM Kernel)の設定画面を開き、「vMotion」を有効にしたvmk(VM Kernel)同士が互いに疎通可能になるようにします。
	- ESXi > 共有データストアがマウントされていることを確認
	vCenterの管理画面を開き、
	- 「vSphere DRS」「vSphere HA」を有効にした状態か。　クラスタを選択し、「設定」でvSphereの可用性で確認vSphere HAがオンになっているかを確認
	- クラスタの下のホストで、データストアを確認
	- ホスト障害(rebootで再現可能)で試せる

	- Check if it is Host Monitoring or VM Monitoring (and Application Monitoring)
	- Check Adminission Control Policy
	- Would it be protected list problem? -> Datastore/.vSphere-HA/FDM-XXXXXX-XXXX-XXXX-XXXX/protectedlist file
	- Won't be vCenter issue, since vCenter is only used to configure.
	- ESXi ホストのトラブルシューティング用のログの収集
		ESXi Shell で、または SSH を介して、vm-support コマンドを入力します。
		/var/tmp/ ディレクトリに移動します。
		.tgz ファイルからログ ファイルを取得します。
		/var/log/fdm.log
		/var/run/log/fdm/*
		/var/log/fdm-installer.log
		/var/log/vmware/fdm/fdmDump.log   can check at https://hostname/mobfdm

	TODO: https://www.youtube.com/watch?v=IAOxfRVWGE0


vSphere 標準スイッチに VMkernel ネットワーク アダプタを作成してホストにネットワーク接続を提供し、
vMotion用のVMKernelポートを設定します。
1. vmotion用VMKernelアダプタ/ポート用のNICを作成します。



VMotion、DRS、そしてVMware HA, and FT?
What is the diff btw DRS and RT?


