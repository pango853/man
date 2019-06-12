@ECHO OFF

SET SQ=D:\path-to-sqlite\sqlite3

REM	Usage:
REM		keyvault SERVICENAME
REM			http://service.url/	username	XXXXRAMDOMIZEDYYY
REM		keyvault SERVICENAME USER
REM		keyvault add SERVICENAME	URL	username	password


REM If not exist create

REM CREATE TABLE vault(
REM		id   INTEGER PRIMARY KEY,
REM		name TEXT NOT NULL,
REM		url  INTEGER NOT NULL,
REM		created	TIMESTAMP DEFAULT (datetime(CURRENT_TIMESTAMP,'localtime')))";
REM CREATE TABLE vault(
REM		id   INTEGER PRIMARY KEY,
REM		name TEXT NOT NULL,
REM		url  INTEGER NOT NULL,
REM		created	TIMESTAMP DEFAULT (datetime(CURRENT_TIMESTAMP,'localtime')))";
REM sqlite3 -line mydata.db 'select * from memos where priority > 20;'


echo 'HelloWorld!' | gpg --symmetric | base64
echo -n 'jA0EAwMCPdknsznAww5gySL1/quqhXg6QgQkIz5abzGP5EZgTbXCFU+y6dP8ySWovytc' | base64 --decode | gpg --decrypt

echo "TEST"|openssl enc -aes-128-cbc -e -base64 -pass pass:test -p
-aes-128-cbc：AES暗号、128ビット、CBCモード
-e：暗号化
-base64：表示をBase64で表示する。
-pass pass:test：パスワードフレーズとしてtestを使用
-p：saltやKey、IVを表示

salt=F6BEF056BA3B3E00
key=0A1430ED15866E4907BB3F98EA19F463
iv =E2FC0CE7D64F5A86034F487E7E50A5B4
U2FsdGVkX1/2vvBWujs+AKB//Shqg1mdUOMFvoNyi/o=


#echo "U2FsdGVkX1/2vvBWujs+AKB//Shqg1mdUOMFvoNyi/o="|openssl enc -d -aes-128-cbc -base64 -pass pass:test -p

結果の表示
salt=F6BEF056BA3B3E00
key=0A1430ED15866E4907BB3F98EA19F463
iv =E2FC0CE7D64F5A86034F487E7E50A5B4
TEST



echo hahaha | clip
type file.txt | clip



CALL :ADD


GOTO :END

:ADD
	ECHO.Add...
	
	GOTO :END

:FIND
	ECHO.Find...
	
	GOTO :END


:END
ECHO.Bye!
