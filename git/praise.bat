@for /f "delims=: tokens=1,2" %%c in ('git --no-pager grep -n --no-color "%~1"') do @(
  echo %%c
  git --no-pager blame HEAD -L %%d,+1 %%c
  echo.
)