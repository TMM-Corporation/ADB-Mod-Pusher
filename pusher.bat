::[Bat To Exe Converter]
::
::fBE1pAF6MU+EWHreyHcjLQlHcBGROXmGIrof/eX+4f6UnmoUQMoqerP6/pajL+Qj/1bscIQR135Y1s4UCXs=
::fBE1pAF6MU+EWHreyHcjLQlHcBGROXmGIrof/eX+4f6UnmoUQMoqerP6/pajL+Qj/1bscIQR935Yr8ICLQtRMBanYm8=
::fBE1pAF6MU+EWHreyHcjLQlHcBGROXmGIrof/eX+4f6UnmoUQMoqerP6/pajL+Qj/1bscIQR935Yr8ICOQhaXwKiIAs4pQ4=
::fBE1pAF6MU+EWHreyHcjLQlHcBGROXmGIrof/eX+4f6UnmoUQMoqerP6/pajL+Qj/1bscIQR12pK1sgKC3s=
::YAwzoRdxOk+EWAjk
::fBw5plQjdCyDJGyX8VAjFA5HSRa+GGS5E7gZ5vzo082OtmUIVt4eXK321bC+NfMb71fYZYM+3n9I1sIPA3s=
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
::cxY6rQJ7JhzQF1fEqQJhZk8cbgGWPSLa
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
::Zh4grVQjdCyDJGyX8VAjFA5HSRa+GGS5E7gZ5vzo082OtmUIVt4eXK321bC+NfMb71fYVLIP5m9JkM4eREoWKjCueg5952taswQ=
::YB416Ek+ZG8=
::
::
::978f952a14a936cc963da21a135fa983
﻿chcp 866>nul
@echo off
title ADBModPusher
set debug_mode=false
cls
@Color 0F
@ECHO. Loading...
ping -n 2 127.0.0.1 > NUL
cls
:general_menu
set version=1.4(Beta)
if /i %debug_mode%==true echo on
if /i %debug_mode%==false echo off
cls
@adb start-server > NUL
cls
title ADB Mod Pusher %version%
echo.   Serial       Status
adb devices -l | find "device product:" >nul
if errorlevel 1 (
echo.    null    not connected
	echo.  
) else (
adb devices | findstr "\<device\>"
echo.
)
cd %CD%
@for /f "usebackq  delims=" %%i in (`find /n /v "" app.cfg ^| find "[1]"`) do (
	set ModDir=%%i
)
@for /f "usebackq  delims=" %%i in (`find /n /v "" app.cfg ^| find "[2]"`) do (
	set ModsDir=%%i
)
@for /f "usebackq  delims=" %%i in (`find /n /v "" app.cfg ^| find "[3]"`) do (
	set ADBDir=%%i
)
echo.  1 -  Push To %ModsDir:~12%
echo.    InnerCore:
echo.  2 -  Run/Restart InnerCore
echo.  3 -  Close InnerCore
echo.  4 -  Push And Run
echo.    Change Dirs:
echo.  5 -  Mod on pc:       %ModDir:~12%
echo.  6 -  Mods on android: %ModsDir:~12%
echo.  7 -  ADB:             %ADBDir:~12%
echo.    Program:
echo.  A -  About Programm
echo.  Enter -  Refresh

set g_menu=x
set /p g_menu=" Input: "
cls

if /i %g_menu%==1 adb push %ModDir:~12% %ModsDir:~12%

if /i %g_menu%==2 goto run_restart_inner
if /i %g_menu%==3 goto close_inner
if /i %g_menu%==4 goto push_and_run

if /i %g_menu%==5 goto change_mod_dir
if /i %g_menu%==6 goto change_mods_dir
if /i %g_menu%==7 goto change_adb_dir

if /i %g_menu%==a goto about_app

if /i %g_menu%==2a581aff-c662-43d4-ad53-3fef822c6557 goto debugging
cls
goto general_menu

:close_inner
cls
echo. Closing InnerCore
adb shell am force-stop com.zhekasmirnov.innercore
echo.  Closed
echo. Press Any Key To exit...
>nul pause
goto general_menu

:run_restart_inner
cls
echo. Running/Restarting InnerCore
echo.  Closing
adb shell am force-stop com.zhekasmirnov.innercore & adb shell monkey -p com.zhekasmirnov.innercore 1
echo.  Running
echo. Press Any Key To exit...
>nul pause
goto general_menu

:push_and_run
echo. Closing
adb shell am force-stop com.zhekasmirnov.innercore
echo. Pushing to device
adb push %ModDir:~12% %ModsDir:~12%
echo.  Pushed
echo. Running InnerCore
adb shell monkey -p com.zhekasmirnov.innercore 1
echo. Press Any Key To exit...
>nul pause
goto general_menu

:change_mod_dir
cls
title Changing PC ModDir
echo. Current %ModDir:~3%
set /p new_pc= "Input pc mod dir: "
break>%CD%\app.cfg
@echo.ModDir:  %new_pc%>>%CD%\app.cfg
@echo.%ModsDir:~3%>>%CD%\app.cfg
@echo.%ADBDir:~3%>>%CD%\app.cfg
goto general_menu

:change_mods_dir
cls
title Changing Android ModsDir
echo. Current %ModsDir:~3%
set /p new_android= "Input android mod dir: "
break>%CD%\app.cfg
@echo.%ModDir:~3%>>%CD%\app.cfg
@echo.ModsDir: %new_android%>>%CD%\app.cfg
@echo.%ADBDir:~3%>>%CD%\app.cfg
goto general_menu

:change_adb_dir
cls
title Changing ADBDir
echo. Current %ADBDir:~3%
set /p new_adb= "Input adb dir: "
break>%CD%\app.cfg
@echo.%ModDir:~3%>>%CD%\app.cfg
@echo.%ModsDir:~3%>>%CD%\app.cfg
@echo.ADBDir:  %new_adb%>>%CD%\app.cfg
goto general_menu

:about_app
cls
::echo. File version:       %version%
::echo. Product version:    1.0s
::echo. Product name:       ADB Mod Pusher
::echo. Origignal filename: ADBPusher
::echo. Internal filename:  adb_pusher
::echo. Description:        App created by TMM Corporation for pushing mods on ADB
::echo. Company:            TooManyMods
::echo. Trademarks:         TMM
::echo. Copyright:          Anton Kryzhanovskiy
::echo. Private:            Non-Private
::echo. Special:            Special
echo. Created at:       28.01.2019
echo. Version:          %version%
echo. Last Updated:     30.01.19 16:10
echo. Developed by:     TMM Corporation, Anton Kryzhanovskiy  
echo. If program says:  files not found - please rename paths from russian to english chars
>nul pause
goto general_menu

:debugging
echo.Current paths
echo. CD           %CD%
echo. ModDir       %ModDir%
echo. ModsDir      %ModsDir%
echo. ADBDir       %ADBDir%
echo.Changable in Console
echo. new_adb      %new_adb%
echo. new_android  %new_android%
echo. new_pc       %new_pc%
echo. g_menu       %g_menu%
echo. Debug mode   %debug_mode%
if /i %debug_mode%==true echo on & set /p debug_mode=" Disable? "
if /i %debug_mode%==false echo off & set /p debug_mode=" Enable? "
goto general_menu
