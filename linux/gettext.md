gettext

# gettextを使う手順
1. gettextを使ったアプリケーション開発の流れは、一般論としては次のようなものになります。
2. ソースコード作成に際して、gettextを使う準備をしておく。
3. ソースコードを作成する。この時、翻訳が必要なメッセージは、何らかの書式で記載すること。なお、この時点でのメッセージは英語が望ましい（後述）。
4. 翻訳が必要なメッセージをツールで抽出し、翻訳テンプレートファイル（POTファイル）を生成（更新）する。
5. POTファイルをもとに、翻訳ファイル（POファイル）を作成（更新）する。
6. 翻訳者は、POファイルを翻訳する。
7. 翻訳されたPOファイルから、機械処理向けのMOファイルを作成する。
8. MOファイルを適切な場所に配置する。
9. アプリケーションがMOファイルを読み込み、アプリケーション利用者の環境に応じた言語でメッセージを表示する。



# Installation

```
# yum install gettext
OR
# tar zxvf gettext-0.14.tar.gz
# cd gettext-0.14
# ./configure --prefix=/usr
OR ./configure --prefix=/usr --disable-csharp
# make
# make install
```

# Samples

```ja/LC_MESSAGES/test.po
"Content-Type: text/plain; charset=UTF-8\n"
"Content-Transfer-Encoding: 8bit\n"

#: cp1.c:44
#, c-format
msgid "%s and %s are the same file\n"
msgstr "%s と %s は同じファイルです\n"
```


# Dict
- po: Portable Object

# Commands

```
$ msginit

$ msgmerge


Generate mo
$ msgfmt -c --statistics ja.po -o test.mo
$ msgfmt -o test.mo test.po

次に.potファイルを作る。
$ xgettext -k"_" -o test.pot cp1.c

xgettext -k"_" -k"_n:1,2" -k"_p:1c,2" -k"_pn:1c,2,3"
```

# TODO
- https://poedit.net/
- NGettext: https://github.com/neris/NGettext
