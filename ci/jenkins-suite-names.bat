@echo off
setlocal
if not defined job set job=%1
if not defined job set /p job=job=
if not defined JENKINS_URL set JENKINS_URL=%2
if not defined JENKINS_CREDENTIALS set JENKINS_CREDENTIALS=%3
if not defined JENKINS_URL set /p JENKINS_URL=JENKINS_URL=
if not defined JENKINS_CREDENTIALS set /p JENKINS_CREDENTIALS=JENKINS_CREDENTIALS=

curl --silent -u "%JENKINS_CREDENTIALS%" "%JENKINS_URL%/job/%job%/lastCompletedBuild/testReport/api/xml?xpath=testResult/suite/name&wrapper=name" | sed -e "s/<name>/\n/g" -e "s:</name>::g"
