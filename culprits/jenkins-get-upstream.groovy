import groovy.json.JsonSlurper

def slurper = new JsonSlurper()
def result = slurper.parse(System.in)

def upstreamBuild = result.actions.causes.upstreamBuild.flatten()
def upstreamUrl = result.actions.causes.upstreamUrl.flatten()

def itBuild = upstreamBuild.iterator()
def itUrl = upstreamUrl.iterator()
def urls = []
while (itBuild.hasNext() && itUrl.hasNext()) {
  urls << itUrl.next() + itBuild.next()
}

urls.each { println it }
