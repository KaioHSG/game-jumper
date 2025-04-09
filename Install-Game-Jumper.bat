@echo off
set "version=0.1"
title Game Jumper Installer (v%version%)
whoami /groups | find "S-1-16-12288" > nul
if %errorLevel% neq 0 (
   echo Accept Administrator Privileges to continue.
   echo createObject("shell.application"^).shellExecute "%~s0", "", "", "runas", 1 > "%temp%\UAC_%~n0.vbs"
   "%temp%\UAC_%~n0.vbs"
   del "%temp%\UAC_%~n0.vbs" /q
   exit
)
pushd "%~dp0"
echo Game Jumper Installer
ping /n 1 github.com > nul
if %errorLevel% neq 0 (
    echo ##################################################
    echo No server connection. Please check your internet connection and try again.
    pause > nul
    exit
)
echo.
set /p "spacewarPath=Path of Spacewar (e.g. 'C:\Program Files (x86)\Steam\steamapps\common\Spacewar'): "
curl -s https://api.github.com/repos/KaioHSG/game-jumper/releases/latest > %temp%\latest-release.json
for /f "tokens=3 delims=:" %%a in ('findstr /i "browser_download_url" %temp%\latest-release.json') do set "url=https:%%a"
del /q "%temp%\latest-release.json"
if exist "Game-Jumper.exe" (del /q "Game-Jumper.exe")
echo --------------------------------------------------
curl -L -o "Game-Jumper.exe" %url%
echo -------------------------------------------------
xcopy "Game-Jumper.exe" "%spacewarPath%\SteamworksExample.exe" /y
echo ##################################################
echo Install finish.
pause > nul
exit