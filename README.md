## 主要功能介绍

通过输入小米手机的机型代号和系统版本进行查找刷机包的下载链接

输出下链接或者直接下载

## 原理

通过命令行程序对[XiaomiROM.com](https://xiaomirom.com/series/)网站发出GET请求，输出内容到本地进行文本处理。

## 代号名称查询

通过[小米手机设备代号名称查询](https://miuiver.com/xiaomi-device-codename/)网站进行查询

也可使用adb命令 [adb shell getprop ro.product.name] 进行获取

## 其他说明

默认获取国行版的下载链接 如有其他它需要 自行修改

china/国行版、taiwan/台湾版、global/全球版、europe/欧洲版(欧版)、 india/印度版

zip是卡刷包 tgz是线刷包

## 鸣谢
酷安@TobeSage
