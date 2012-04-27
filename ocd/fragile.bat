@echo off
setlocal
set file=%~dpn0.csv
if not exist %file% echo date,time,test > %file%
set test=%1
if not defined test set /p test=Test?
findstr "%test%" %file% || echo %date%,%time%,%test% >> %file%
echo %file%
endlocal