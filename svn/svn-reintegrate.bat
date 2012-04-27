call %~dp0exports.bat
set folder=base
if exist %folder% rd /s/q %folder%
svn co %base% %folder% --quiet
svn merge --reintegrate %current% %folder% --non-interactive --quiet
svn propget svn:mergeinfo %folder%
REM svn ci %folder% -m "REINTEGRATE: from %current%"
REM svn delete %current% -m "Deleted branch after reintegrating to %base%"