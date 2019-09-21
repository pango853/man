


# Manual Update for ASUS ZenFone 4 Max X00HD (ZC520KL)

Before:
JP_ZC520KL_14.2016.1807.375_20180730

Download
https://www.asus.com/jp/support/Download-Center/
Version: WW_ZC520KL_15.2016.1907.519 (Android 8.1.0 Oreo)

Go to Device Manager and install USB driver


https://www.getdroidtips.com/ww-14-2016-1805-374-fota-zenfone-4-max/

Reboot your phone to recovery by pressing Volume UP + Power button.
Now connect the PC to Mobile with USB Cable.
Now enter the following command in the command window that you open

adb devices

This command will show if any device is connected properly. If it doesn’t show, then please check the drivers are installed properly or if the attached cable is damaged.
If your device is listed, then please type the below command in your command window.

adb sideload ZC520KL_P_downgrade_to_O.zip.zip

Wait until installation process completes.
Once the installation process is completed and You can Reboot your ZenFone 4 Max.
That’s it, fellas! Done. you have upgraded the Asus ZenFone 4 Max.






You can also go to ASUS official website to download newer firmware and instruction manual.
Note:
    Please make sure the firmware SKU you download is conformed to what on your phone, eg., WW -> WW, CN -> CN, TW -> TW. Incorrect SKU will lead to update failure.
    You can not change the SKU from one to another, eg., WW -> TW, and also can not downgrade your firmware, eg., V2.20.40.13 -> V2.19.40.18.
    During update process, please charge your phone with AC adaptor or make sure the phone has at least 15% battery life.

1. Go to "Need Help?" page of ASUS official website http://www.asus.com/support to download ZIP file of firmware.
    Note: Double click the ZIP file after downloading is completed. If the content is another intact ZIP file (as shown in red on picture below),
              please upzip the file again.
             If the content is not an intact ZIP file (as shown in yellow), you do not have to do anything.
             Close the ZIP file after check.



https://www.asus.com/my/Phone/ZenFone-4-Max-ZC520KL/HelpDesk_BIOS/
Version: WW_ZC520KL_15.2016.1907.519


https://open.mixi.jp/user/5615214/diary/1965269339

手順の概略
PCにminimal adb and fastbootをインストール。
PCとスマホを接続。
アプリのバックアップを取る。
スマホのブートローダーロックを外す。
カスタムリカバリーのTWRP Recoveryを使って、JP版リカバリーをrecovery_stock.img　に変更する。
差し替えられたリカバリーから、WW版ファームウェアを焼く。
バックアップしたアプリを復元する。 



