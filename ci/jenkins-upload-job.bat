@echo off
setlocal
if not defined job set job=%1
if not defined job set /p job=job=
if not defined config set config=%2
if not defined config set /p config=config=
if not defined JENKINS_URL set JENKINS_URL=%3
if not defined JENKINS_CREDENTIALS set JENKINS_CREDENTIALS=%4
if not defined JENKINS_URL set /p JENKINS_URL=JENKINS_URL=
if not defined JENKINS_CREDENTIALS set /p JENKINS_CREDENTIALS=JENKINS_CREDENTIALS=

curl -u "%JENKINS_CREDENTIALS%" -d "@%config%" "%JENKINS_URL%/job/%job%/config.xml"
REM curl -u "%JENKINS_CREDENTIALS%" --data-binary "@%config%" -H "Content-Type: application/xml; charset=ISO-8859-1" -H "Accept:text/xml" -X POST "%JENKINS_URL%/job/%job%/config.xml"
REM curl -u "%JENKINS_CREDENTIALS%" -d - -H "Content-Type: text/xml" -H "Accept:text/xml" -X POST "%JENKINS_URL%/job/%job%/config.xml"
REM curl -u "%JENKINS_CREDENTIALS%" -d - -H "Content-Type: text/xml" "%JENKINS_URL%/job/%job%/config.xml"
REM curl -u "%JENKINS_CREDENTIALS%" --data-binary "@%config%" -H "Content-Type: text/xml" "%JENKINS_URL%/job/%job%/config.xml"

endlocal