@ECHO OFF
SETLOCAL ENABLEEXTENSIONS

SET SQUERY=sqlite3 D:\test.db
SET ARG1=%1
SET ARG2=%2
SET ARG3=%3
SET ARG4=%4
SET ARG5=%5

REM === TODO ===
REM [1] Encrypt secret
REM [2] Error handling


IF "%~1"=="" GOTO :USAGE

GOTO :INIT

:USAGE
ECHO.Usage:
ECHO.	keyvault SERVICENAME
ECHO.	keyvault SERVICENAME OFFSET
ECHO.	keyvault add NAME001 user001 XxXxPaSsWoRdYyYy http://service001.url/
GOTO :END


:INIT
SET Q=CREATE TABLE IF NOT EXISTS services(^
 id INTEGER PRIMARY KEY,^
 name VARCHAR(127) NOT NULL UNIQUE,^
 url VARCHAR(255) NOT NULL UNIQUE,^
 created TIMESTAMP DEFAULT (datetime(CURRENT_TIMESTAMP,'localtime')));
%SQUERY% "%Q%"

SET Q=CREATE TABLE IF NOT EXISTS keypairs(^
 id INTEGER PRIMARY KEY,^
 service INTEGER NOT NULL,^
 user VARCHAR(128) NOT NULL,^
 secret TEXT NOT NULL,^
 created TIMESTAMP DEFAULT (datetime(CURRENT_TIMESTAMP,'localtime')),^
 FOREIGN KEY(service) REFERENCES services(id));
%SQUERY% "%Q%"

SET Q=CREATE UNIQUE INDEX IF NOT EXISTS keypairs_service_user_idx ON keypairs (service, user);
%SQUERY% "%Q%"


:QUERY
REM :ADD 1:add 2:NAME001 3:user001 4:XxXxPaSsWoRdYyYy 5:http://service001.url/
REM :GET 1:pattern 2:offset
SET ACTION=%1
SET NAME=%2
SET USER=%3
SET PSWD=%4
SET URL=%5
IF x"%ARG1%" == x"add" GOTO :ADD
REM else:
SET PATTERN=%ACTION%
SET OFFSET=%NAME%
IF x"%OFFSET%" == x"" GOTO :GET_WITHOUT_OFFSET 
REM else:
GOTO :GET

:GET_WITHOUT_OFFSET
	Echo.Initialize OFFSET=0
	SET OFFSET=0
	GOTO :GET

REM CREATE TABLE service(
REM		id   INTEGER PRIMARY KEY,
REM		name TEXT NOT NULL,
REM		url  INTEGER NOT NULL,
REM		created	TIMESTAMP DEFAULT (datetime(CURRENT_TIMESTAMP,'localtime')))";
REM CREATE TABLE (
REM		id   INTEGER PRIMARY KEY,
REM		vault   INTEGER,
REM		user TEXT NOT NULL,
REM		secret  INTEGER NOT NULL,
REM		created	TIMESTAMP DEFAULT (datetime(CURRENT_TIMESTAMP,'localtime')))";

REM IF EXISTS (SELECT 1 
REM            FROM INFORMATION_SCHEMA.TABLES 
REM            WHERE TABLE_TYPE='BASE TABLE' 
REM            AND TABLE_NAME='mytablename') 
REM    SELECT 1 AS res ELSE SELECT 0 AS res;


REM sqlite3 -line mydata.db 'select * from memos where priority > 20;'


REM	echo 'HelloWorld!' | gpg --symmetric | base64
REM	echo -n 'jA0EAwMCPdknsznAww5gySL1/quqhXg6QgQkIz5abzGP5EZgTbXCFU+y6dP8ySWovytc' | base64 --decode | gpg --decrypt

REM	echo "TEST"|openssl enc -aes-128-cbc -e -base64 -pass pass:test -p
REM	-aes-128-cbc：AES暗号、128ビット、CBCモード
REM	-e：暗号化
REM	-base64：表示をBase64で表示する。
REM	-pass pass:test：パスワードフレーズとしてtestを使用
REM	-p：saltやKey、IVを表示

REM	salt=F6BEF056BA3B3E00
REM	key=0A1430ED15866E4907BB3F98EA19F463
REM	iv =E2FC0CE7D64F5A86034F487E7E50A5B4
REM	U2FsdGVkX1/2vvBWujs+AKB//Shqg1mdUOMFvoNyi/o=


REM	echo "U2FsdGVkX1/2vvBWujs+AKB//Shqg1mdUOMFvoNyi/o="|openssl enc -d -aes-128-cbc -base64 -pass pass:test -p

REM	結果の表示
REM	salt=F6BEF056BA3B3E00
REM	key=0A1430ED15866E4907BB3F98EA19F463
REM	iv =E2FC0CE7D64F5A86034F487E7E50A5B4
REM	TEST


GOTO :END

:ADD
	IF x"%NAME%" == x"" GOTO :USAGE
	IF x"%USER%" == x"" GOTO :USAGE
	IF x"%PSWD%" == x"" GOTO :USAGE
	IF x"%URL%" == x"" GOTO :USAGE

	SET Q=INSERT INTO services (name, url) VALUES('%NAME%', '%URL%');
	%SQUERY% "%Q%"
	SET Q=INSERT INTO keypairs (service, user, secret) SELECT id, '%USER%', '%PSWD%' FROM services WHERE name LIKE '%NAME%' LIMIT 1;
	%SQUERY% "%Q%"

	%SQUERY% -line "SELECT COUNT(id) AS 'services number'FROM services"
	%SQUERY% -line "SELECT COUNT(id) AS 'keypairs number' FROM keypairs"

	SET PATTERN=%NAME%
	SET OFFSET=0
	GOTO :GET


:GET
	SET Q=SELECT s.id, s.name, s.url, k.user FROM services AS s LEFT JOIN keypairs as k ON s.id = k.service WHERE s.name LIKE '%%%PATTERN%%%' OR s.url LIKE '%%%PATTERN%%%' LIMIT 10 OFFSET %OFFSET%;
	%SQUERY% -column -header "%Q%"
	IF %ERRORLEVEL% EQU 0 GOTO :COPY

	ECHO.[ERROR] Something wrong. Aborted!
	GOTO :END

:COPY
	SET /p<nul =Press any key to clip secret... &PAUSE>nul

	SET Q=SELECT k.secret FROM services AS s LEFT JOIN keypairs as k ON s.id = k.service WHERE s.name LIKE '%%%PATTERN%%%' OR s.url LIKE '%%%PATTERN%%%' LIMIT 1 OFFSET %OFFSET%;
	%SQUERY% -column "%Q%" | clip
	ECHO.Copied!!!
	SET /p<nul =Press any key to clear... &PAUSE>nul
	TYPE nul | clip
	ECHO.Cleared.
	GOTO :END


:END
ECHO.Bye!

ENDLOCAL
