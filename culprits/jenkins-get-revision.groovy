import groovy.json.JsonSlurper

def slurper = new JsonSlurper()
def result = slurper.parse(System.in)

//result.changeSet.items*.commitId.each { println it }
result.actions.buildsByBranchName*.values().marked.SHA1.flatten().each { println it }

