call %~dp0exports.bat
set folder=rebase
if exist %folder% rd /s/q %folder%
svn co %current% %folder% --quiet
svn merge %base% %folder% --non-interactive --quiet
svn propget svn:mergeinfo %folder%
REM svn ci %folder% -m "REBASE: From trunk"