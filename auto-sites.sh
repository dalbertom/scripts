function setup-sites {
  export EC2_HOME=$1
  export SITE_USERNAME=$2
  export SITE_LOG_APPSERVER=$3
  export SITE_LOG_AUDIT=$4
  export SITE_DEFAULT_DOMAIN=$5
  export PATH=$EC2_HOME/bin:$PATH
  export EC2_CERT=~/.ssh/aws.crt
  export EC2_PRIVATE_KEY=~/.ssh/aws.key
}

function site-list {
  ec2dtag | awk '/instance.*Name.*site:/ {print $6}' | sort
}

alias qssh='ssh -e none -o StrictHostKeyChecking=no'
function ssh-site {
  hostname=$1
  if [[ "$hostname" != "*.$SITE_DEFAULT_DOMAIN" ]]; then
    hostname=$hostname.$SITE_DEFAULT_DOMAIN
  fi
  shift
  ssh-forget $hostname
  qssh $SITE_USERNAME@$hostname $*
}

function site-exceptions {
  ssh-site $* cat $SITE_LOG_APPSERVER | awk '/Exception/,/^$/ {print $0}'
}

function site-activity {
  ssh-site $* tail -f $SITE_LOG_AUDIT
}
