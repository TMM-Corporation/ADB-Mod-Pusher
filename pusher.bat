ECHO OFF
cls & title ADB Mod Pusher/Puller & @Color 0F

:Reload
cls & echo.Pusher Local Dir:       %CD% & echo.ReLoading
set ADBDir="D:\ToxesFoxes\Documents\GitHub\ADBModPusher\adb.exe"
set EmulatorAddress=192.168.43.1:5555
set version=2.3
set lastUpdate=27.06.2020 03:18
set AppPackageName=  com.zheka.horizon
set PCFlagAL=        "D:\ToxesFoxes\Documents\GitHub\Libraries\.flag_auto_launch"
set PCRootPath=      "D:\ToxesFoxes\Documents\GitHub"
set PCModPath=       "D:\ToxesFoxes\Documents\GitHub\Libraries\Bowlib"
set PCAssetsPath=    "D:\ToxesFoxes\Documents\GitHub\Libraries\Bowlib\assets"
set PCLibPath=       "D:\ToxesFoxes\Documents\GitHub\Libraries\Bowlib\lib"
set PCDevPath=       "D:\ToxesFoxes\Documents\GitHub\Libraries\Bowlib\source"

set DeviceHorizonDir="/sdcard/games/horizon/"
set DeviceICLog1=     "/sdcard/games/horizon/logs/log.txt"
set DeviceICLog=     "/sdcard/games/horizon/packs/Inner_Core_Test/innercore/inner-core.log"
set DeviceModsDir=   "/sdcard/games/horizon/packs/Inner_Core_Test/innercore/mods"
set DeviceModDir=    "/sdcard/games/horizon/packs/Inner_Core_Test/innercore/mods/Bowlib/"
set DeviceAssetsDir= "/sdcard/games/horizon/packs/Inner_Core_Test/innercore/mods/Bowlib/assets"
set DeviceLibDir=    "/sdcard/games/horizon/packs/Inner_Core_Test/innercore/mods/Bowlib/lib"
set DeviceDevDir=    "/sdcard/games/horizon/packs/Inner_Core_Test/innercore/mods/Bowlib/source"
set DeviceMainJSDir= "/sdcard/games/horizon/packs/Inner_Core_Test/innercore/mods/Bowlib/main.js"
echo.App Package Name:     %AppPackageName%
echo.AutoLaunchFile: %PCFlagAL%
echo.Main Path:        %PCRootPath%
echo.Mod Path:        %PCModPath%
echo.Mod/assets Path:    %PCAssetsPath%
echo.Mod/lib Path:    %PCLibPath%
echo.Mod/dev Path:    %PCDevPath%

echo.Horizon Path:           %DeviceHorizonDir%
echo.InnerCore Log:     %DeviceICLog%
echo.Horizon pack Mods:   %DeviceModsDir%
echo.Horizon mod:        %DeviceModDir%
echo.Horizon mod assets:    %DeviceAssetsDir%
echo.Horizon mod lib:    %DeviceLibDir%
echo.Horizon mod dev:    %DeviceDevDir%
echo.Horizon mod main.js:   %DeviceMainJSDir%
echo.
%ADBDir% connect %EmulatorAddress% > nul & if errorlevel 1 ( echo.Found new emulator ) else ( echo.No emulators found at %EmulatorAddress%)
@%ADBDir% start-server > nul & if errorlevel 1 ( echo.Starting new ADB server failed ) else ( echo.Started ADB server & echo.Successfully ReLoaded )
timeout 2 > nul & cls & goto Main 

