@echo off

SET z7="C:\Program Files\7-Zip\7z.exe"
SET PW=%USERNAME%
SET PREFIX=FileNamePrefix-
SET DIR_REMOTE=folder1/
SET WINSCP_WITH_SESSION=X:\SOFT\WinSCP\WinSCP.com FOLDER/SESSIONNAME

REM doskey 7z="D:\Program Files\7-Zip\7z.exe" $* # doskey NOT WORK in script

for %%a in (%*) do echo [%%a] was dropped on me

For /f "usebackqdelims=" %%A in (
  `Powershell.exe -nologo -NoProfile -command "Get-Date -UFormat '%%m%%d-%%H%%M%%S'"`
) Do Set TS=%%A
SET FN=%PREFIX%%TS%

%z7% a -tzip %FN%.zip %*
%z7% a -t7z %FN%.7z -v20m -v10m -p%PW% -mhe %FN%.zip

del %FN%.zip

%WINSCP_WITH_SESSION% /command cd "cd %DIR_REMOTE%" pwd "put %cd%\*.7z* ./" exit

pause
