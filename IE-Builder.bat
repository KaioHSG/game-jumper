@echo off
set "sedFile=Game-Jumper.sed"
title IExpress Builder
whoami /groups | find "S-1-16-12288" > nul
if %errorLevel% neq 0 (
   echo Accept Administrator Privileges to continue.
   echo createObject("shell.application"^).shellExecute "%~s0", "", "", "runas", 1 > "%temp%\UAC_%~n0.vbs"
   "%temp%\UAC_%~n0.vbs"
   del "%temp%\UAC_%~n0.vbs" /q
   exit
)
pushd "%~dp0"
start "" "%WinDir%\System32\iexpress.exe" /n %sedFile%
exit