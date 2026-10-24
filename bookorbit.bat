@echo off
chcp 65001 >nul
setlocal enabledelayedexpansion

:: ============================================================
:: bookorbit - 瑞虎7 PLUS 8155 / Lion5.0 高德9.x飞屏一键脚本
:: 前提：电脑已装 adb
:: ============================================================

:: >>> 改成你车机的局域网 IP（车机 设置-关于-状态 里查看）
set CAR_IP=192.168.1.100
set CAR_PORT=5555
set PKG=com.amapauto

:menu
echo.
echo ===== bookorbit 飞屏工具 =====
echo  当前车机地址: %CAR_IP%:%CAR_PORT%
echo  0. 退出
echo  ----------------------------
echo  1. 连接车机（adb connect）
echo  2. 查看已连接设备
echo  3. 启动高德9.x
echo  4. 直接打开巡航（飞屏核心）
echo  5. 授予悬浮窗权限
echo  6. 加入省电白名单（保活）
echo  7. 杀高德进程
echo  8. 一键全部初始化（连接+授权+白名单+开巡航）
echo ===============================
set /p choice=请输入序号后回车:

if "%choice%"=="0" goto end
if "%choice%"=="1" goto connect
if "%choice%"=="2" goto devices
if "%choice%"=="3" goto start_amap
if "%choice%"=="4" goto start_cruise
if "%choice%"=="5" goto grant_overlay
if "%choice%"=="6" goto whitelist
if "%choice%"=="7" goto force_stop
if "%choice%"=="8" goto setup_all
goto menu

:connect
adb connect %CAR_IP%:%CAR_PORT%
goto menu

:devices
adb devices
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
call :connect
timeout /t 2 /nobreak >nul
call :grant_overlay
call :whitelist
call :start_cruise
echo 初始化完成
goto menu

:end
endlocal
