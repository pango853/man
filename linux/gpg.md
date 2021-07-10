

# Tutorial
gpg --gen-key
gpg --list-keys
gpg --list-secret-keys

echo "This is a dummy file - `date`" > test.txt
gpg --output test.gpg --encrypt --recipient user1@example.com test.txt

gpg --output test.decrypt.txt --decrypt test.gpg

echo mypassphrase | gpg --passphrase-fd 0 --output test2.gpg --encrypt --recipient user1@example.com test.txt
echo mypassphrase | gpg --passphrase-fd 0 --output test2.txt --decrypt test2.gpg




TODO: https://sanctum.geek.nz/arabesque/gnu-linux-crypto-gnupg-usage/


  

gpgでのファイルの暗号化基礎CommentsAdd Starblp1526Itisango

備忘録, GnuPG

なかなかSICPに手を付けれずなので、仕事で始めて触ったGPGのコマンドライン上での暗号化復号化についてメモっておこうと思う。

GPGとは、Wikipediaによると


GNU Privacy Guard (GnuPG) とは、Pretty Good Privacy (PGP) の別実装として、GPL に基づいた暗号化ソフトである。 OpenPGP 規格 (RFC4880) に完全準拠しているが、古い PGP との互換性は完全ではない。

ということらしい。
認識では、公開鍵暗号方式でファイルを暗号化するものと思ってる。
通信系にも使われてるのかな？

今回使うバージョンはこんな感じ。

$ gpg --version
gpg (GnuPG) 1.4.11
Copyright (C) 2010 Free Software Foundation, Inc.
License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.

Home: ~/.gnupg
サポートしているアルゴリズム:
公開鍵: RSA, RSA-E, RSA-S, ELG-E, DSA
暗号法: 3DES, CAST5, BLOWFISH, AES, AES192, AES256, TWOFISH, CAMELLIA128, 
           CAMELLIA192, CAMELLIA256
ハッシュ: MD5, SHA1, RIPEMD160, SHA256, SHA384, SHA512, SHA224
圧縮: 無圧縮, ZIP, ZLIB, BZIP2



こうやって見ると、きっと色々なことに使えるんだろうなあ。


今日のメモの流れこんな感じ。
あんまり詳しくはわからないので、
わかり次第、追記か新しく記事を書くことにしたい。
1. 鍵ペアを作成
2. 相手に公開鍵を渡す
3. 相手が公開鍵で暗号化
4. 送られてきた暗号化データを秘密鍵で復号化

ちなみに自分はこれをやるまで、秘密鍵で暗号化して公開鍵で復号化するものだと思ってた...


インストール

MacOSでのインストールはhomebrewを使ってさくっとやりました。
$ brew search gnupg
gnupg	gnupg2
$ sudo brew install gnupg



2台欲しいので、もう一台はUbuntuさんです。
こっちは入れた記憶がないのに最初から入ってた。
$ sudo apt-get install gnupg
パッケージリストを読み込んでいます... 完了
依存関係ツリーを作成しています                
状態情報を読み取っています... 完了
gnupg はすでに最新バージョンです。



1. 鍵ペアを作成

今回はMacで鍵ペアを作って、公開鍵をUbuntuさんに渡します。
では鍵ペアを早速。

鍵ペアは--gen-keyコマンドを使用して作成できます
$ gpg --gen-key
gpg (GnuPG) 1.4.11; Copyright (C) 2010 Free Software Foundation, Inc.
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.

ご希望の鍵の種類を選択してください:
   (1) RSA and RSA (default)
   (2) DSA and Elgamal
   (3) DSA (署名のみ)
   (4) RSA (署名のみ)
選択は? 


今回は2番を選択します。

選択は? 2 
DSA keys may be between 1024 and 3072 bits long.
What keysize do you want? (2048) 


1024で作成します。

DSA keys may be between 1024 and 3072 bits long.
What keysize do you want? (2048) 1024    
要求された鍵長は1024ビット           
鍵の有効期限を指定してください。
         0 = 鍵は無期限
      <n>  = 鍵は n 日間で満了
      <n>w = 鍵は n 週間で満了
      <n>m = 鍵は n か月間で満了
      <n>y = 鍵は n 年間で満了
鍵の有効期間は? (0)


有効期限は取り敢えず無制限で行く。
そんな有効期間で大丈夫か？と聞かれるのでyesと答える

鍵の有効期間は? (0)0
Key does not expire at all 
これで正しいですか? (y/N) y
                                    
あなたの鍵を同定するためにユーザーIDが必要です。
このソフトは本名、コメント、電子メール・アドレスから
次の書式でユーザーIDを構成します:
    "Heinrich Heine (Der Dichter) <heinrichh@duesseldorf.de>"

本名: akihiro_ob
電子メール・アドレス: xxxxxx@gmail.com
コメント: for test                                  
次のユーザーIDを選択しました:
    “akihiro_ob (for test) <xxxxxx@gmail.com>”

