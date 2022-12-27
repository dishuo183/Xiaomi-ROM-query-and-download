@echo off&setlocal enabledelayedexpansion
title 【MIUI刷机包查询下载】   酷安 @狄硕 @DISHUO   QQ:1871549721   交流群：1017879197
set "curl=bin\curl.exe"&set "busybox=bin\busybox.exe"&set "aria2c=bin\aria2c.exe"&set "num=0"
set "code=1" & set "version=2" & set "lx=zip"
:F1
cls&echo.&set /p code="输入你要查询的机型代号（输入0打开代号查询网站）："&echo.
if /i "!code!"=="0" start https://miuiver.com/xiaomi-device-codename/ & goto :F1
if /i "%code%" equ "1" (
echo 非法机型代号，请输入正确的机型代号！
pause >nul & goto :F1 )
set /p version="输入你需要查询的版本："&echo.
if /i "%version%" equ "2" (
echo 非法版本号，请输入正确的版本号！
pause >nul & goto :F1 )
echo 卡刷包是zip 线刷包是tgz 不输入默认卡刷包!&echo.
set /p lx="输入你需要刷机包类型（zip/tgz）："&echo.
if /i "%lx%" neq "zip" (
if /i "%lx%" neq "tgz" (
echo 非法刷机包类型，请输入正确的刷机包类型！
pause >nul & goto :F1 ))
%busybox% rm -rf temp*.txt >nul
%busybox% rm -rf 下载链接.txt >nul

for /f %%b in ('!curl! -s https://xiaomirom.com/series/ ^| !busybox! sed "s/</<\n/g" ^| !busybox! grep "china" ^| !busybox! grep -F -i !code! ^| !busybox! cut -d "=" -f3 ^| !busybox! cut -d " " -f1') do set "DH=%%b"
for /f %%c in ('!curl! -s !DH! ^| !busybox! sed "s/</<\n/g" ^| !busybox! grep -i !lx! ^| !busybox! cut -d ">" -f2 ^| !busybox! cut -d " " -f1 ^| !busybox! grep -F -i "!version!"') do ( echo %%c >> temp.txt )
set "DH1=%DH:~26%"
if not exist temp.txt goto :er

:F2
cls&echo.&echo 找到以下刷机包 输入序号后回车可开始下载&echo.
for /f %%a in (temp.txt) do (
set /a num+=1
echo 【!num!】%%~nxa&echo.
set d!num!=%%~nxa )
set "VS=1"
echo 【0】打印信息到文本文件（不开始下载）&echo.
set num=<nul
set "nx=1"
set /p nx=请选择（默认下载第一个）：
if /i "%nx%"=="0" goto :zd
%busybox% rm -rf temp*.txt >nul
set "link2=!d%nx%!"
for /f %%a in ('echo !link2! ^| !busybox! sed "s/_/\n/g" ^| !busybox! sed -n "3p"') do set "VS=%%a"
if "!VS!"=="1" echo.&echo 找不到此选项，按任意键退出工具！& pause > nul & goto :end
cls&echo.&echo 开始下载!link2!
if exist "%link2%" (
if exist "%link2%.aria2" (
echo.&echo 正在下载文件，下载速度以网速及服务器上的文件决定的1
echo.&echo 下载过程中不要乱点鼠标左键 不然会暂停下载 请按鼠标右键取消暂停&echo.
%aria2c% --max-download-limit=900M -s10 -x10 -j10 -c --check-certificate=false https://bigota.d.miui.com/!VS!/!link2!
echo.&echo 下载完成！按任意键后自动关闭。
) else ( echo.&echo 下载完成！按任意键后自动关闭。)
) else (
echo.&echo 正在下载文件，下载速度以网速及服务器上的文件决定的2
echo.&echo 下载过程中不要乱点鼠标左键 不然会暂停下载 请按鼠标右键取消暂停&echo.
%aria2c% --max-download-limit=900M -s10 -x10 -j10 -c --check-certificate=false https://bigota.d.miui.com/!VS!/!link2!
echo.&echo 下载完成！按任意键后自动关闭。 )
pause >nul & goto :end

:zd
for /f %%a in (temp.txt) do (
echo %%a > temp1.txt
for /f %%b in ('type temp1.txt ^| !busybox! sed "s/_/\n/g" ^| !busybox! sed -n "3p"') do (set VS2=%%b)
echo https://bigota.d.miui.com/!VS2!/%%a>>下载链接.txt)
start 下载链接.txt & goto end

:er
cls&echo.&echo 错误 找不到下载链接！
echo.&echo 可能是你的输入错误，或者是近期发布的刷机包，网站【https://xiaomirom.com/series/】未更新！
echo.&echo ———————————————————————————————————
echo.&echo 查询的机型代号：%code%
echo.&echo 查询的版本：%version%
echo.&echo 刷机包类型：%lx%
echo.&echo 地址：%DH1:~0,-29%
pause >nul

:end
%busybox% rm -rf temp*.txt >nul
taskkill /f /im cmd.exe