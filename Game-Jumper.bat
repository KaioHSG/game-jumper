@echo off
setlocal enabledelayedexpansion
set "version=0.1"
title Game Jump (v%version%)
set "listPath=%userProfile%\Game Jump"
if not exist "%listPath%" (
    mkdir "%listPath%"
)
pushd "%listPath%"
if not exist "game-list" (
    echo Game Jump List > "game-list"
)

:main
cls
echo Game Jump ("%cd%")
echo.
echo [0] Add new game
set count=0
for /f "tokens=1,* delims=|" %%a in ('findstr /v "Game Jump List" game-list') do (
    if not "%%a"=="::" (
        set /a count+=1
        set "gameName!count!=%%a"
        set "gamePath!count!=%%b"
        echo [!count!] %%a - %%b
    )
)
echo.

:select
set /p "opt=Select a game: "
if "%opt%"=="0" (goto :add)
if not defined gamePath%opt% (goto :select)
cls
echo Don't close this window!
echo.
echo Running: !gameName%opt%!
start /wait "" "!gamePath%opt%!"
goto :main

:add
cls
set /p "gameName=Game name: "

:path
set /p "gamePath=Path to the executable: "
if not exist "%gamePath%" (
    echo File not found.
    goto :path
)
echo %gameName%^|%gamePath% >> "game-list"
goto :main