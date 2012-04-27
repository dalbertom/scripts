REM call ant -listener ru.jkff.antro.ProfileListener -lib antro-0.52/antro.jar -s build/build.xml %*
call ant -listener net.sf.antcontrib.perf.AntPerformanceListener -s build/build.xml %*