@echo off&setlocal enabledelayedexpansion
title ��MIUIˢ������ѯ���ء�   �ᰲ @��˶ @DISHUO   QQ:1871549721   ����Ⱥ��1017879197
set "curl=bin\curl.exe"&set "busybox=bin\busybox.exe"&set "aria2c=bin\aria2c.exe"&set "num=0"
set "code=1" & set "version=2" & set "lx=zip"
:F1
cls&echo.&set /p code="������Ҫ��ѯ�Ļ��ʹ��ţ�����0�򿪴��Ų�ѯ��վ����"&echo.
if /i "!code!"=="0" start https://miuiver.com/xiaomi-device-codename/ & goto :F1
if /i "%code%" equ "1" (
echo �Ƿ����ʹ��ţ���������ȷ�Ļ��ʹ��ţ�
pause >nul & goto :F1 )
set /p version="��������Ҫ��ѯ�İ汾��"&echo.
if /i "%version%" equ "2" (
echo �Ƿ��汾�ţ���������ȷ�İ汾�ţ�
pause >nul & goto :F1 )
echo ��ˢ����zip ��ˢ����tgz ������Ĭ�Ͽ�ˢ��!&echo.
set /p lx="��������Ҫˢ�������ͣ�zip/tgz����"&echo.
if /i "%lx%" neq "zip" (
if /i "%lx%" neq "tgz" (
echo �Ƿ�ˢ�������ͣ���������ȷ��ˢ�������ͣ�
pause >nul & goto :F1 ))
%busybox% rm -rf temp*.txt >nul
%busybox% rm -rf ��������.txt >nul

for /f %%b in ('!curl! -s https://xiaomirom.com/series/ ^| !busybox! sed "s/</<\n/g" ^| !busybox! grep "china" ^| !busybox! grep -F -i !code! ^| !busybox! cut -d "=" -f3 ^| !busybox! cut -d " " -f1') do set "DH=%%b"
for /f %%c in ('!curl! -s !DH! ^| !busybox! sed "s/</<\n/g" ^| !busybox! grep -i !lx! ^| !busybox! cut -d ">" -f2 ^| !busybox! cut -d " " -f1 ^| !busybox! grep -F -i "!version!"') do ( echo %%c >> temp.txt )
set "DH1=%DH:~26%"
if not exist temp.txt goto :er

:F2
cls&echo.&echo �ҵ�����ˢ���� ������ź�س��ɿ�ʼ����&echo.
for /f %%a in (temp.txt) do (
set /a num+=1
echo ��!num!��%%~nxa&echo.
set d!num!=%%~nxa )
set "VS=1"
echo ��0����ӡ��Ϣ���ı��ļ�������ʼ���أ�&echo.
set num=<nul
set "nx=1"
set /p nx=��ѡ��Ĭ�����ص�һ������
if /i "%nx%"=="0" goto :zd
%busybox% rm -rf temp*.txt >nul
set "link2=!d%nx%!"
for /f %%a in ('echo !link2! ^| !busybox! sed "s/_/\n/g" ^| !busybox! sed -n "3p"') do set "VS=%%a"
if "!VS!"=="1" echo.&echo �Ҳ�����ѡ���������˳����ߣ�& pause > nul & goto :end
cls&echo.&echo ��ʼ����!link2!
if exist "%link2%" (
if exist "%link2%.aria2" (
echo.&echo ���������ļ��������ٶ������ټ��������ϵ��ļ�������1
echo.&echo ���ع����в�Ҫ�ҵ������� ��Ȼ����ͣ���� �밴����Ҽ�ȡ����ͣ&echo.
%aria2c% --max-download-limit=900M -s10 -x10 -j10 -c --check-certificate=false https://bigota.d.miui.com/!VS!/!link2!
echo.&echo ������ɣ�����������Զ��رա�
) else ( echo.&echo ������ɣ�����������Զ��رա�)
) else (
echo.&echo ���������ļ��������ٶ������ټ��������ϵ��ļ�������2
echo.&echo ���ع����в�Ҫ�ҵ������� ��Ȼ����ͣ���� �밴����Ҽ�ȡ����ͣ&echo.
%aria2c% --max-download-limit=900M -s10 -x10 -j10 -c --check-certificate=false https://bigota.d.miui.com/!VS!/!link2!
echo.&echo ������ɣ�����������Զ��رա� )
pause >nul & goto :end

:zd
for /f %%a in (temp.txt) do (
echo %%a > temp1.txt
for /f %%b in ('type temp1.txt ^| !busybox! sed "s/_/\n/g" ^| !busybox! sed -n "3p"') do (set VS2=%%b)
echo https://bigota.d.miui.com/!VS2!/%%a>>��������.txt)
start ��������.txt & goto end

:er
cls&echo.&echo ���� �Ҳ����������ӣ�
echo.&echo ���������������󣬻����ǽ��ڷ�����ˢ��������վ��https://xiaomirom.com/series/��δ���£�
echo.&echo ����������������������������������������������������������������������
echo.&echo ��ѯ�Ļ��ʹ��ţ�%code%
echo.&echo ��ѯ�İ汾��%version%
echo.&echo ˢ�������ͣ�%lx%
echo.&echo ��ַ��%DH1:~0,-29%
pause >nul

:end
%busybox% rm -rf temp*.txt >nul
taskkill /f /im cmd.exe