:: Starts a console with superuser's credentials
REM @echo off
if not defined superuser set /p superuser=superuser? 
if not "%username%"=="%superuser%" runas /user:%superuser%@%USERDNSDOMAIN% "cmd /k %~dp0\%0" & goto :eof
title Super User
mode con cols=150 lines=5000
set prompt=$+$B$D$H$H$H$H$H$$$T$H$H$H$G
cd /d %~dp0
set drive=m
pushd %userprofile%
subst %drive%: "%cd%"
pushd %drive%:
set HOME=/cygdrive/%drive%
popd
popd
subst n: "%cd%"
n:
subst
set HOME