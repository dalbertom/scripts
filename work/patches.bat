for /d %%a in (%*) do forfiles /p %%a /m *.patch /c "cmd /c patch -p0 -N -E -f < @file"
