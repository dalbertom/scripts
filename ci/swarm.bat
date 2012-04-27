wget --no-clobber http://maven.dyndns.org/2/org/jvnet/hudson/plugins/swarm-client/1.3/swarm-client-1.3-jar-with-dependencies.jar -O swarm.jar
java -jar swarm.jar -labels sprint -executors 2 -fsroot "%cd%" -description "Added for sprint security" -name %username% %*
