@echo off
if "%1"=="" (
  dir /b %~dp0*.bat
) else (
findstr  /a:0f "^::" "%~dp0%1.bat"
)
