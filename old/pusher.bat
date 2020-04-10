::[Bat To Exe Converter]
::
::fBE1pAF6MU+EWHreyHcjLQlHcBGROXmGIrof/eX+4f6UnmoUQMoqerP6/pajL+Qj/1bscIQR12pK1sgKC3s=
::fBE1pAF6MU+EWHreyHcjLQlHcBGROXmGIrof/eX+4f6UnmoUQMoqerP6/pajL+Qj/1bscIQR135Yy51CCQNdHg==
::fBE1pAF6MU+EWHreyHcjLQlHcBGROXmGIrof/eX+4f6UnmoUQMoqerP6/pajL+Qj/1bscIQR935Yr8ICLQtRMBanYm8=
::fBE1pAF6MU+EWHreyHcjLQlHcBGROXmGIrof/eX+4f6UnmoUQMoqerP6/pajL+Qj/1bscIQR935Yr8ICOQhaXwKiIAs4pQ4=
::YAwzoRdxOk+EWAjk
::fBw5plQjdCyDJGyX8VAjFA5HSRa+GGS5E7gZ5vzo082OtmUIVt4eXK321bC+NfMb71fYZYM+3n9I1sIPA3s=
::YAwzuBVtJxjWCl3EqQJgSA==
::ZR4luwNxJguZRRnk
::Yhs/ulQjdF+5
::cxAkpRVqdFKZSDk=
::cBs/ulQjdF+5
::ZR41oxFsdFKZSTk=
::eBoioBt6dFKZSDk=
::cRo6pxp7LAbNWATEpCI=
::egkzugNsPRvcWATEpCI=
::dAsiuh18IRvcCxnZtBJQ
::cRYluBh/LU+EWAnk
::YxY4rhs+aU+IeA==
::cxY6rQJ7JhzQF1fEqQJhZk4cbgGWPSLa
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
::Zh4grVQjdCyDJGyX8VAjFA5HSRa+GGS5E7gZ5vzo082OtmUIVt4eXK321bC+NfMb71fYcI4o6lt+uvsZHxNdbFr6IFoWrHpD/yqAL8L8
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
:general_menu
ping -n 2 127.0.0.1 > NUL
set version=1.5(Beta)
if /i %debug_mode%==true echo on
if /i %debug_mode%==false echo off
cls
@for /f "usebackq  delims=" %%i in (`find /n /v "" app.cfg ^| find "[1]"`) do (
	set ModDir=%%i
)
@for /f "usebackq  delims=" %%i in (`find /n /v "" app.cfg ^| find "[2]"`) do (
	set ModsDir=%%i
)
@for /f "usebackq  delims=" %%i in (`find /n /v "" app.cfg ^| find "[3]"`) do (
	set ADBDir=%%i
)
if /i %ADBDir:~12%=="" break>%CD%\app.cfg & @echo.%ModDir:~3%>>%CD%\app.cfg & @echo.%ModsDir:~3%>>%CD%\app.cfg & @echo.ADBDir:  "%CD%\adb36.exe">>%CD%\app.cfg & goto general_menu
%ADBDir:~12% connect 127.0.0.1:62001
@%ADBDir:~12% start-server > NUL
cls
title ADB Mod Pusher %version%
echo.Serial or IP    Status
%ADBDir:~12% devices -l | findstr "model:" >nul
if errorlevel 1 (
echo.    null    not connected
	echo.
) else (
%ADBDir:~12% devices | findstr "\<device\>"
echo.
)
cd %CD%
echo.     Horizon:
echo. 1 - Push To %ModsDir:~12%
echo. 2 - Run/Restart Horizon
echo. 3 - Close Horizon
echo. 4 - Push And Run
echo.
echo.     Change Dirs:
echo. 5 - Mod on pc:       %ModDir:~12%
echo. 6 - Mods on android: %ModsDir:~12%
echo. 7 - ADB:             %ADBDir:~12%
echo.
echo.     Program:
echo. L - Show Crash Log
echo. A - About Programm
echo. W - Copy ADB To %WINDIR%
echo. Enter -  Refresh
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
if /i %g_menu%==8 goto change_sys_dir
if /i %g_menu%==L goto log_show
::CHANGED new line for exporting adb files to Windows
if /i %g_menu%==w call %CD%\win_adb.bat
if /i %g_menu%==a goto about_app

if /i %g_menu%==2a581aff-c662-43d4-ad53-3fef822c6557 goto debugging
cls
goto general_menu


:close_inner
cls
echo. Closing Horizon
%ADBDir:~12% shell am force-stop com.zheka.horizon
echo. Status: Closed
cls
goto general_menu


:run_restart_inner
cls
echo. Running/Restarting Horizon
echo. Closing
%ADBDir:~12% connect 127.0.0.1:62001
%ADBDir:~12% shell am force-stop com.zheka.horizon & adb shell monkey -p com.zheka.horizon 1
echo. Running
cls
goto general_menu


:push_and_run
cls
echo. Pushing to device
%ADBDir:~12% push %ModDir:~12% %ModsDir:~12%
echo. Pushed
echo. Stopping Horizon
%ADBDir:~12% shell am force-stop com.zheka.horizon
echo. Running Horizon
%ADBDir:~12% shell monkey -p com.zheka.horizon 1
cls
goto general_menu


:change_mod_dir
cls
title Changing PC ModDir
echo. Current %ModDir:~3%
set /p new_pc= "Input pc mod dir: "
break>%CD%\app.cfg
@echo.ModDir:  "%new_pc%">>%CD%\app.cfg
@echo.%ModsDir:~3%>>%CD%\app.cfg
@echo.%ADBDir:~3%>>%CD%\app.cfg
cls
goto general_menu


:change_mods_dir
cls
title Changing Android ModsDir
echo. Current %ModsDir:~3%
echo. Default: /sdcard/games/com.mojang/mods
set /p new_android= "Input android mod dir: "
if /i %new_android%=="Input android mod dir: " set new_android= "/sdcard/games/com.mojang/mods"
break>%CD%\app.cfg
@echo.%ModDir:~3%>>%CD%\app.cfg
@echo.ModsDir: %new_android%>>%CD%\app.cfg
@echo.%ADBDir:~3%>>%CD%\app.cfg
cls
goto general_menu


:change_adb_dir
cls
title Changing ADBDir
echo. Current %ADBDir:~3%
echo. Default: %CD%\adb.exe
echo. Before changing adb please disconnect all android devices
echo. After adb changed, adb restarts!!!
set /p new_adb= "  Input adb executable dir: "
if /i %new_adb%=="" set new_adb=%CD%\adb36.exe
break>%CD%\app.cfg
@echo.%ModDir:~3%>>%CD%\app.cfg
@echo.%ModsDir:~3%>>%CD%\app.cfg
@echo.ADBDir:  "%new_adb%">>%CD%\app.cfg
cls
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
echo. Last Updated:     30.01.19 17:10
echo. Developed by:     TMM Corporation, Anton Kryzhanovskiy
echo. If program says:  files not found - please rename paths from russian to english chars
>nul pause
cls
goto general_menu

:log_show
cls
adb logcat -b crash | findstr AndroidRuntime
>nul pause
cls
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
echo. adb version:
                   %ADBDir:~12% version
echo. Debug mode   %debug_mode%
if /i %debug_mode%==true echo on & set /p debug_mode=" Disable? "
if /i %debug_mode%==false echo off & set /p debug_mode=" Enable? "
cls
goto general_menu
