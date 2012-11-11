@echo off
setlocal
if not defined job set job=%1
if not defined job set /p job=job=
if not defined JENKINS_URL set JENKINS_URL=%2
if not defined JENKINS_CREDENTIALS set JENKINS_CREDENTIALS=%3
if not defined JENKINS_URL set /p JENKINS_URL=JENKINS_URL=
if not defined JENKINS_CREDENTIALS set /p JENKINS_CREDENTIALS=JENKINS_CREDENTIALS=

REM curl --silent -u "%JENKINS_CREDENTIALS%" "%JENKINS_URL%/job/%job%/lastCompletedBuild/testReport/api/xml?xpath=testResult/suite/case/className&wrapper=className" | sed -e "s/<className>/\n/g" -e "s:</className>::g" | uniq
curl --silent -u "%JENKINS_CREDENTIALS%" "%JENKINS_URL%/job/%job%/lastSuccessfulBuild/testReport/api/xml?xpath=testResult/suite/case/*%%5Bself::name%%20or%%20self::className%%5D&wrapper=name" |sed -e "s/<name>/\x0/g" -e "s/<className>/\x0/g" -e "s:</name>::g" -e "s:</className>::g" | xargs -0 -n 2
REM Completed

