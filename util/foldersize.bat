@echo off
setlocal
set file=size%random%.txt
set folder=%~1
if not defined folder set folder=.
dir /s "%folder%" > %file%
for /f "tokens=1 delims=:" %%a in ('findstr /n /c:"Total Files Listed" %file%') do more %file% +%%a
del %file%
endlocal
