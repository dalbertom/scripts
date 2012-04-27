@echo off
REM set nd=%1
REM for %%a in (%nd:/=\%) do (
REM  if exist %%~dpna (
REM    set nd=%%~dpna
REM  ) else (
REM    set nd=%%~dpa
REM  )
REM )
REM pushd %nd%
REM set nd=

for %%a in (%*) do (
  if exist %%~dpna (
    pushd %%~dpna
  ) else (
    pushd %%~dpa
    echo %%~nxa
  )
)
