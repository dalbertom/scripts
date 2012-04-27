@echo off
set /a TTL=8*60*60
ssh-add -l
if ERRORLEVEL 2 for /f "delims=;" %%a in ('ssh-agent -t %TTL%') do set %%a 2> nul
set TTL=
ssh-add
if ERRORLEVEL 1 ssh-add -d
