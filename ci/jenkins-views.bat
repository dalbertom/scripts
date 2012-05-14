@echo off
setlocal
if not defined JENKINS_URL set JENKINS_URL=%1
if not defined JENKINS_CREDENTIALS set JENKINS_CREDENTIALS=%2
if not defined JENKINS_URL set /p JENKINS_URL=JENKINS_URL=
if not defined JENKINS_CREDENTIALS set /p JENKINS_CREDENTIALS=JENKINS_CREDENTIALS=

curl --silent -u "%JENKINS_CREDENTIALS%" "%JENKINS_URL%/api/xml?wrapper=name&xpath=/hudson/view/name" | sed -e "s/<name>/\n/g" -e "s:</name>::g"
endlocal