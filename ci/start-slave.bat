if not defined HUDSON_URL set HUDSON_URL=http://localhost:7777
wget --no-clobber %HUDSON_URL%/jnlpJars/slave.jar -O slave.jar
setlocal
path %ANT_HOME%\bin;%JAVA_HOME%\bin;%path%
set ANT_OPTS="-Xmx1024m"
set GIT_SSH=ssh.exe
java -jar slave.jar -jnlpUrl %HUDSON_URL%/computer/%COMPUTERNAME%/slave-agent.jnlp