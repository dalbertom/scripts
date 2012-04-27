REM for /f "tokens=*" %%a in ('dir /s/b/a-d *.jar') do @jar tf "%%a" | find "%*" && echo %%a
for /r %2 %%a in (*.jar) do @jar tf %%a | findstr "%1" && echo %%a