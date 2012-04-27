for /f "tokens=2" %%a in ('svn info . ^| find "Revision:"') do set SVN_REVISION=%%a
set TEST_TYPE=%~1
set JBOSS_HOME=
call ant -s build/build.xml ci-setup test-with-reports -Dci=true %~2 %~3 %~4 %~5 %~6 %~7 %~8 %~9

