@echo off
setlocal
if not defined job set job=%1
if not defined job set /p job=job=
if not defined description set description=%2
if not defined description set /p description=description=
if not defined JENKINS_URL set JENKINS_URL=%3
if not defined JENKINS_CREDENTIALS set JENKINS_CREDENTIALS=%4
if not defined JENKINS_URL set /p JENKINS_URL=JENKINS_URL=
if not defined JENKINS_CREDENTIALS set /p JENKINS_CREDENTIALS=JENKINS_CREDENTIALS=

curl -v -u "%JENKINS_CREDENTIALS%" -F description="%description%" "%JENKINS_URL%/job/%job%/description"
endlocal