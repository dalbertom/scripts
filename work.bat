pushd %~dp0
set JAVA_HOME6_26="c:\Program Files\Java\jdk1.6.0_26"
set JAVA_HOME6_27="c:\Program Files\Java\jdk1.6.0_27"
set JAVA_HOME6_31="c:\Program Files\Java\jdk1.6.0_31"
if not defined JAVA_HOME set JAVA_HOME=C:\Program Files\Java\jdk1.6.0_31
where /q javac || path %path%;%JAVA_HOME%\bin

if not defined ANT_HOME set ANT_HOME=C:\work\tools\apache-ant-1.8.2
where /q ant || path %path%;%ANT_HOME%\bin

if not defined GIT_HOME set GIT_HOME=C:\work\tools\msysgit\msysgit
where /q git || path %path%;%GIT_HOME%\bin;%GIT_HOME%\mingw\bin;%GIT_HOME%\cmd;%GIT_HOME%\git;%GIT_HOME%\git\contrib

set TERM=msys

if not defined HOME set HOME=%USERPROFILE%
if not exist %HOME%\.ssh\id_rsa ssh-keygen -t rsa

if not defined SVN_HOME set SVN_HOME=C:\Program Files (x86)\CollabNet\Subversion Client
where /q svn || path %path%;%SVN_HOME%\bin

if not defined ARAXIS_HOME set ARAXIS_HOME=c:\Program Files (x86)\Araxis\Araxis Merge v6.5 NSIS
where /q compare || path %path%;%ARAXIS_HOME%

if not defined GROOVY_HOME set GROOVY_HOME=C:\Program Files (x86)\Groovy\Groovy-1.8.4
where /q groovy || path %path%;%GROOVY_HOME%\bin

if not defined M2_HOME set M2_HOME=C:\work\tools\apache-maven-3.0.3
where /q mvn || path %path%;%M2_HOME%\bin

for %%a in (ci
test
ocd
work
util
git
jboss
ssh
proc
display
ant) do call :appendpath %%a

popd
prompt $+$B$D$$$T$H$H$H$G
mode con cols=100 lines=5000
color 17
%*
goto :eof

:appendpath
if exist %1 path %~f1;%path%
goto :eof