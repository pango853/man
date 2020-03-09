
sqlite3 -zip auth.zip




@SETLOCAL enableextensions ENABLEDELAYEDEXPANSION
@echo off

SET CMDEXEC=D:\SOFT\HTTPProxyAuth\HttpProxyAuth
SET PROXY=localhost:8080
SET DOMAINCHECK=MYDOMAIN
SET TMPFILE=%Temp%\httpproxyauth.dat

SET PSWD=%1%2
SET EXITCODE=99

REM Abort if tmpfile already exists
IF "x%PSWD%" == "x" (
	ECHO.Please set password as the first argument.
	SET EXITCODE=1
	GOTO :END
) ELSE (
	CALL :PSWDDECRYPT
)

REM Abort if tmpfile already exists
IF EXIST %TMPFILE% (
	REM CALL :SUBROUTINE
	ECHO."%TMPFILE%" already exists! Abort...
	GOTO :END
)

powershell.exe -ExecutionPolicy Bypass -NoLogo -NonInteractive -NoProfile -Command ^
  "$rs=@{$true=$True; $false=$False}[$Env:USERDOMAIN -eq '%DOMAINCHECK%']; If($rs){$Env:USERNAME}else{exit 1};" > %TMPFILE%
echo %ERRORLEVEL%
IF %ERRORLEVEL% NEQ 0 (
	ECHO.powershell failed!.
	SET EXITCODE=2
	del %TMPFILE%
	GOTO :END
)

set /p CMDOUTPUT= < %TMPFILE%
del %TMPFILE%
SET USER=%CMDOUTPUT%

%CMDEXEC% "%USER%:%PSWD%@%PROXY%" 8888 > NUL
SET EXITCODE=%ERRORLEVEL%
IF %ERRORLEVEL% NEQ 0 (
	ECHO.%CMDEXEC% failed!.
	del %TMPFILE%
	GOTO :END
)

GOTO :END

:UPPERCASE
  FOR %%a IN (A B C D E F G H I J K L M N O P Q R S T U V W X Y Z) DO CALL SET "%1=%%%1:%%a=%%a%%%"
  GOTO :EOF

:SUBROUTINE
  set output=*** something wrong! ***
  echo %output%
  REM echo %output% >> %logFile%
  set success=false
  goto :EOF

:PSWDDECRYPT
  SET A=%PSWD:~0,2%
  CALL :UPPERCASE A
  SET B=%PSWD:~2,4%
  SET C=%USERNAME:~0,4%
  SET D=%PSWD:~-1%
  SET PSWD=%A%%B%%C%%D%
  GOTO :EOF

:END
IF %EXITCODE% NEQ 0 (
	echo.ERROR[%EXITCODE%]
	ENDLOCAL
	echo exit /b 1
)
ENDLOCAL

ECHO.Press any key to exit...
PAUSE