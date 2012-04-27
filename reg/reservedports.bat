set ports=3343-3343\01098-1099\08080-8080\08083-8083\04444-4444\03873-3873\04713-4713\01090-1090
set reg=HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters /v ReservedPorts /t REG_MULTI_SZ /d

reg add %reg% %ports% /f