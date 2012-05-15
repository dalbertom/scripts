@echo off
setlocal
if not defined job set job=%1
if not defined job set /p job=job=
if not defined JENKINS_URL set JENKINS_URL=%2
if not defined JENKINS_CREDENTIALS set JENKINS_CREDENTIALS=%3
if not defined JENKINS_URL set /p JENKINS_URL=JENKINS_URL=
if not defined JENKINS_CREDENTIALS set /p JENKINS_CREDENTIALS=JENKINS_CREDENTIALS=

echo curl -u "%JENKINS_CREDENTIALS%" -d "" "%JENKINS_URL%/job/%job%/doDelete"

endlocal