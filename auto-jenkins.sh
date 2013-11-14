alias jenkins-curl='curl -s -H "$JENKINS_AUTH"'

# This is meant to be called
# from ~/.profile or ~/.bash_aliases
# to setup the environment variables
# necessary to run other jenkins
# functions
function setup-jenkins {
  export JENKINS_URL=$1
  export JENKINS_AUTH=$2
}

function ci {
  open "$JENKINS_URL/view/$(git-tracking | sed s:/:_:)"
}

function jenkins-views {
  jenkins-curl -g $JENKINS_URL/api/xml?tree=views[name] | xpath "/hudson/view/name" 2>&1 | grep -F "<name>" | sed -E "s:<name>(.*)</name>(-- NODE --)?:\1:"
}

function jenkins-top-list {
  jenkins-views | cut -d _ -f 1 | uniq -c | sort -nr
}

function jenkins-top-list-merged {
  jenkins-views | sed "s:_:/:" \
  | while read i; do 
    git show-ref -q $i && git merge-base --is-ancestor $i $MASTER && echo $i
  done | cut -d / -f 1 | uniq -c | sort -nr
}

function jenkins-jobs {
  view=$1
  jenkins-curl "$JENKINS_URL/view/$view/api/xml" | xpath "/listView/job/name" 2>&1 | grep -F "<name>" | sed -E "s:<name>(.*)</name>(-- NODE --)?:\1:"
}

function jenkins-build {
  job=$1
  jenkins-curl -X POST "$JENKINS_URL/job/$job/build"
}

function jenkins-delete-job {
  job=$1
  jenkins-curl -X POST "$JENKINS_URL/job/$job/doDelete"
}

function jenkins-delete-view {
  view=$1
  jenkins-curl -X POST "$JENKINS_URL/view/$view/doDelete"
}

function jenkins-delete-view-and-jobs {
  view=$1
  jenkins-jobs $view | while read i; do jenkins-delete-job $i; done && jenkins-delete-view $view
}

function jenkins-framework-duration {
  grep -E "Framework \w+ (started|finished)"
}

# Takes the output of consoleText of a job that
# runs JUnit tests and greps for given test suites
# Then it keeps track of how long the test suite
# took to run
function jenkins-testsuite-times {
  testsuite=$1
  grep -A 1 "Testsuite: $testsuite" | awk '
    /Testsuite/ { suite=$3 }
    /Tests run/ { times[suite]=times[suite] "," $11 }
    END { for(key in times) print key times[key] }'
}

function jenkins-testsuite-stats {
  testsuite=$1
  grep -A 1 "Testsuite: $testsuite" | awk '
    BEGIN { print "suite,avg,stddev,min,max,count" }
    /Testsuite/ { suite=$3 }
    /Tests run/ {
      data=$11
      count[suite]++; sum[suite]+=data; sqrsum[suite]+=data*data
      if (min[suite] == "") {
        min[suite] = data
        max[suite] = data
      } else {
        if (min[suite] > data) {
          min[suite] = data
        }
        if (max[suite] < data) {
          max[suite] = data
        }
      }
    }
    END {
      for(key in count) {
        avg=sum[key]/count[key]
        stddev=sqrt(sqrsum[key]/count[key] - avg*avg)
        printf("%s,%f,%f,%f,%f,%i\n", key, avg, stddev, min[key], max[key], count[key])
      }
    }'
}
