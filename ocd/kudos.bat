@echo off
setlocal
set file=%~dpn0.csv
if not exist %file% echo date,time,who,what > %file%
set who=%1
if not defined who set /p who=Who?
set what=%2
if not defined what set /p what=What?
echo %date%,%time%,%who%,%what% >> %file%
echo %file%
endlocal
