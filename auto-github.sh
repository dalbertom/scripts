GITHUB_URL=https://github.com
GITHUB_API_URL=https://api.github.com

function setup-github {
  export GITHUB_AGENT=$1
}

function github-curl {
  local GITHUB_TOKEN=$(cat ~/.github-token)
#  curl -H "Authorization: token $GITHUB_TOKEN" -H "User-Agent: $GITHUB_AGENT" $*
  curl -H "Authorization: token $GITHUB_TOKEN" -H 'Accept: application/vnd.github.antiope-preview+json' $*
}

function github-curl2 {
  local GITHUB_TOKEN=$(cat ~/.github-token)
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

function github-statuses {
  owner=$1
  repo=$2
  ref=$3
  github-curl "$GITHUB_API_URL/repos/$owner/$repo/statuses/$ref"
}

function github-limit {
  github-curl2 $GITHUB_API_URL/rate_limit
}

function github-keys {
  user=$1
  curl $GITHUB_URL/$user.keys
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
