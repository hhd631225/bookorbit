@echo off
chcp 65001 >nul
setlocal enabledelayedexpansion

:: ============================================================
:: bookorbit - 瑞虎7 PLUS 8155 / Lion5.0 高德9.x飞屏一键脚本
:: 前提：电脑已装 adb，且已与车机通过 adb connect <车机IP>:5555 连上
:: 用法：双击运行，或命令行 bookorbit.bat
:: ============================================================

set PKG=com.amapauto

:menu
echo.
echo ===== bookorbit 飞屏工具 =====
echo  1. 启动高德9.x
echo  2. 直接打开巡航（飞屏核心）
echo  3. 授予悬浮窗权限
echo  4. 加入省电白名单（保活）
echo  5. 杀高德进程
echo  6. 一键全部初始化（授权+白名单+开巡航）
echo  0. 退出
echo ===============================
set /p choice=请输入序号后回车:

if "%choice%"=="1" goto start_amap
if "%choice%"=="2" goto start_cruise
if "%choice%"=="3" goto grant_overlay
if "%choice%"=="4" goto whitelist
if "%choice%"=="5" goto force_stop
if "%choice%"=="6" goto setup_all
if "%choice%"=="0" goto end
goto menu

:start_amap
adb shell am start -n %PKG%/.MainActivity
goto menu

:start_cruise
adb shell am start -n %PKG%/.cruise.CruiseActivity
goto menu

:grant_overlay
adb shell pm grant %PKG% android.permission.SYSTEM_ALERT_WINDOW
echo 已授予悬浮窗权限
goto menu

:whitelist
adb shell dumpsys deviceidle whitelist +%PKG%
echo 已加入省电白名单
goto menu

:force_stop
adb shell am force-stop %PKG%
adb shell am force-stop com.autonavi.minimap
adb shell am force-stop com.mcar.auto
echo 已杀掉相关进程
goto menu

:setup_all
call :grant_overlay
call :whitelist
call :start_cruise
echo 初始化完成
goto menu

:end
endlocal
