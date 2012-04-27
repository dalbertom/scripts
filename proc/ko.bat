taskkill /f /im k.exe
taskkill /f /im mysqld.exe
for %%b in (8080 8180 8280 8380) do for /f "tokens=5" %%a in ('netstat -anop tcp ^| find ":%%b" ^| find "LISTENING"') do taskkill /f /pid %%a
%*