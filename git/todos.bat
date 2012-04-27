@echo off
if not defined upstream set /p upstream=upstream branch: 
for /f "tokens=1,*" %%a in ('git --no-pager diff --ignore-all-space %upstream%.. ^| findstr "^+" ^| findstr "TODO" ^| sort ^| uniq') do @(
  for /f "delims=: tokens=1,2" %%c in ('git --no-pager grep -n --no-color "%%b"') do @(
    echo %%c
    git --no-pager blame HEAD -L %%d,+1 %%c
    echo.
  )
  echo.
)

REM #!/bin/bash
REM bash git --no-pager diff --ignore-all-space $upstream.. | grep "^+" | grep "TODO" | sed "s/+//" | sort | uniq | while read todo; do git --no-pager grep -n --no-color "$todo" | awk -F: '{printf("git --no-pager blame HEAD -L %s,+1 %s\n",$2,$1)}' | sh; done