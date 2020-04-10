ECHO OFF
cls & title ADB Mod Pusher/Puller & @Color 0F

:Reload
cls & echo.Pusher Dir: %CD% & echo.ReLoading
set ADBDir=adb.exe
set EmulatorAddress=127.0.0.1:62001
set version=2.0
set lastUpdate=10.04.2020 21:35
set ModPath="C:\Users\toxes\Desktop\HorizonMods\ValkyrieMods"
set ModPathPC="C:\Users\toxes\Desktop\HorizonMods\ValkyrieMods\Mod"
set PushJSPath="C:\Users\toxes\Desktop\HorizonMods\ValkyrieMods\Mod\dev"
set PushAssetsPath="C:\Users\toxes\Desktop\HorizonMods\ValkyrieMods\Mod\assets"

set ModsDir="/sdcard/games/horizon/packs/Test/innercore/mods"
set ModPathDevice="/sdcard/games/horizon/packs/Test/innercore/mods/Mod"
set DeviceJSDir="/sdcard/games/horizon/packs/Test/innercore/mods/Mod/dev"
set DeviceAssetsDir="/sdcard/games/horizon/packs/Test/innercore/mods/Mod/assets"
set DeviceMainJSDir="/sdcard/games/horizon/packs/Test/innercore/mods/Mod/main.js"
echo.Main Path:           %ModPath%
echo.Mod Path:            %ModPathPC%
echo.Mod/dev Path:        %PushJSPath%
echo.Mod/assets Path:     %PushAssetsPath%
echo.Horizon pack Mods:   %ModsDir%
echo.Horizon mod:         %ModPathDevice%
echo.Horizon mod dev:     %DeviceJSDir%
echo.Horizon mod assets:  %DeviceAssetsDir%
echo.Horizon mod main.js: %DeviceMainJSDir%
echo.
%ADBDir% connect %EmulatorAddress% > nul & if errorlevel 1 ( echo.Found new emulator ) else ( echo.No emulators found at %EmulatorAddress%)
@%ADBDir% start-server > nul & if errorlevel 1 ( echo.Starting new ADB server failed ) else ( echo.Started ADB server & echo.Successfully ReLoaded )
timeout 2 > nul & cls & goto Main 

:Main
echo.Serial or IP    Status
%ADBDir% devices -l | find "device product:" >nul & if errorlevel 1 ( echo.     Null   not connected ) else ( %ADBDir% devices | findstr "\<device\>" )
echo.ADB
echo. 1 - Push
echo. 2 - Pull
echo. 3 - Stop Horizon
echo. 4 - Restart Horizon
echo.Other
echo.  L - Crash Logs
echo.  R - Reload configs
echo.  I - Info
set mainInput=x
set /p mainInput="Input: "
cls
if /i %mainInput%==1 goto push
if /i %mainInput%==2 goto pull
if /i %mainInput%==3 %ADBDir% shell am force-stop com.zheka.horizon
if /i %mainInput%==4 %ADBDir% shell am force-stop com.zheka.horizon & %ADBDir% shell monkey -p com.zheka.horizon 1
if /i %mainInput%==L goto log
if /i %mainInput%==R goto Reload
if /i %mainInput%==I goto Info
cls & goto Main

:log
cls
echo.You can't Leave from this. Restart if you need...
%ADBDir% logcat -b crash | findstr AndroidRuntime
>nul pause
cls & goto Main

:push
cls
echo.
echo.Pushing:
echo.  1 - dev and run
echo.  2 - assets and run
echo.  3 - All and run
echo.  4 - dev
echo.  5 - assets
echo.  6 - All
echo. Enter - Exit
set pushing=x
set /p pushing="Input: "
cls

if /i %pushing%==1 (
    %ADBDir% push %PushJSPath% %ModPathDevice%
    %ADBDir% shell am force-stop com.zheka.horizon
    %ADBDir% shell monkey -p com.zheka.horizon 1
)
if /i %pushing%==2 (
    %ADBDir% push %PushAssetsPath% %ModPathDevice%
    %ADBDir% shell am force-stop com.zheka.horizon
    %ADBDir% shell monkey -p com.zheka.horizon 1
)
if /i %pushing%==3 (
    %ADBDir% push %ModPathPC% %ModPathDevice%
    %ADBDir% shell am force-stop com.zheka.horizon
    %ADBDir% shell monkey -p com.zheka.horizon 1
)
if /i %pushing%==4 (
    %ADBDir% push %PushJSPath% %ModPathDevice%
)
if /i %pushing%==5 (
    %ADBDir% push %PushAssetsPath% %ModPathDevice%
)
if /i %pushing%==6 (
    %ADBDir% push %ModPathPC% %ModPathDevice%
)
cls & goto Main

:pull
cls
echo.
echo.Pulling: 
echo.  1 - dev
echo.  2 - assets
echo.  3 - All
echo.  4 - main.js
echo. Enter - Exit
set pulling=x
set /p pulling="Input: "
rem cls
if /i %pulling%==1 (
    %ADBDir% pull %DeviceJSDir% %ModPathPC%
)
if /i %pulling%==2 (
    %ADBDir% pull %DeviceAssetsDir% %ModPathPC%
)
if /i %pulling%==3 (
    %ADBDir% pull %ModPathDevice% %ModPath%
)
if /i %pulling%==4 (
    %ADBDir% pull %DeviceMainJSDir% %ModPathPC%
)
cls & goto Main

:Info
echo. Created at:       10.04.2020
echo. Version:          %version%
echo. Last Updated:     %lastUpdate%
echo. Developed by:     TMM Corporation, Anton Kryzhanovskiy
echo. Developer link    vk.com/tmm_corporation
>nul pause & cls & goto Main