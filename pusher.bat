::[Bat To Exe Converter]
::
::fBE1pAF6MU+EWHreyHcjLQlHcBGROXmGIrAP4/z0/9aqu30IR+o6arPa3rbAJfgWig==
::fBE1pAF6MU+EWHreyHcjLQlHcBGROXmGIrAP4/z0/9aqu30IR+o6arP63ra5Ke4y+kyqcZohtg==
::fBE1pAF6MU+EWHreyHcjLQlHcBGROXmGIrAP4/z0/9aqu30IR+o6arP63ra5Ke4m+UfFZZ9j0nZW+A==
::fBE1pAF6MU+EWHreyHcjLQlHcBGROXmGIrAP4/z0/9aqu30IR+o6arP21bCqKfJd/l3wFQ==
::fBE1pAF6MU+EWHreyHcjLQlHcBGROXmGIrAP4/z0/9aqu30IR+o6arP21bCdBOkBpFH8YfY=
::YAwzoRdxOk+EWAjk
::fBw5plQjdCyDJGyX8VAjFA5HSRa+GG6pDaET+NTW9tqSsUUYRt4vbZzT36bAKeMcig==
::YAwzuBVtJxjWCl3EqQJgSA==
::ZR4luwNxJguZRRnk
::Yhs/ulQjdF+5
::cxAkpRVqdFKZSDk=
::cBs/ulQjdF+5
::ZR41oxFsdFKZSDk=
::eBoioBt6dFKZSDk=
::cRo6pxp7LAbNWATEpCI=
::egkzugNsPRvcWATEpCI=
::dAsiuh18IRvcCxnZtBJQ
::cRYluBh/LU+EWAnk
::YxY4rhs+aU+IeA==
::cxY6rQJ7JhzQF1fEqQJhZkgcbgGWPSLa
::ZQ05rAF9IBncCkqN+0xwdVsFAlTi
::ZQ05rAF9IAHYFVzEqQIRDDkUYQuGfFuvFb0Z+og=
::eg0/rx1wNQPfEVWB+kM9LVsJDCWmHluvFb0Z+og=
::fBEirQZwNQPfEVWB+kM9LVsJDAWGPlSqE6YU7fqb
::cRolqwZ3JBvQF1fEqQIROAsUTxaHPX+/AvUe8ajPwsfHgUIPRO0teZvS1brOJu8BqlXxZp4k2H0alcQIH1tXcFKKSi1U
::dhA7uBVwLU+EWG2L+28xJgJ5QwCRXA==
::YQ03rBFzNR3SWATEwG8dSA==
::dhAmsQZ3MwfNWATE1UwkJxUUZxabJmO7CLoK++Py9oo=
::ZQ0/vhVqMQ3MEVWAtB9wBhRaATSQNX27ErB8
::Zg8zqx1/OA3MEVWAtB9wGwtRTw2DMAs=
::dhA7pRFwIByZRRnk
::Zh4grVQjdCyDJGyX8VAjFA5HSRa+GG6pDaET+NTW9tqSsUUYRt4eXK3rz6eGJfJbuwu3V5M51zMUndMJbA==
::YB416Ek+ZG8=
::
::
::978f952a14a936cc963da21a135fa983
﻿chcp 866>nul
@echo off
cls
@Color 0F
@ECHO. Loading...
ping -n 2 127.0.0.1 > NUL
cls
:general_menu
cls
@adb start-server > NUL
cls
title ADB Mod Pusher
echo. Created By TMM Corporation by Anton Kryzhanovskiy in 28.01.2019
echo. ADB Mod pusher Current Version: v1.3(Beta)
echo.
echo.   Serial       Status
adb devices -l | find "device product:" >nul
if errorlevel 1 (
    echo No ADB connected devices
	echo.  
) else (
adb devices | findstr "\<device\>"
echo.
)
cd %CD%
set /P ModDir= < %CD%\ModDir.txt
set /P ModsDir= < %CD%\ModsDir.txt

echo.      Push to:
echo.  1 -  Mod Dir To                     %ModsDir%
echo.      InnerCore:
echo.  2 -  Run/Restart InnerCore
echo.  3 -  Close InnerCore
echo.  4 -  Push And Run
echo.      Change Dirs:
echo.  5 -  Change Current PC Mod Dir      %ModDir%
echo.  6 -  Change Current Android Mod Dir %ModsDir%
echo.      Program:
echo.       Enter -  Refresh
echo.       A -  About Programm

set g_menu=x
set /p g_menu=" Input: "
cls

if /i %g_menu%==1 adb push %ModDir% %ModsDir%
if /i %g_menu%==2 adb shell am force-stop com.zhekasmirnov.innercore & adb shell monkey -p com.zhekasmirnov.innercore 1
if /i %g_menu%==3 adb shell am force-stop com.zhekasmirnov.innercore
if /i %g_menu%==4 adb push %ModDir% %ModsDir% & adb shell am force-stop com.zhekasmirnov.innercore & adb shell monkey -p com.zhekasmirnov.innercore 1
if /i %g_menu%==5 goto change_mod_dir
if /i %g_menu%==6 goto change_mods_dir
if /i %g_menu%==a goto about_app
cls
goto general_menu


:change_mod_dir
cls
title %ModDir%
set /p old_pc=" Input pc mod dir: "
@echo.%old_pc%> %CD%\ModDir.txt
goto general_menu

:change_mods_dir
cls
title %ModsDir%
set /p old_android=" Input android mod dir: "
@echo.%old_android%> %CD%\ModsDir.txt
goto general_menu

:about_app
cls
::echo. File version:       1.3(Beta)
::echo. Product version:    1.0
::echo. Product name:       ADB Mod Pusher
::echo. Origignal filename: ADBPusher
::echo. Internal filename:  adb_pusher
::echo. Description:        App created by TMM Corporation for pushing mods on ADB
::echo. Company:            TooManyMods
::echo. Trademarks:         TMM
::echo. Copyright:          Anton Kryzhanovskiy
::echo. Private:            Non-Private
::echo. Special:            Special
echo. Version:          1.3(Beta)
echo. Developed by:     TMM Corporation, Anton Kryzhanovskiy  
echo. If program says:  files not found - please rename paths from russian to english chars
echo.
>nul pause
goto general_menu
cls


