if not defined COMMIT_MSG set /p COMMIT_MSG=Commit message prefix: 
git commit -m "%COMMIT_MSG%" %*
git commit --amend
