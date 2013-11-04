GITHUB_URL=https://github.com

function setup-github {
  export GITHUB_TOKEN=$1
  export GITHUB_AGENT=$2
}

function github-curl {
  curl -i -H "Authorization: token $GITHUB_TOKEN" -H "User-Agent: $GITHUB_AGENT" https://api.github.com/$*
}

function github-teams-list {
  org=$1
  github-curl "orgs/$org/teams"
}

function github-notifications {
  open $GITHUB_URL/notifications
}

function github-watching {
  open $GITHUB_URL/watching
}

function github-stars {
  open $GITHUB_URL/stars
}