:Main
cls
echo.Serial or IP    Status
%ADBDir% devices -l | find "device product:" >nul & if errorlevel 1 ( echo.     Null   not connected ) else ( %ADBDir% devices | findstr "\<device\>" )
echo.
echo.ADB
echo. 1 - Push
echo. 2 - Pull
echo. 3 - Stop Horizon
echo. 4 - Restart Horizon
echo.Other
echo.  L - Crash Logs
echo.  IL- Get Horizon latest.log
echo.  Clr - Clear Mod path from Device
echo.  R - Reload configs
echo.  I - Info
set mainInput=x
set /p mainInput="Input: "
cls
if /i %mainInput%==1 goto push
if /i %mainInput%==2 goto pull
if /i %mainInput%==3 %ADBDir% shell am force-stop %AppPackageName% & cls
if /i %mainInput%==4 %ADBDir% shell am force-stop %AppPackageName% & %ADBDir% shell monkey -p %AppPackageName% 1 & cls
if /i %mainInput%==L goto log
if /i %mainInput%==IL %ADBDir% pull %DeviceICLog% %CD% & %ADBDir% pull %DeviceICLog1% %CD% & cls
if /i %mainInput%==Clr %ADBDir% shell rm -r %DeviceModDir% & cls
if /i %mainInput%==R goto Reload
if /i %mainInput%==I goto Info
cls & goto Main

:log
cls
echo.You can't Leave from this. Restart if you need...
echo.AndroidRuntime Log:
%ADBDir% logcat -b crash | findstr AndroidRuntime
>nul pause
cls & goto Main

:push
cls
echo.
echo.Pushing:
echo.  1 - Dev
echo.  2 - Dev + Lib
echo.  3 - Lib
echo.  4 - Assets
echo.  5 - Assets + Dev
echo.  6 - Assets + Lib
echo.  7 - All
echo.  Enter - Exit
set pushing=x
set /p pushing="Input: "
cls
if /i %pushing%==1 (
    %ADBDir% push %PCDevPath% %DeviceModDir%
    cls & goto Run
)
if /i %pushing%==2 (
    %ADBDir% push %PCDevPath% %DeviceModDir%
    %ADBDir% push %PCLibPath% %DeviceModDir%
    cls & goto Run
)
if /i %pushing%==3 (
    %ADBDir% push %PCLibPath% %DeviceModDir%
    cls & goto Run
)
if /i %pushing%==4 (
    %ADBDir% push %PCAssetsPath% %DeviceModDir%
    cls & goto Run
)
if /i %pushing%==5 (
    %ADBDir% push %PCAssetsPath% %DeviceModDir%
    %ADBDir% push %PCDevPath% %DeviceModDir%
    cls & goto Run
)
if /i %pushing%==6 (
    %ADBDir% push %PCAssetsPath% %DeviceModDir%
    %ADBDir% push %PCLibPath% %DeviceModDir%
    cls & goto Run
)
if /i %pushing%==7 (
    %ADBDir% push %PCModPath% %DeviceModsDir%
    cls & goto Run
)
cls & goto Main

:Run
cls
echo. Run Horizon app?
echo. 1 - Yes
echo. Enter - No, exit
set running=x
set /p running="Input: "
cls
if /i %running%==1 (
    %ADBDir% push %PCFlagAL% %DeviceHorizonDir% > nul
    %ADBDir% shell am force-stop %AppPackageName%
    %ADBDir% shell monkey -p %AppPackageName% 1 & cls
)
cls & goto Main

:pull
cls
echo.
echo.Pulling: 
echo.  1 - Assets
echo.  2 - Lib
echo.  3 - Dev
echo.  4 - All
echo.  5 - main.js
echo. Enter - Exit
set pulling=x
set /p pulling="Input: "
rem cls
if /i %pulling%==1 (
    %ADBDir% pull %DeviceAssetsDir% %PCModPath% & cls
)
if /i %pulling%==2 (
    %ADBDir% pull %DeviceLibDir% %PCModPath% & cls
)
if /i %pulling%==3 (
    %ADBDir% pull %DeviceDevDir% %PCModPath% & cls
)
if /i %pulling%==4 (
    %ADBDir% pull %DeviceModDir% %PCRootPath% & cls
)
if /i %pulling%==5 (
    %ADBDir% pull %DeviceMainJSDir% %PCModPath% & cls
)
cls & goto Main

:Info
echo. Created at:       10.04.2020
echo. Version:          %version%
echo. Last Updated:     %lastUpdate%
echo. Developed by:     TMM Corporation, Anton Kryzhanovskiy
echo. Developer link    vk.com/tmm_corporation
>nul pause & cls & goto Main