REM java -Xms2048m -Xmx2048m -jar hudson.war --httpPort=7777 --ajpl3Port=7779
wget --no-clobber http://hudson-ci.org/latest/hudson.war
java -jar hudson.war --httpPort=7777 --ajpl3Port=7779