名前(N)、コメント(C)、電子メール(E)の変更、またはOK(O)か終了(Q)? 



gpgの人も言ってるが、ここで聞かれる本名が鍵のユーザIDになる。
今後、鍵を削除したりするのに使用することになる。
OKなのでO(大文字のオー)を入力する
名前(N)、コメント(C)、電子メール(E)の変更、またはOK(O)か終了(Q)? O
秘密鍵を保護するためにパスフレーズがいります。                                           

パスフレーズを入力: 


バッチ処理などで使用する場合にはパスフレーズを入れないこともあるみたい。
今回もわかりにくくなるのでパスフレーズは入れないでただエンターを押す。

パスフレーズが不必要なようですが、おそらくそれはろくでもない
考えです! いちおう続行します。パスフレーズは、このプログラム
の“--edit-key”オプションでいつでも変更できます。

今から長い乱数を生成します。キーボードを打つとか、マウスを動かす
とか、ディスクにアクセスするとかの他のことをすると、乱数生成子で
乱雑さの大きないい乱数を生成しやすくなるので、お勧めいたします。
.+++++++++++++++++++++++++++++++++++.++++++++++++++++++++.+++++++++++++++++++++++++.+++++++++++++++++++++++++++++++++++.+++++++++++++++>++++++++++>+++++.............>.+++++....<+++++...............................+++++
今から長い乱数を生成します。キーボードを打つとか、マウスを動かす
とか、ディスクにアクセスするとかの他のことをすると、乱数生成子で
乱雑さの大きないい乱数を生成しやすくなるので、お勧めいたします。
+++++++++++++++.+++++.+++++++++++++++++++++++++++++++++++.++++++++++.+++++..++++++++++++++++++++++++++++++.+++++..++++++++++.+++++++++++++++................>++++++++++^^^
gpg: /Users/akihiro_ob/.gnupg/trustdb.gpg: 信用データベースができました
gpg: 鍵A2A4EF37を絶対的に信用するよう記録しました
公開鍵と秘密鍵を作成し、署名しました。

gpg: 信用データベースの検査
gpg: 最小の「ある程度の信用」3、最小の「全面的信用」1、PGP信用モデル
gpg: 深さ: 0  有効性:   1  署名:   0  信用: 0-, 0q, 0n, 0m, 0f, 1u
pub   1024D/A2A4EF37 2012-01-31
                 指紋 = CAD8 B6FB 2663 6103 8DBA  8A68 6BE5 3BC8 A2A4 EF37
uid                  akihiro_ob (for test) <xxxxxx@gmail.com>
sub   1024g/16B3F987 2012-01-31



ひどい言われようで心挫けそうになったけど、
取り敢えずこれで鍵ペアが完成！

一応確認をしてみる
確認には--list-secret-keys(秘密鍵)や--list-keys(公開鍵)コマンドを使用する
$ gpg --list-secret-keys
/Users/akihiro_ob/.gnupg/secring.gpg
------------------------------------
sec   1024D/A2A4EF37 2012-01-31
uid                  akihiro_ob (for test) <xxxxxx@gmail.com>
ssb   1024g/16B3F987 2012-01-31

$ gpg --list-keys
/Users/akihiro_ob/.gnupg/pubring.gpg
------------------------------------
pub   1024D/A2A4EF37 2012-01-31
uid                  akihiro_ob (for test) <xxxxxx@gmail.com>
sub   1024g/16B3F987 2012-01-31



よしよし、出来てますね。


2. 相手に公開鍵を渡す

相手に鍵を渡すために、まずexportする必要がある。
gpg [-a] [-o 出力ファイル名] --export 鍵ユーザID

$ gpg -o ./o_ob.pub --export akihiro_ob
$ ls o_ob.pub 
o_ob.pub

•aはASCIIでの出力らしく、メールで送ったりする時に使えるらしい。
•oは出力ファイル名の指定だけど、リダイレクションで作成する事もできるっぽい。

その時は-aを付けるのが一般的臭い。
$ gpg -a --export akihiro_ob > o_ob.pub


ちなみに秘密鍵を渡す時は、こんな感じ。
$ gpg -o o_ob.pri --export-secret-key akihiro_ob


オプションは同じだね。

これを相手に送ってやって、インポートする。
$ gpg --import o_ob.pub 
gpg: 鍵A2A4EF37: 公開鍵“akihiro_ob (for test) <akihiro.ob@gmail.com>”を読み込みました
gpg: 処理数の合計: 1
gpg:               読込み: 1



ちなみに秘密鍵をインポートするときも同じようだ。

