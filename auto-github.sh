GITHUB_URL=https://github.com
GITHUB_API_URL=https://api.github.com

function setup-github {
  export GITHUB_TOKEN=$1
  export GITHUB_AGENT=$2
}

function github-curl {
  curl -H "Authorization: token $GITHUB_TOKEN" -H "User-Agent: $GITHUB_AGENT" $*
}

function github-curl2 {
  curl -u $GITHUB_TOKEN:x-oauth-basic $*
}

function github-teams-list {
  org=$1
  github-curl "$GITHUB_API_URL/orgs/$org/teams" | python -mjson.tool
}

function github-teams-addmember {
  team=$1
  user=$2
  github-curl -X PUT "$GITHUB_API_URL/teams/$team/members/$user"
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
