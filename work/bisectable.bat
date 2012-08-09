set from=%1
set to=%2
set target=%3

if not defined from set from=@{u}
if not defined to set to=HEAD
if not defined target set target=all-classes

if exist failed.log del failed.log
del build-*.log

for /f %%a in ('git rev-list --reverse --first-parent %from%..%to%') do (
  git checkout %%a
  build -l build-%%a.log %target% || echo %%a >> failed.log
)

if exist failed.log type failed.log