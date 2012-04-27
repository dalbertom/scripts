@echo off
if not ""=="%1" (
  notepad %~dp0\distractions.log
  goto :eof
)
setlocal
set itime=%time%
pause
set /p who=Who? 
set ftime=%time%
echo %who% on %date% from %itime% to %ftime% >> %~dp0\distractions.log