準備するもの
パソコン(windowsを使いましたが、他のOSでもやり方はあるはず）
PCのインターネット環境とスマホのWifi環境。スマホは再インストール状態になるので、多くのダウンロードが発生します。
パソコンとスマホ間のデータ通信ができるUSBケーブル
スマホにSDカードを入れておく。できるだけ高速なもので、32GB以上の容量がおすすめ
自己責任の覚悟。ASUSのサポートは受けられなくなると思われます。転んでも泣かない。
代わりのスマホ（ZenFone MAXが長時間使えなくなりますし、手順を誤ると、文鎮化の可能性もありますので）


注意点
○WW版ファームウェアを焼くにあたり、スマホ内部のファイルは、全消去することになります。
パソコンへのバックアップの方法を後述しますが、必ず行ってください。
○再インストール状態になるので、googleや、お使いのSNSのIDやパスワードの確認、
LINEのトークのバックアップや、ゲームアプリのバックアップやら、機種変更の時に行うのと同様に、やっておいてください。
○念のため、スマホ画面のロック設定は、事前に解除しておいてください。
○SDカードの容量の一部をすでに内部ストレージ化している場合、WW版ファームウェアを焼くと、設定が解除されます。
外部ストレージにしていた容量分しか、使えない状態になります。
そのため、ファームウェアの更新後、再度SDカードの内部ストレージ化が必要で、その際SDカードはフォーマットされます。
SDカード内の外部ストレージ部分をパソコンへバックアップする事も、お忘れなく。



手順

①ZenFone MAXとパソコンを接続して、コマンドを受け付けるようにする

ZenFone MAXの設定画面から、ビルド番号を７回タップして、設定画面に開発者向けオプションを表示させます。
開発者向けオプションの項目から、USBデバッグを有効にします。

パソコンの方には、前述のhttps://www.androidinfotech.com/2017/01/root-asus-zenfone-max-zc550kl-marshmallow-install-twrp.html
のサイトの文中のリンクから
minimal_adb_fastboot_v1.3.1.rar
adb-setup-1.4.3.exe
をダウンロードして、それぞれexeファイルを実行して、インストールします。
windowsのOSバージョンによっては、インストールできないかもしれません。
その場合は、この２つのファイルの同名で、バージョンの数字が違うものを探して、インストールしてください。

USBケーブルで、パソコンとZenFone MAXを接続します。
パソコンは、ドライバーをインストールしていますと出るので、しばらく待ちます。
ZenFone MAXの画面で、ファイルを転送する(MTP)を選択します。
接続したPCからのコマンドを受付けるかどうかという感じの確認画面が出たら、許可してください。
パソコンからも、スマホ内のフォルダを開いて確認したりできます。

パソコンで、コマンドプロンプトを開きます。
パソコンの左下か、ロゴマークをクリックして開いた画面にある、検索ボックスに、「cmd」と入力すると、cmd.exeがすぐ出てきますので、それを実行してください。

コマンドプロンプトで、「adb devices」と入力してEnterを押すと
画面にList of devices attachedと出て、下に英数字の羅列が出たら、ZenFone MAXがコマンドを受付ける状態です。
英数字の羅列の後に、devices 以外の英文が出ていたら、スマホの画面で許可待ちになっていないか、確認してください。
List of devices attachedという表示もなく、何このコマンド？みたいな表示が出たら、minimal_adb_fastbootのインストールに失敗しています。
英数字の羅列が表示されない場合は、adb-setupのインストールに失敗しています。
インストールできる別バージョンのものを探したり、minimal adb and fastbootのインストール方法を検索してみてください。





②アプリのバックアップを取る

コマンドプロンプトから、「adb backup -apk -obb -all」と入力して実行。
スマホ画面から、適当なパスワードを入力して、バックアップを選択します。
パスワード未入力では、バックアップできませんでした。

戻るボタンをタップして、文字パッドを消すと、バックアップしているファイル名が表示されていくのが確認できます。
終了すると、スマホの画面は元に戻り、コマンドプロンプトも、次のコマンド待ちの状態になります。

コマンドプロンプトに表示されたカレントディレクトリ（例えばC:\Users\ユーザー名>なら、そのフォルダ内に）
backup.ab ファイルができます。
このファイルは、バックアップする度に上書きされるので、名前を変えたり、保存場所を変えたりしてください。

adb backupコマンドは、オプションに -system をつけるとシステムもバックアップに含まれますが、
バックアップファイルにシステムファイルがあると、WW版にしてから戻す時に、エラーで止まる場合があるので、省いています。
システムファイルは、後述④で別途バックアップします。
オプションに -shared をつけると、SDカード内のファイルもバックアップに含まれますが、
バックアップに長時間かかるのと、こちらも後述④で別途バックアップします。


③上記のASUSのホームページhttps://www.asus.com/jp/Phone/ZenFone-Max-ZC550KL/HelpDesk_Download/
ZenFone MAXからアクセスして
ユーティリティのバージョン 8916_UnlockTool （2016/10/13）をダウンロード。バージョン8939と間違えないように注意。
ファームウェアの最終バージョン WW 8916-13.8.26.92 （2017/05/26）
バージョン WW_V13.8.26.36 （2016/07/10）
以上、合計３つをダウンロード。保存先を外部ストレージにします。
○内部ストレージに保存した場合は、外部ストレージに移動してください。

ファームウェアは最終バージョンだけでもOKかもしれませんが、未検証です。

ダウンロードした、8916_UnlockToolは、apkファイルなので、ファイルマネージャーなどで、選択して実行します。
これで、ブートローダーの書き換えが可能になるため、ASUSのサポートが切られるものと思われます。

ファームウェアは、zipファイルですが、焼く時はzipファイルのまま進みますので、解凍せずそのまま保存しておきます。


④TWRP Recoveryを使って、システムのバックアップをとる

https://yadi.sk/d/6X69XdgCqS652　にパソコンからアクセスして、
Z010D_3.1.1.t1.img
recovery_stock.img
の２つをダウンロードして、パソコンの適当な場所に保存します。

Z010D_3.1.1.t1.imgは、カスタムリカバリーのTWRP Recoveryですが、パソコンから一時起動するために使います。

recovery_stock.imgは、WW版を焼く時に拒否されないために、JP版のリカバリーから変更するのに使います。
そのため、ZenFone MAXの外部ストレージ（SDカード）内をパソコンから開いて、そこにコピーします。
○間違っても内部ストレージに保存してはいけません。

コマンドプロンプトから「adb reboot bootloader」と入力して実行します。
ZenFone MAXの画面が、ブートローダー画面に変わります。

「fastboot boot」と入力して、スペースを１つ空けたら、
先ほど保存した、Z010D_3.1.1.t1.imgをコマンドプロンプト画面に、ドラッグ＆ドロップします。
fastboot boot C:\***\***\Z010D_3.1.1.t1.img みたいに、ファイルの保存先までのフルパスが入力されます。便利ですね。
そして、実行すると、またまたZenFone MAXの画面が変わり、Team Win Recovery Project と書かれた画面になります。
略してTWRP リカバリーをパソコンから一時的に起動させた状態です。

TWRPにはいろいろな機能がありますし、検索してもらうと、画像つきの解説がいくつも見つかります。

ここから、Backupを選び、Select Storageから、バックアップの保存先をMicroSDにします。
バックアップを取る項目は、System,Recovery,Boot,ASDF,Factory にチェックを入れます。
Data,Cacheはバックアップ項目から除外します。②でパソコンにバックアップ済みですし、容量が大きくSDカードを圧迫してしまうので。

画面一番下のSwipe to Backupで、システムのバックアップが始まります。

終わったら画面左上の矢印ロゴをタップすると、トップ画面に戻ります。

Restoreで、先ほどのバックアップを戻せますので、後でJP版に戻したくなった時や、途中で失敗した時に使います。

次に、外部ストレージ（SDカード）のファイルをバックアップします。
これは、パソコンから外部ストレージを開いて、中のファイルを全選択して、パソコンにコピーします。
内部ストレージもsdcard というフォルダ名になっていたり、紛らわしいので、ファイルの中身で確認してください。
TWRPで起動中は、内部ストレージの中身はほとんど空の状態に見えますので、すぐわかるはずです。

外部ストレージのファイルを全コピーしていると、途中でエラーが出て、コピーが止まるかもしれません。
その場合は、止まった所のファイルはコピーを断念して、その下から最後までコピーしてください。

ようやく下準備は完了です。ここからWW版を焼くのはすぐ終わりますよ。

⑤TWRP Recoveryを使って、recovery_stock.imgを焼く

TWRPのトップ画面から、Installを選択。画面下のSelect StorageからMicroSDを選択。Install Imageをタップ。
保存ファイルのリストから、recovery_stock.imgを選択し、Recoveryを選択し、下のSwipe to confirm Flashをスワイプします。
○間違ってもBootを選択してはいけません。文鎮化しますよ！

トップ画面に戻って、Wipeを選択します。
○ここの操作で、JP版のOSも、内部ストレージに保存されたファイルも全消去されますよ。
面倒がらずに、バックアップとりましたか?WW版ファームウェアをSDカードに保存しましたか?

Advanced Wipeをタップし、System,Data,Cache にチェックを入れ、Swipe to Wipe をスワイプします。ドキドキしますね。

⑥リカバリーモードで、ZenFone MAXを起動して、WW版ファームウェアを焼く

USBケーブルは外しておいていいですが、電池が少ないようなら、充電してから進んでください。
TWRP RecoveryをRebootで再起動します。OSがないけどいいの？みたいなこと聞かれますが、再起動するしかありません。
でも、そのまま再起動では、OSを削除したので起動できません。
一度電源を切り、ここでは、リカバリーモードで再起動します。
やり方は、電源ボタンと音量－のボタンを同時押しからの、スマホがブルっと振動したら、電源ボタンだけ離します。
音量－ボタンは押したままですよ。

これでリカバリーモードで起動します。
画面の上に、LRX22G.WW.Phone-12.8.10.56-20160218 rel　と、ZenFone MAXと違う機種名が出ていますが、そこは気にせず
SDカードからシステムアップデートを選択して
UL-ASUS_Z010-WW-13.8.26.36-user.zip　をタップします。

これでWW版ファームウェアのV13.8.26.36がインストールされます。
少し時間はかかりますが、起動後に、最初に言語を選ぶ画面になります。一番下までスクロールしていくと、日本語があります。

Wifiの設定とgoogleのID,パスワードの入力をすると、あれこれダウンロードがはじまります。

添付画像は、最終バージョンの適用後ですが、ビルド番号が、WW_Phoneになっているか、確認してみてください。
最終バージョン WW 8916-13.8.26.92もSDカードに入っているので、しばらくすると、バージョンアップ通知が出ます。

⑦SDカードの半分を内部ストレージ化する（必要ない場合は飛ばして⑧に進んでください）
これをした場合、新しくインストールしたアプリは、この内部ストレージ化したSDカードに入ります。
アプリによっては、開かない場合がありますので、そのときは設定画面のアプリから、開かなかったアプリを選択して
ストレージをタップして、外部ストレージから内部ストレージに変更してください。
ここで外部ストレージと表示されているのは、内部ストレージ化したSDカードのことで、外部ストレージになっているSDカードじゃありません。
ややこしいですね。

また開発者向けオプションの項目から、USBデバッグを有効にします。
USBケーブルでパソコンと接続します。
コマンドプロンプトから、
「adb shell」
「sm list-disks」
の２つを実行すると
disk:（SDカード固有の数字）が表示されます。
「sm partition disk:（SDカード固有の数字） mixed 50」
を実行すると、SDカードがフォーマットされ、SDカードの50%を外部ストレージで残すというコマンドが実行されます。

スマホの設定画面のストレージとUSB　で、内部ストレージの下に50％の容量のSDカードが表示され、
一番下に外部ストレージにした50％の容量のSDカードが表示されます。
内部ストレージ化したSDカードのほうを、１回タップします。
右上の３点ボタンから、データの移動をタップします。
開かないアプリは、上記のように、内部ストレージに戻します。
④でPCに保存した外部ストレージのファイルをPCからスマホのフォルダを開いて、戻します。

⑧バックアップしたアプリをリストアする
　②でパソコンにバックアップしたアプリをリストアします。
USBケーブルでパソコンと接続した状態で、
コマンドプロンプトに「adb restore」と入力し、スペースを１つ空けたら、②で保存したbackup.ab（名前は変えていてもOK）をドラッグ＆ドロップして、実行します。

ZenFone MAXが復元画面になるので、②で決めたパスワードを入力して、復元します。
これで、バックアップした時のアプリがインストールされた状態になります。

ただし、アプリを開いた時に、はじめての端末と判断されますので、ログインを求められたりします。
けっこう面倒ですが、仕方がありません。

○WW版になっても、root化端末ではないので、すべてのアプリが問題なく使えます。

以上になります。お疲れ様でした！






⑨おまけ　root化について
ブートローダーのロックを外したので、TWRPを使ってカスタムROMを焼くこともできます。
XDAというサイトでは、このZenFone MAX用のカスタムROMも数多く公開されています。

しかし、日本ではroot化端末を使うことは、犯罪者的な扱いを受けます。
知識あるいは情報があれば、アプリの中身を改変できてしまったりしますので、
僕のように１万足らず（今はもっと安い）で手に入れたスマホでも快適に使いたいという目的だったとしても、
さまざまなアプリが、root化端末では使えないようにする対策をしています。
個別のアプリの改変使用を検出する労力より、root化端末はすべて使用不可にしたほうが楽なんでしょう。
高価な高性能端末を買ってもらえなくなるし、google製アプリもメーカー製アプリも使ってもらえないという意味でも、邪魔な存在ではあるでしょうね。
カスタムROMの開発者側からすれば、オープンソースなはずのAndroid OSをなぜgoogleが
Google Mobile Services (GMS)でコントロールしているのかと、怒りめいたものも感じるわけですが。

カスタムROMを使う上で、root権限を管理するアプリとして、SuperSUを薦めているサイトが多いですが、
上記の事情で、Magiskというアプリを使わざるをえず、対策側といたちごっこになっている状態です。
興味があれば、検索して調べてみてください。
カスタムROMを焼く場合は、open gapps というサイトから、最小限のgoogleアプリ（playストアなど)のダウンロードも必要です。

カスタムROMは対象の端末をいかに使いやすくするかの工夫や、個性が随所に見られ、おもしろい世界ではありますが、
上記のようにやっかいな状況をはらんでいるため、十分に検討のうえ、ご使用を判断くださいませ。




adb: sideload connection failed: closed
adb: trying pre-KitKat sideload method...
adb: pre-KitKat sideload connection failed: closed

adb devices

fastboot oem unlock