$ gpg --import o_ob.pri 
gpg: 鍵A2A4EF37: 公開鍵“akihiro_ob (for test) <xxxxxx@gmail.com>”を読み込みました
gpg: 処理数の合計: 1
gpg:               読込み: 1
gpg:       秘密鍵の読出し: 1
gpg:   秘密鍵の読込み: 1


自動で判別してくれてるみたい。
ありがたい！

次に、公開鍵を信用させる
これをしないと、暗号化するときに注意される。
$ gpg --edit-key akihiro_ob
gpg (GnuPG) 1.4.11; Copyright (C) 2010 Free Software Foundation, Inc.
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.


pub  1024D/A2A4EF37  作成: 2012-01-31  満了: 無期限       利用法: SC  
                     信用: 未知の     有効性: 未知の
sub  1024g/16B3F987  作成: 2012-01-31  満了: 無期限       利用法: E   
[ unknown] (1). akihiro_ob (for test) <xxxxxx@gmail.com>

gpg> 


ここで対話形式になるので取り敢えずtrustと入力
その後、信頼度を聞かれるので絶対的に信頼することにする
gpg> trust
他のユーザーの鍵を正しく検証するために、このユーザーの信用度を決めてください
(パスポートを見せてもらったり、他から得た指紋を検査したり、などなど)

  1 = 知らない、または何とも言えない
  2 = 信用し ない
  3 = ある程度信用する
  4 = 完全に信用する
  5 = 絶対的に信用する
  m = メーン・メニューに戻る

あなたの決定は? 5
本当にこの鍵を絶対的に信用しますか? (y/N) y

pub  1024D/A2A4EF37  作成: 2012-01-31  満了: 無期限       利用法: SC  
                     信用: 絶対的     有効性: 未知の
sub  1024g/16B3F987  作成: 2012-01-31  満了: 無期限       利用法: E   
[ unknown] (1). akihiro_ob (for test) <xxxxxx@gmail.com>
プログラムを再起動するまで、表示された鍵の有効性は正しくないかもしれない、
ということを念頭においてください。

gpg> quit


信用の所が絶対的になればOK。
終わればquitで終了してください。

これでいわば設定的なものが完了。


3. 相手が公開鍵で暗号化

次に暗号化をします。

その前にまず暗号化するファイルを作成する
$ echo "gpg test desu: o_ob" > test.txt


できたファイルに対してgpgする。
gpg -e [-o 出力ファイル名] [-r 鍵ユーザID] 暗号化したいファイル

$ gpg -e -r akihiro_ob test.txt 
gpg: 信用データベースの検査
gpg: 最小の「ある程度の信用」3、最小の「全面的信用」1、PGP信用モデル
gpg: 深さ: 0  有効性:   1  署名:   0  信用: 0-, 0q, 0n, 0m, 0f, 1u

•rオプションは指定しなかったアカウントのものを使用する。

でも、ちょっと記憶が曖昧。
兎にも角にも、これでファイルの暗号化が出来ました。

一応、catしてみるか
$ cat test.txt
gpg test desu: o_ob
$ cat test.txt.gpg 
?D?U?n2?&#302;??^h?-?6y??&#891;6?F??e?<@?4-?&#984;?UU?EP?#?Z2&#1924;@?&#19564;8?H???&#377;???5p??9?????????o<QV*??_?&#1181;$??
                                           W????(:CY??^????>?2?p?H
f??+-uKB?&UC?~?qCm?&#194;xRd??Y
???*?? ?[??????',rd???



うん、全くわからん！
これで暗号化は出来ました！


4. 送られてきた暗号化データを秘密鍵で復号化


では、受け取った暗号化ファイルを早速復号化してみる。
gpg [-o ファイル名] [-r 鍵ユーザID] 暗号化ファイル

$ gpg -o test.txt -r akihiro_ob -d test.txt.gpg 
gpg: 1024-ビットELG-E鍵, ID 16B3F987, 日付2012-01-31に暗号化されました
      “akihiro_ob (for test) <xxxxxx@gmail.com>”


あっさりと完了。
ちなみに-dオプションは暗号化ファイルの指定用です。

結果を見てみると。。
$ cat test.txt
gpg test desu: o_ob


復号化ができてる！
これで単純なひと通りのことが出来るはず！


メモ

シェルスクリプトでバッチで動かすって時はこんな感じでやってたのをメモっておきたい。
$ gpg --batch --no-tty --yes -o hukugouka -r akihiro_ob -d angouka



鍵の削除は--delete-keysと--delete-secret-keysで行える。
gpg --delete-keys 鍵ユーザID
gpg --delete-secret-keys 鍵ユーザID

$ gpg --delete-keys akihiro_ob
gpg (GnuPG) 1.4.11; Copyright (C) 2010 Free Software Foundation, Inc.
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.


pub  1024D/A2A4EF37 2012-01-31 akihiro_ob (for test) <akihiro.ob@gmail.com>

この鍵を鍵輪から削除しますか? (y/N) y

