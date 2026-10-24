# bookorbit

奇瑞瑞虎7 PLUS Lion5.0 ｜氢桌面 + 高德9.x飞屏配套工具脚本
适配：23款瑞虎7 PLUS 8155车机，Lion5.0原厂系统
高德版本：高德车机版 9.x 包名com.amapauto

⚠️ 不兼容高德16/17手机移植版com.autonavi.minimap，巡航广播不一致，无法飞屏

## 前置要求
1. 车机开启ADB调试，电脑和车机在同一个局域网
2. 氢桌面安装完成，导航源设置选择 com.amapauto
3. 推荐高德版本：9.1，9.5部分版本广播改动，飞屏失效

## ADB命令集合
```bash
# 启动高德9.x
adb shell am start -n com.amapauto/.MainActivity

# 直接打开巡航（飞屏核心）
adb shell am start -n com.amapauto/.cruise.CruiseActivity

# 授予悬浮窗权限（必须，不然飞屏黑屏）
adb shell pm grant com.amapauto android.permission.SYSTEM_ALERT_WINDOW

# 高德加入省电白名单，防止后台被杀
adb shell dumpsys deviceidle whitelist +com.amapauto

# 杀进程（切换版本用）
adb shell am force-stop com.amapauto
adb shell am force-stop com.autonavi.minimap
adb shell am force-stop com.mcar.auto
```

## 常见排错
1. 飞屏空白：确认氢桌面导航源为com.amapauto，重新开巡航
2. 后台被杀：执行白名单保活命令
3. 签名冲突：9.x 和16.x是两个独立包，不能覆盖安装，可以共存
