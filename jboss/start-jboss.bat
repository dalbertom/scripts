setlocal
set port=ports-default
if not "%1"=="" set port=%1
run -Djboss.service.binding.set=%port%
