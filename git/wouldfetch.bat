@echo off
if not defined upstream set /p upstream=Upstream branch? [origin/master]: 
setlocal
if not defined upstream set upstream=origin/master
git fetch --all --tags --prune --dry-run > output.txt 2>&1
type output.txt
for /f "tokens=1,2" %%a in ('type output.txt ^| findstr /c:".."') do git diff-tree -r --name-only %%a > diffs-branch-%%b.txt
git diff-tree -r --name-only %upstream%.. > diffs-HEAD.txt
findstr /G:diffs-HEAD.txt diffs-branch-*.txt
del output.txt diffs-*.txt
endlocal