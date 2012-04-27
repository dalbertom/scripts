@echo off
setlocal
set args=%*
if not defined args set args=HEAD
for /f %%a in ('git rev-list --merges --grep="pull request" %args%') do (
  git log -1 %%a
  git diff --shortstat "%%a^1"..."%%a^2"
)