set size=
for /f %%a in ('forfiles /s /m *.jar /c "cmd /c echo @fsize"') do @set /a size+=%%a
@echo %size% bytes
@set /a size/=1024
@echo %size% Kbytes
@set /a size/=1024
@echo %size% Mbytes